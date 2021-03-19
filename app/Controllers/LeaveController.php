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
    public $stats;
    public $emp_list;
    public $message;
    private $period = [['01', '15'], ['16', '31'], ['01', '31']];
    private $attendance;
    private $schedule;

    protected function getLeaveRecord($status='', $operation='', $emp_id='') {
        if (($operation == '') && ($emp_id == '')) {
            if ($this->user['is_admin']) {
                $this->all_leave_requests = DB::db('db_master')->fetch_all("SELECT a.*, b.employee_picture, CONCAT(b.last_name,', ',b.first_name,' ',b.middle_name)AS name, d.position_desc, e.leave_desc FROM tbl_emp_leave a, tbl_employee b, tbl_employee_status c, tbl_position d, tbl_leave_type e WHERE a.employee_id = b.no AND c.campus_id = ? AND a.employee_id = c.employee_id AND c.position_id = d.no AND c.is_active = ? AND a.lv_status = ? AND a.lv_type = e.id ORDER BY a.leave_id ASC",[$this->user['campus_id'],1,$status]);

                $this->emp_list[0] = DB::db('db_master')->fetch_all("SELECT a.no, a.employee_picture, CONCAT(a.last_name,', ',a.first_name,' ',a.middle_name)AS name, c.position_desc, d.department_desc FROM tbl_employee a, tbl_employee_status b, tbl_position c, tbl_department d WHERE a.no = b.employee_id AND b.campus_id = ? AND b.position_id = c.no AND c.etype_id = ? AND b.department_id = d.no AND a.no NOT IN (SELECT employee_id FROM tbl_emp_leave_credits) ORDER BY a.last_name ASC",[$this->user['campus_id'],2]);

                $this->emp_list[1] = DB::db('db_master')->fetch_all("SELECT a.no, a.employee_picture, CONCAT(a.last_name,', ',a.first_name,' ',a.middle_name)AS name, b.salary, c.position_desc, d.department_desc, e.vacation, e.sick, e.date_credited FROM tbl_employee a, tbl_employee_status b, tbl_position c, tbl_department d, tbl_emp_leave_credits e WHERE a.no = b.employee_id AND b.campus_id = ? AND b.is_active = ? AND b.position_id = c.no AND c.etype_id < ? AND b.department_id = d.no AND a.no = e.employee_id AND e.is_active = ? ORDER BY a.last_name ASC",[$this->user['campus_id'],1,5,1]);

                $this->emp_list[2] = DB::db('db_master')->fetch_all("SELECT a.no, a.employee_picture, CONCAT(a.last_name,', ',a.first_name,' ',a.middle_name)AS name, b.salary, c.position_desc, d.department_desc, e.vacation, e.sick, e.date_credited FROM tbl_employee a, tbl_employee_status b, tbl_position c, tbl_department d, tbl_emp_leave_credits e WHERE a.no = b.employee_id AND b.campus_id = ? AND b.is_active = ? AND b.position_id = c.no AND c.etype_id = ? AND b.department_id = d.no AND a.no = e.employee_id AND e.is_active = ? ORDER BY a.last_name ASC",[$this->user['campus_id'],1,1,1]);

                for ($i=0,$j=2,$k=1; $i<2; $i++,$j++,$k++) {
                    $this->stats[$i] = DB::db('db_master')->fetch_all("SELECT COUNT(*)as ctr FROM tbl_emp_leave a, tbl_employee_status b WHERE a.lv_status = ? AND a.employee_id = b.employee_id AND b.campus_id = ? AND b.is_active = ?", [$i, $this->user['campus_id'],1])[0];
                    $this->stats[$j] = DB::db('db_master')->fetch_all("SELECT COUNT(*)as ctr FROM tbl_emp_leave a, tbl_employee_status b WHERE a.lv_status < ? AND a.lv_type = ? AND a.employee_id = b.employee_id AND b.campus_id = ? AND b.is_active = ?",[2, $k, $this->user['campus_id'],1])[0];
                }
            } else {
                $this->leave_record = DB::db('db_master')->fetch_all("SELECT * FROM tbl_emp_leave WHERE employee_id = ? ORDER BY leave_id DESC", $this->user['employee_id']);
            }
        } else {
            $this->leave_record = DB::db('db_master')->fetch_all("SELECT * FROM tbl_emp_leave WHERE employee_id = ? ORDER BY leave_id DESC", $emp_id);
        }
    }

    protected function getLeaveCredits ($operation='', $emp_id='') {
        if (($operation == '') && ($emp_id == '')) {
            $this->leave_credits = DB::fetch_row("SELECT * FROM tbl_emp_leave_credits WHERE employee_id = ? AND is_active = ?", [$this->user['employee_id'], 1]);

            if (!$this->leave_credits) {
                if (!$this->user['is_admin']) {
                    $this->view->display ('error_page',["code" => "400", "message" => "Your leave credits are not yet available.", "submessage" => "Sorry, we are still processing your leave information."]);
                } else {
                    $this->leave_credits = ["date_credited" => date('Y-m-d'), "vacation" => 0, "sick" => 0];
                }
            } else {
                if (!$this->user['is_admin']) {
                    $this->leave_balance[0] = ["date" => $this->leave_credits['date_credited'], "vacation" => $this->leave_credits['vacation'], "sick" => $this->leave_credits['sick']];
                }
                //  else {
                //     $this->leave_credits = ["date_credited" => date('Y-m-d'), "vacation" => 0, "sick" => 0];
                // }
            }
        } else {
            $this->leave_credits = DB::fetch_row("SELECT * FROM tbl_emp_leave_credits WHERE employee_id = ? AND is_active = ?", [$emp_id, 1]);
            $this->leave_balance[0] = ["date" => $this->leave_credits['date_credited'], "vacation" => $this->leave_credits['vacation'], "sick" => $this->leave_credits['sick']];
        }
    }

    protected function attendance ($id, $arr, $period = 2) {
        $this->leave_types = DB::db("db_master")->fetch_all("SELECT * FROM tbl_leave_type");
        // $table1 = date_create($arr['from'])->format('m-Y');
        // $table2 = date_create($arr['to'])->format('m-Y');
        // if ($table1 == $table2) {
        //     $tables[] = ["table" => $table1, "begin" => $arr['from'], "end" => $arr['to']];
        // } else {
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
                                $days_counted[$temp][$i] = $attendance[$temp][$i]['date'];
                            } else if (($attendance[$temp][$i]['total_hours'] == 8) && (($attendance[$temp][$i]['am_in'] == "LV:LV") && ($attendance[$temp][$i]['am_out'] == "LV:LV") && ($attendance[$temp][$i]['pm_in'] == "LV:LV") && ($attendance[$temp][$i]['pm_out'] == "LV:LV"))) {
                                $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "On Leave", "total_days" => 1];
                                $days_counted[$temp][$i] = $attendance[$temp][$i]['date'];
                            } else if ($attendance[$temp][$i]['total_hours'] == 8) {
                                $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Present", "total_hours" => $attendance[$temp][$i]['total_hours']];
                                $days_counted[$temp][$i] = $attendance[$temp][$i]['date'];
                            } else if ($attendance[$temp][$i]['is_absent'] == 1) {
                                $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Absent"];
                                $days_counted[$temp][$i] = $attendance[$temp][$i]['date'];
                            }
                        }
                    }
                    $temp++;
                }
                
                if (in_array($dt->format('l'),$this->schedule)) {
                    if (!empty($days_counted[$temp-1])) {
                        if (!(in_array($dt->format('Y-m-d'), $days_counted[$temp-1]))) {
                            if (!empty($this->leave_changes[$temp-1])) {
                                // POPULATES ONLY INDEX 1
                                $this->leave_changes[$temp-1][sizeof($this->leave_changes[$temp-1])] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                            } else {
                                $this->leave_changes[$temp-1][0] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                            }
                        }
                    } else {
                            $this->leave_changes[$temp-1][0] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                            $days_counted[$temp-1][0] = $dt->format('Y-m-d');
                    }
                }
            }
            for ($i=0;$i<sizeof($this->leave_changes);$i++) {
                array_multisort(array_map('strtotime', array_column($this->leave_changes[$i], 'period')), SORT_ASC, $this->leave_changes[$i]);
            }
            $this->leaveBalanceChanges($id,$start_interval,$end_interval);
        // }
        $this->attendance = $attendance;
        return $this;
    }

    protected function leaveBalanceChanges ($id,$start,$end) {
        $emp_leave = DB::db("db_master")->fetch_all("SELECT a.*, b.leave_desc FROM tbl_emp_leave a, tbl_leave_type b WHERE a.employee_id = ? AND a.lv_status = ? AND a.lv_type = b.id AND a.lv_date_fr between ? AND ? ORDER BY a.lv_date_fr ASC", [$id, 2, $start->format('Y-m-d'), $end->format('Y-m-t')]);

        // $size = is_array($this->leave_changes) ? sizeof($this->leave_changes) : 2;
        $size = sizeof($this->leave_changes) == 1 ? 2 : sizeof($this->leave_changes);
        for ($i=1;$i<$size;$i++) {
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
                                case 'Vacation Leave' || 'Mandatory Leave':
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
                                    case 'Vacation Leave' || 'Mandatory Leave':
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
        // $future_emp_leave = DB::db('db_master')->fetch_all("SELECT a.*, b.leave_desc FROM tbl_emp_leave a, tbl_leave_type b WHERE a.lv_type = b.id AND a.lv_status = ? AND a.employee_id = ? AND a.lv_date_fr > ? ORDER BY lv_date_fr ASC", [2,$id,$end->format('Y-m-t')]);

        // if ($future_emp_leave) {
        //     for ($i=0; $i < sizeof($future_emp_leave); $i++) {
        //         $j = sizeof($this->leave_changes);
        //         $k = is_array($this->leave_changes[$j]) ? sizeof($this->leave_changes[sizeof($this->leave_changes[$j])]) : 0;
        //         $days = $future_emp_leave[$i]['lv_no_days'];

        //         if ($days > 1) {
        //             if (date_create($future_emp_leave[$i]['lv_date_fr'])->format('m-Y') != date_create($future_emp_leave[$i]['lv_date_to'])->format('m-Y')) {
        //                 for ($l = 0; $l < $days; $l++) {
        //                     // deduct $this->leave_balance and/or save leave details
        //                 }
        //             } else {
        //                 // deduct $this->leave_balance and/or save leave details
        //             }
        //         } else {
        //             // deduct $this->leave_balance and/or save leave details
        //         }
        //     }
        // }
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
            $this->view->display ('error_page',["code" => "401", "message" => "You have insufficient leave credits.", "submessage" => "Sorry, we cannot process your request because you don't have enough leave credits."]);
            return false;
        }
    }

    protected function set_leave_credits() {
        $checker = DB::db('db_master')->fetch_all("SELECT * FROM tbl_emp_leave_credits WHERE employee_id = ? AND is_active = ?", [$this->data['slc']['employee_id'], 1]);
        if ($checker) {
            DB::db('db_master')->update("UPDATE tbl_emp_leave_credits SET is_active = ? WHERE employee_id = ?", [0,$this->data['slc']['employee_id']]);
        }
        $qry_result = DB::db('db_master')->insert("INSERT INTO tbl_emp_leave_credits SET ". DB::stmt_builder($this->data['slc']),$this->data['slc']);
        $this->message = $qry_result != 0 ? ["result" => "success", "message" => "Leave credits has been successfully saved."] : ["result" => "failed", "message" => "Leave credits was not saved. Please check inputted data and try again."];
        $this->index();
    }

    protected function leaveRecommendation() {
        $remarks = $this->data['remarks'] ? $this->data['remarks'] : '';
        $qry_result = DB::db('db_master')->update("UPDATE tbl_emp_leave SET lv_status = ?, lv_disapproved_reason = ?, lv_hr_id = ? WHERE leave_id = ?",[$this->data['recommendation'], $remarks, $this->data['hr_id'], $this->data['leave_id']]);
        $recommendation = $this->data['recommendation'] == 1 ? 'approved' : 'disapproved';
        $this->message = $qry_result != '' ? ["result" => "success", "message" => "Leave request has been successfully $recommendation."] : ["result" => "failed", "message" => "Leave recommendation was not saved. Please try again."];
        $this->index();
    }

    protected function adminRecommendation() {
        $remarks = $this->data['remarks'] ? $this->data['remarks'] : '';
        DB::db('db_master')->update("UPDATE tbl_emp_leave SET lv_status = ?, lv_disapproved_reason = ?, lv_hr_id = ? WHERE leave_id = ?",[$this->data['recommendation'], $remarks, $this->data['hr_id'], $this->data['leave_id']]);
        $this->index();
    }

    protected function delete_leave() {
        $leave_row = DB::db('db_master')->fetch_all("SELECT * FROM tbl_emp_leave WHERE leave_id = ?",$this->data['id'])[0];
        $data = $leave_row['leave_id'].";".$leave_row['employee_id'].";".$leave_row['lv_dateof_filing'].";".$leave_row['lv_office'].";".$leave_row['lv_type'].";".$leave_row['lv_type_others'].";".$leave_row['lv_where'].";".$leave_row['lv_where_specific'].";".$leave_row['lv_commutation'].";".$leave_row['lv_date_fr'].";".$leave_row['lv_date_to'].";".$leave_row['lv_no_days'].";".$leave_row['emp_salary'].";".$leave_row['lv_recommendation'].";".$leave_row['lv_status'].";".$leave_row['lv_days_with_pay'].";".$leave_row['lv_days_others'].";".$leave_row['lv_approved_others'].";".$leave_row['lv_disapproved_reason'].";".$leave_row['lv_date_requested'];
        $data_array = ["updated_action" => 1, "updated_table" => 'tbl_emp_leave', "updated_old_data" => $data, "updated_new_data" => '', "updated_employee_id" => $leave_row['employee_id'], "updated_admin_id" => 0,"updated_date"=>date("Y-m-d")];

        $archive = DB::db('db_master')->insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($data_array),$data_array);
        $delete = DB::db('db_master')->delete("DELETE FROM tbl_emp_leave WHERE leave_id = ?", $this->data['id']);
        $this->index();
    }

    protected function set_teachers_leave() {
        // $start = new DateTime (date_create('2021-01-01')->format('Y-m-d'));
        // $end = new DateTime (date_create('2021-03-17')->modify('+1 day')->format('Y-m-d'));
        // $interval = new DateInterval('P1D');
        // $range = new DatePeriod($start, $interval, $end);
        // $emp_schedule = DTR::get_sched('6');
        // for ($i=0;$i<sizeof($emp_schedule);$i++) {
        //     $this->schedule[$i] = $emp_schedule[$i]['weekday'];
        // }
        // foreach ($range as $dates) {
        //     if (in_array($dates->format('l'),$this->schedule)) {
        //         $month = $dates->format('m-Y');
        //         $date = $dates->format('Y-m-d');
        //         DB::db('db_attendance')->insert("INSERT INTO `$month` SET emp_id = '6', date='$date', am_in='7:30AM',am_out='12:00PM',pm_in='1:00PM',pm_out='5:00PM',is_absent='0',total_hours='8',late='0'");
        //     }
        // }
        print_r("<pre>");print_r($this->data);print_r("</pre>");
        $start = new DateTime (date_create($this->data['tl']['lv_date_fr'])->format('Y-m-d'));
        $end = new DateTime (date_create($this->data['tl']['lv_date_to'])->modify('+1 day')->format('Y-m-d'));
        $interval = new DateInterval('P1D');
        $leave_range = new DatePeriod($start, $interval, $end);

        if (($this->data['tl']['employee_id'] == 0) && ($this->data['tl']['emp_salary'] == 0) && ($this->data['tl']['lv_office'] == 0)) {
            $teacher_ids = DB::db('db_master')->fetch_all("SELECT a.no, CONCAT(a.last_name,', ',a.first_name,' ',a.middle_name)AS name, d.department_desc, b.salary FROM tbl_employee a, tbl_employee_status b, tbl_position c, tbl_department d WHERE a.no = b.employee_id AND b.campus_id = ? AND b.position_id = c.no AND c.etype_id = ? AND b.department_id = d.no", [$this->user['campus_id'], 1]);
            $temp=0;
            foreach ($teacher_ids as $teacher) {
                $this->data['tl']['employee_id'] = $teacher['no'];
                $this->data['tl']['emp_salary'] = $teacher['salary'];
                $this->data['tl']['lv_office'] = $teacher['department_desc'];
                DB::db('db_master')->insert("INSERT INTO tbl_emp_leave SET " . DB::stmt_builder($this->data['tl']),$this->data['tl']);
                $emp_schedule = DTR::get_sched($teacher['no']);
                for ($i=0;$i<sizeof($emp_schedule);$i++) {
                    $this->schedule[$i] = $emp_schedule[$i]['weekday'];
                }
                foreach ($leave_range as $dates) {
                    if (in_array($dates->format('l'),$this->schedule)) {
                        $dtr_input = self::attendance_event($teacher['no'], $dates->format('Y-m-d'), '00:00', '23:59');
                        
                        if ($dtr_input != '') {
                            $failed_inputs[$temp] = $teacher['name'] . " on " . $dates->format('Y-m-d');
                            $temp++;
                        }
                    }
                }
            }
            if ($failed_inputs[0] != '') {
                $this->message = ["result" => "failed", "message" => "Teacher's leave was not processed for the following employees on the following dates:"];
                foreach ($failed_inputs as $failed) {
                    $this->message["message"] .= "\n$failed";
                }
                $this->message["message"] .= "\nPlease check their data and try again.";
                $this->index ();
            } else {
                $this->message = ["result" => "success", "message" => "Teacher's leave was successfully set for all teachers."];
                $this->index();
            }
        } else {
            DB::db('db_master')->insert("INSERT INTO tbl_emp_leave SET " . DB::stmt_builder($this->data['tl']),$this->data['tl']);
            $emp_schedule = DTR::get_sched($this->data['tl']['employee_id']);
            for ($i=0;$i<sizeof($emp_schedule);$i++) {
                $this->schedule[$i] = $emp_schedule[$i]['weekday'];
            }
            foreach ($leave_range as $dates) {
                if (in_array($dates->format('l'),$this->schedule)) {
                    $dtr_input = self::attendance_event($this->data['tl']['employee_id'], $dates->format('Y-m-d'), '00:00', '23:59');
                }
            }
            if ($dtr_input != '') {
                $this->message = ["result" => "failed", "message" => "Teacher's leave was not placed. Please check the employee's data and try again."];
            } else {
                $this->message = ["result" => "success", "message" => "Teacher's leave was successfully set."];
            }
            $this->index();
        }
    }

    protected function set_forced_leave() {
        $from = new DateTime (date_create($this->data['fl']['lv_date_fr'])->format('Y-m-d'));
        $to = new DateTime (date_create($this->data['fl']['lv_date_to'])->modify('+1 day')->format('Y-m-d'));
        $diff = date_diff($from,$to)->format("%d");
        if ($diff > $this->data['vl_credits']) {
            $this->message = ["result" => "failed", "message" => "Insufficient vacation leave credit."];
            $this->index ();
        } else {
            $this->data['fl']['lv_dateof_filing'] = date('Y-m-d');
            $this->data['fl']['lv_type'] = 13;
            $this->data['fl']['lv_status'] = 2;
            if ($this->data['fl']['lv_date_fr'] != $this->data['fl']['lv_date_to']) {
                $start = new DateTime(date_create($this->data['fl']['lv_date_fr'])->format('Y-m-d'));
                $end = new DateTime(date_create($this->data['fl']['lv_date_to'])->modify('+1 day')->format('Y-m-d'));
                $interval = new DateInterval('P1D');
                $leave_range = new DatePeriod($start, $interval, $end);
                $emp_schedule = DTR::get_sched($this->data['fl']['employee_id']);
                for ($i=0;$i<sizeof($emp_schedule);$i++) {
                    $this->schedule[$i] = $emp_schedule[$i]['weekday'];
                }
                $this->data['fl']['lv_no_days'] = 0;
                foreach ($leave_range as $dates) {
                    if (in_array($dates->format('l'),$this->schedule)) {
                        $result[$this->data['fl']['lv_no_days']] = self::attendance_event($this->data['fl']['employee_id'], $dates->format('Y-m-d'), '00:00', '23:59');
                        $this->data['fl']['lv_no_days']++;
                    }
                }
            } else { 
                $result[$this->data['fl']['lv_no_days']] = self::attendance_event($this->data['fl']['employee_id'], $dates->format('Y-m-d'), '00:00', '23:59');
                $this->data['fl']['lv_no_days'] = 1;
            }
            foreach ($result as $value) {
                if ($value != '') {
                    $this->message = ["result" => "failed", "message" => "Forced leave cannot be processed. Please check your data and try again later."];
                    $this->index ();
                }
            }
            $qry_emp_lv = DB::db('db_master')->insert("INSERT INTO tbl_emp_leave SET ". DB::stmt_builder($this->data['fl']),$this->data['fl']);
            if ($qry_emp_lv == 0) {
                $this->message = ["result" => "failed", "message" => "Forced leave cannot be processed. Please check your data and try again."];
                $this->index ();
            }
        }
        $this->message = ["result" => "success", "message" => "Forced leave has been processed successfully."];
        $this->index ();
    }
    
    public function attendance_event($id, $date, $start, $end) {
        $monthtable = date_create($date)->format('m-Y');
        $date = date_create($date)->format('Y-m-d');
        
        $date_logs = DB::db('db_attendance')->fetch_all("SELECT * FROM `$monthtable` WHERE emp_id = ? AND date = ?",[$id,$date])[0];
        if (!$date_logs) {
            $create = DTR::create_table($monthtable);
        }

        $log_id = $date_logs ? $date_logs['id'] : '';
        $change_logs = DTR::change_log($id, ['LV:LV','LV:LV','LV:LV','LV:LV'], $monthtable, $date, $log_id);
        return $change_logs;
    }
}