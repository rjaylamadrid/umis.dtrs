<?php
namespace Controllers;

use Database\DB;
use Model\DTR;
use DateTime;
use DateInterval;
use DatePeriod;

class LeaveController extends Controller {
    public $leave_record;
    public $leave_credits;
    public $leave_changes;
    public $leave_balance = ["0" => ["vacation" => 0, "sick" => 0]];
    public $leave_types;
    public $all_leave_requests;
    private $period = [['01', '15'], ['16', '31'], ['01', '31']];
    private $attendance;
    private $schedule;

    protected function getLeaveRecord() {
        $this->leave_record = DB::db('db_master')->fetch_all("SELECT * FROM tbl_emp_leave WHERE employee_id = ? ORDER BY leave_id DESC", $this->user['employee_id']);
        if ($this->user['is_admin']) {
            $this->all_leave_requests = DB::db('db_master')->fetch_all("SELECT a.*, b.employee_picture, CONCAT(b.last_name,', ',b.first_name,' ',b.middle_name)AS name, d.position_desc, e.leave_desc FROM tbl_emp_leave a, tbl_employee b, tbl_employee_status c, tbl_position d, tbl_leave_type e WHERE a.employee_id = b.no AND a.employee_id = c.employee_id AND c.position_id = d.no AND c.is_active = 1 AND a.lv_type = e.id ORDER BY a.leave_id ASC");
        }
    }

    protected function getLeaveCredits () {
        $this->leave_credits = DB::fetch_row("SELECT * FROM tbl_emp_leave_credits WHERE employee_id = ? AND is_active = ?", [$this->user['employee_id'], 1]);
        $this->leave_balance[0] = ["date" => $this->leave_credits['date_credited'], "vacation" => $this->leave_credits['vacation'], "sick" => $this->leave_credits['sick']];
    }

    protected function getLeaveChanges () {
        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod(date_create($this->leave_credits['date_credited']), $interval, date_create('2021-01-29'));
        $sched = DTR::get_sched($this->user['employee_id']);
        foreach ($daterange as $date) {
            $monthtable = date_create($this->leave_credits['date_credited'])->format('m-Y');
            $attendance = DB::db("db_attendance")->fetch_all("SELECT * FROM $monthtable WHERE emp_id = ? AND date > ?", [$this->user['employee_id'], $this->leave_credits['date_credited']]);
        }
    }

    protected function computeLeaveCredits($id, $date_start) {
        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod($date_start, $interval ,$date_start->modify('+30 day'));
    }

    protected function attendance ($id, $arr, $period = 2) {
        $this->leave_types = DB::db("db_master")->fetch_all("SELECT * FROM tbl_leave_type");
        $table1 = date_create($arr['from'])->format('m-Y');
        $table2 = date_create($arr['to'])->format('m-Y');
        if ($table1 == $table2) {
            $tables[] = ["table" => $table1, "begin" => $arr['from'], "end" => $arr['to']];
        } else {
            $start_interval = new DateTime(date_create($arr['from'])->format('Y-m-d'));
            $interval = new DateInterval('P1D');
            $emp_schedule = DTR::get_sched($id);
            for ($i=0;$i<sizeof($emp_schedule);$i++) {
                $this->schedule[$i] = $emp_schedule[$i]['weekday'];
            }
            $temp=0;
            $end_interval = new DateTime(date_create($arr['to'])->format('Y-m-d'));
            $daterange = new DatePeriod($start_interval, $interval, $end_interval);
            foreach ($daterange as $dt) {
                if ($dt->format('d') == $start_interval->format('d')) {
                    $monthtable[$temp] = $dt->format('m-Y');
                    $attendance[$temp] = DB::db("db_attendance")->fetch_all("SELECT * FROM `$monthtable[$temp]` WHERE emp_id = ? AND date > ? ORDER BY date ASC", [$id, $this->leave_credits['date_credited']]);
                    if ($attendance[$temp]) {
                        for ($i=0;$i<sizeof($attendance[$temp]);$i++) {
                            if (($attendance[$temp][$i]['total_hours'] < 8) && ($attendance[$temp][$i]['total_hours'] > 0) && ($attendance[$temp][$i]['is_absent'] != 1)) {
                                $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Undertime", "total_hours" => $attendance[$temp][$i]['total_hours']];
                                $days_present[$temp][$i] = $attendance[$temp][$i]['date'];
                            } else if (($attendance[$temp][$i]['total_hours'] == 8) && (($attendance[$temp][$i]['am_in'] == "VL:VL") && ($attendance[$temp][$i]['am_out'] == "VL:VL") && ($attendance[$temp][$i]['pm_in'] == "VL:VL") && ($attendance[$temp][$i]['pm_out'] == "VL:VL"))) {
                                $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "On Leave", "total_days" => 1];
                                $days_present[$temp][$i] = $attendance[$temp][$i]['date'];
                            } else if ($attendance[$temp][$i]['total_hours'] == 8) {
                                $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Present", "total_hours" => $attendance[$temp][$i]['total_hours']];
                                $days_present[$temp][$i] = $attendance[$temp][$i]['date'];
                            }
                        }
                    }
                    $temp++;
                }
                
                if (in_array($dt->format('l'),$this->schedule)) {
                    if (!empty($days_present[$temp-1])) {
                        if (!(in_array($dt->format('Y-m-d'), $days_present[$temp-1]))) {
                            if (is_array($this->leave_changes[$temp-1])) {
                                $this->leave_changes[$temp-1][sizeof($this->leave_changes[$temp-1])] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                            } else {
                                $this->leave_changes[$temp-1][0] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                            }
                        }
                    } else {
                        $this->leave_changes[$temp-1][0] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                        $days_present[$temp-1][0] = $dt->format('Y-m-d');
                    }
                }
            }
            for ($i=0;$i<sizeof($this->leave_changes);$i++) {
                array_multisort(array_map('strtotime', array_column($this->leave_changes[$i], 'period')), SORT_ASC, $this->leave_changes[$i]);
            }
        }
        $this->leaveBalanceChanges($id,$start_interval,$end_interval);
        $this->attendance = $attendance;
        return $this;
    }

    protected function leaveBalanceChanges ($id,$start,$end) {
        $emp_leave = DB::db("db_master")->fetch_all("SELECT a.*, b.leave_desc FROM tbl_emp_leave a, tbl_leave_type b WHERE a.employee_id = ? AND a.lv_status = ? AND a.lv_type = b.id AND a.lv_date_fr between ? AND ? ORDER BY a.lv_date_fr ASC", [$id, 2, $start->format('Y-m-d'), $end->format('Y-m-t')]);

        for ($i=1;$i<sizeof($this->leave_changes);$i++) {
            $v_bal = $this->leave_balance[$i-1]['vacation'];
            $s_bal = $this->leave_balance[$i-1]['sick'];
            
            for ($j=0;$j<sizeof($this->leave_changes[$i-1]);$j++) {
                $leave_deduction = in_array(date_create($this->leave_changes[$i-1][$j]['period'])->format('l'), $this->schedule) ? 0.0416666666666667 : 0.0625000000000001;
                
                if ($this->leave_changes[$i-1][$j]['particulars'] == 'Absent') {
                    $this->leave_balance[$i-1]['vacation'] >= 1 ? $this->leave_changes[$i-1][$j]['v_awp'] = 1 : $this->leave_changes[$i-1][$j]['v_awop'] = 1;
                    $this->leave_changes[$i-1][$j]['v_bal'] = $v_bal - 1;
                    $v_bal -= 1;
                    $this->leave_balance[$i]['vacation'] -= 1;
                } else if ($this->leave_changes[$i-1][$j]['particulars'] == 'Undertime') {
                    $actual_service = $this->leave_changes[$i-1][$j]['total_hours'] * .125;
                    if (($actual_service > .25) && ($actual_service < .75)) { $earned = .5; } else if ($actual_service >= .75) { $earned = 1; } else { $earned = 0; }
                    $this->leave_changes[$i-1][$j]['v_earned'] = $earned * $leave_deduction;
                    $this->leave_changes[$i-1][$j]['s_earned'] = $earned * $leave_deduction;
                    $v_bal >= 1-$actual_service ? $this->leave_changes[$i-1][$j]['v_awp'] = 1-$actual_service : $this->leave_changes[$i-1][$j]['v_awop'] = 1-$actual_service;
                    $this->leave_changes[$i-1][$j]['v_bal'] = $v_bal + ($earned * $leave_deduction);
                    $v_bal += ($earned * $leave_deduction);
                    $s_bal += ($earned * $leave_deduction);
                    $this->leave_balance[$i]['vacation'] += ($earned * $leave_deduction);
                    $this->leave_balance[$i]['sick'] += ($earned * $leave_deduction);
                } else if ($this->leave_changes[$i-1][$j]['particulars'] == 'On Leave') {
                    foreach ($emp_leave as $leave_info) {
                        if ((date_create($leave_info['lv_date_fr'])->format('Y-m-d') <= date_create($this->leave_changes[$i-1][$j]['period'])->format('Y-m-d')) && (date_create($leave_info['lv_date_to'])->format('Y-m-d') >= date_create($this->leave_changes[$i-1][$j]['period'])->format('Y-m-d'))) {
                            switch ($leave_info['leave_desc']) {
                                case 'Vacation Leave':
                                    $v_bal >= 1 ? $this->leave_changes[$i-1][$j]['v_awp'] = 1 : $this->leave_changes[$i-1][$j]['v_awop'] = 1; 
                                    $this->leave_changes[$i-1][$j]['v_bal'] = $v_bal - 1;
                                    $v_bal -= 1;
                                    $this->leave_changes[$i-1][$j]['action'] = $leave_info['lv_recommendation'] .' on '. date_create($leave_info['lv_date_requested'])->format('M d, Y');
                                    $this->leave_balance[$i]['vacation'] -= $this->leave_changes[$i-1][$j]['total_days'];
                                    break;
                                case 'Sick Leave':
                                    $s_bal >= 1 ? $this->leave_changes[$i-1][$j]['s_awp'] = 1 : $this->leave_changes[$i-1][$j]['s_awop'] = 1; 
                                    $this->leave_changes[$i-1][$j]['s_bal'] = $s_bal - 1;
                                    $s_bal -= 1;
                                    $this->leave_changes[$i-1][$j]['action'] = $leave_info['lv_recommendation'] .' on '. date_create($leave_info['lv_date_requested'])->format('M d, Y');
                                    $this->leave_balance[$i]['sick'] -= $this->leave_changes[$i-1][$j]['total_days'];
                                    break;
                            }
                        }
                    }
                } else if ($this->leave_changes[$i-1][$j]['particulars'] == 'Present') {
                    $this->leave_changes[$i-1][$j]['v_earned'] = $leave_deduction;
                    $this->leave_changes[$i-1][$j]['s_earned'] = $leave_deduction;
                    $this->leave_changes[$i-1][$j]['v_bal'] = $v_bal + $leave_deduction;
                    $this->leave_changes[$i-1][$j]['s_bal'] = $s_bal + $leave_deduction;

                    $this->leave_balance[$i]['vacation'] += $leave_deduction;
                    $this->leave_balance[$i]['sick'] += $leave_deduction;
                    $v_bal += $leave_deduction;
                    $s_bal += $leave_deduction;
                }
            }
            if ($i < sizeof($this->leave_changes)) {
                $this->leave_balance[$i] = ["date" => date_create($this->leave_balance[$i-1]['date'])->modify('+1 month')->format('Y-m-d'), "vacation" => ($this->leave_balance[$i]['vacation'] + $this->leave_balance[$i-1]['vacation']), "sick" => ($this->leave_balance[$i]['sick'] + $this->leave_balance[$i-1]['sick'])];
            }
            if ($i == sizeof($this->leave_changes) - 1) {
                $v_bal = $this->leave_balance[$i]['vacation'];
                $s_bal = $this->leave_balance[$i]['sick'];
                for ($j=0;$j<sizeof($this->leave_changes[$i]);$j++) {
                    $leave_deduction = in_array(date_create($this->leave_changes[$i][$j]['period'])->format('l'), $this->schedule) ? 0.0416666666666667 : 0.0625000000000001;
                    
                    if ($this->leave_changes[$i][$j]['particulars'] == 'Absent') {
                        $this->leave_balance[$i]['vacation'] >= 1 ? $this->leave_changes[$i][$j]['v_awp'] = 1 : $this->leave_changes[$i][$j]['v_awop'] = 1;
                        $this->leave_changes[$i][$j]['v_bal'] = $v_bal - 1;
                        $v_bal -= 1;
                        $this->leave_balance[$i+1]['vacation'] -= 1;
                    } else if ($this->leave_changes[$i][$j]['particulars'] == 'Undertime') {
                        $actual_service = $this->leave_changes[$i][$j]['total_hours'] * .125;
                        if (($actual_service > .25) && ($actual_service < .75)) { $earned = .5; } else if ($actual_service >= .75) { $earned = 1; } else { $earned = 0; }
                        $this->leave_changes[$i][$j]['v_earned'] = $earned * $leave_deduction;
                        $this->leave_changes[$i][$j]['s_earned'] = $earned * $leave_deduction;
                        $v_bal >= 1-$actual_service ? $this->leave_changes[$i][$j]['v_awp'] = 1-$actual_service : $this->leave_changes[$i][$j]['v_awop'] = 1-$actual_service;
                        $this->leave_changes[$i][$j]['v_bal'] = $v_bal + ($earned * $leave_deduction);
                        $v_bal += ($earned * $leave_deduction);
                        $s_bal += ($earned * $leave_deduction);
                        $this->leave_balance[$i+1]['vacation'] += ($earned * $leave_deduction);
                        $this->leave_balance[$i+1]['sick'] += ($earned * $leave_deduction);
                    } else if ($this->leave_changes[$i][$j]['particulars'] == 'On Leave') {
                        foreach ($emp_leave as $leave_info) {
                            if ((date_create($leave_info['lv_date_fr'])->format('Y-m-d') <= date_create($this->leave_changes[$i][$j]['period'])->format('Y-m-d')) && (date_create($leave_info['lv_date_to'])->format('Y-m-d') >= date_create($this->leave_changes[$i][$j]['period'])->format('Y-m-d'))) {
                                switch ($leave_info['leave_desc']) {
                                    case 'Vacation Leave':
                                        $v_bal >= 1 ? $this->leave_changes[$i][$j]['v_awp'] = 1 : $this->leave_changes[$i][$j]['v_awop'] = 1; 
                                        $this->leave_changes[$i][$j]['v_bal'] = $v_bal - 1;
                                        $v_bal -= 1;
                                        $this->leave_changes[$i][$j]['action'] = $leave_info['lv_recommendation'] .' on '. date_create($leave_info['lv_date_requested'])->format('M d, Y');
                                        $this->leave_balance[$i+1]['vacation'] -= $this->leave_changes[$i][$j]['total_days'];
                                        break;
                                    case 'Sick Leave':
                                        $s_bal >= 1 ? $this->leave_changes[$i][$j]['s_awp'] = 1 : $this->leave_changes[$i][$j]['s_awop'] = 1; 
                                        $this->leave_changes[$i][$j]['s_bal'] = $s_bal - 1;
                                        $s_bal -= 1;
                                        $this->leave_changes[$i][$j]['action'] = $leave_info['lv_recommendation'] .' on '. date_create($leave_info['lv_date_requested'])->format('M d, Y');
                                        $this->leave_balance[$i+1]['sick'] -= $this->leave_changes[$i][$j]['total_days'];
                                        break;
                                }
                            }
                        }
                    } else if ($this->leave_changes[$i][$j]['particulars'] == 'Present') {
                        $this->leave_changes[$i][$j]['v_earned'] = $leave_deduction;
                        $this->leave_changes[$i][$j]['s_earned'] = $leave_deduction;
                        $this->leave_changes[$i][$j]['v_bal'] = $v_bal + $leave_deduction;
                        $this->leave_changes[$i][$j]['s_bal'] = $s_bal + $leave_deduction;

                        $this->leave_balance[$i+1]['vacation'] += $leave_deduction;
                        $this->leave_balance[$i+1]['sick'] += $leave_deduction;
                        $v_bal += $leave_deduction;
                        $s_bal += $leave_deduction;
                    }
                }

                $this->leave_balance[$i+1] = ["vacation" => ($this->leave_balance[$i]['vacation'] + $this->leave_balance[$i+1]['vacation']), "sick" => ($this->leave_balance[$i]['sick'] + $this->leave_balance[$i+1]['sick'])];
            }
        }
    }
    
    protected function submitLeave() {
        if ($this->data['leave_info']['lv_no_days'] > 1) {
            $start = new DateTime(date_create($this->data['leave_info']['lv_date_fr'])->format('Y-m-d'));
            $end = new DateTime(date_create($this->data['leave_info']['lv_date_to'])->modify('+1 day')->format('Y-m-d'));
            $interval = new DateInterval('P1D');
            $leave_range = new DatePeriod($start, $interval, $end);
            $emp_schedule = DTR::get_sched($this->data['leave_info']['employee_id']);
            for ($i=0;$i<sizeof($emp_schedule);$i++) {
                $this->schedule[$i] = $emp_schedule[$i]['weekday'];
            }
            $this->data['leave_info']['lv_no_days'] = 0;
            foreach ($leave_range as $dates) {
                in_array($dates->format('l'),$this->schedule) ? $this->data['leave_info']['lv_no_days']++ : '';
            }
        }
        if ((($this->data['leave_info']['lv_type'] == 1) && ($this->data['leave_info']['lv_no_days'] <= $this->data['vl_credits'])) || (($this->data['leave_info']['lv_type'] == 2) && ($this->data['leave_info']['lv_no_days'] <= $this->data['sl_credits']))) {
            $result = DB::db('db_master')->insert("INSERT INTO tbl_emp_leave SET ". DB::stmt_builder($this->data['leave_info']),$this->data['leave_info']);
            header ("location: /leave");
        } else {
            // ADD ERROR NOT ENOUGH BALANCE
            header ("location: /leave");
        }
    }

    protected function leaveRecommendation() {
        $remarks = $this->data['remarks'] ? $this->data['remarks'] : '';
        DB::db('db_master')->update("UPDATE tbl_emp_leave SET lv_status = ?, lv_disapproved_reason = ?, lv_hr_id = ? WHERE leave_id = ?",[$this->data['recommendation'], $remarks, $this->data['hr_id'], $this->data['leave_id']]);
        $this->index();
        // DB::db('db_master')->update("",[])
    }

    protected function delete_leave() {
        $leave_row = DB::db('db_master')->fetch_all("SELECT * FROM tbl_emp_leave WHERE leave_id = ?",$this->data['id'])[0];
        $data = $leave_row['leave_id'].";".$leave_row['employee_id'].";".$leave_row['lv_dateof_filing'].";".$leave_row['lv_office'].";".$leave_row['lv_type'].";".$leave_row['lv_type_others'].";".$leave_row['lv_where'].";".$leave_row['lv_where_specific'].";".$leave_row['lv_commutation'].";".$leave_row['lv_date_fr'].";".$leave_row['lv_date_to'].";".$leave_row['lv_no_days'].";".$leave_row['emp_salary'].";".$leave_row['lv_recommendation'].";".$leave_row['lv_status'].";".$leave_row['lv_days_with_pay'].";".$leave_row['lv_days_others'].";".$leave_row['lv_approved_others'].";".$leave_row['lv_disapproved_reason'].";".$leave_row['lv_date_requested'];
        $data_array = ["updated_action" => 1, "updated_table" => 'tbl_emp_leave', "updated_old_data" => $data, "updated_new_data" => '', "updated_employee_id" => $leave_row['employee_id'], "updated_admin_id" => 0,"updated_date"=>date("Y-m-d")];

        $archive = DB::db('db_master')->insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($data_array),$data_array);
        $delete = DB::db('db_master')->delete("DELETE FROM tbl_emp_leave WHERE leave_id = ?", $this->data['id']);
        $this->index();
    }
}