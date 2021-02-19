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
    private $period = [['01', '15'], ['16', '31'], ['01', '31']];
    private $attendance;
    private $schedule;

    protected function getLeaveRecord() {
        $this->leave_record = DB::fetch_all("SELECT * FROM tbl_emp_leave WHERE employee_id = ? ORDER BY lv_date_fr DESC", $this->user['employee_id']);
    }

    protected function getLeaveCredits () {
        $this->leave_credits = DB::fetch_row("SELECT * FROM tbl_emp_leave_credits WHERE employee_id = ? AND is_active = ?", [$this->user['employee_id'], 1]);
        $this->leave_balance[0] = ["date" => $this->leave_credits['date_credited'], "vacation" => $this->leave_credits['vacation'], "sick" => $this->leave_credits['sick']];
        // print_r($this->leave_balance);
    }

    protected function getLeaveChanges () {
        // loop and get attendance first
        // $this->leave_changes = self::attendance($this->user['employee_id'], ["from" => $this->leave_credits['date_credited'], "to" => '2021-01-01'], 2);

        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod(date_create($this->leave_credits['date_credited']), $interval, date_create('2021-01-29'));
        $sched = DTR::get_sched($this->user['employee_id']);
        foreach ($daterange as $date) {
            $monthtable = date_create($this->leave_credits['date_credited'])->format('m-Y');
            $attendance = DB::db("db_attendance")->fetch_all("SELECT * FROM $monthtable WHERE emp_id = ? AND date > ?", [$this->user['employee_id'], $this->leave_credits['date_credited']]);
        }
        // print_r("<pre>");
        // print_r($sched);
        // print_r("</pre>");
    }

    protected function computeLeaveCredits($id, $date_start) {
        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod($date_start, $interval ,$date_start->modify('+30 day'));
    }

    protected function attendance ($id, $arr, $period = 2) { //change $arr to date_started
        $table1 = date_create($arr['from'])->format('m-Y');
        $table2 = date_create($arr['to'])->format('m-Y'); //change $arr['to'] to current date
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
                    // LOOP ATTENDANCE AND STORE ABSENCES, UNDERTIME AND PRESENT DATES TO $this->leave_changes AND $days_present
                    if ($attendance[$temp]) {
                        for ($i=0;$i<sizeof($attendance[$temp]);$i++) {
                            if (($attendance[$temp][$i]['total_hours'] < 8) && ($attendance[$temp][$i]['total_hours'] > 0) && ($attendance[$temp][$i]['is_absent'] != 1)) {
                                $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Undertime", "total_hours" => $attendance[$temp][$i]['total_hours']];
                                $days_present[$temp][$i] = $attendance[$temp][$i]['date'];
                            // } else if (($attendance[$temp][$i]['total_hours'] == 0) && ($attendance[$temp][$i]['is_absent'] == 1)) {
                            //     $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Absent"];
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
            // print_r("<pre>");
            // print_r($days_present);
            // print_r("</pre>");
        }
        $this->leaveBalanceChanges($id,$start_interval,$end_interval);
        $this->attendance = $attendance;
        return $this;
    }

    protected function leaveBalanceChanges ($id,$start,$end) {
        // ADD CONDITION CHECKING IF THERE IS ENOUGH BALANCE
        // $this->leave_types = DB::db("db_master")->fetch_all("SELECT * FROM tbl_leave_type ORDER BY id ASC");
        $emp_leave = DB::db("db_master")->fetch_all("SELECT a.*, b.leave_desc FROM tbl_emp_leave a, tbl_leave_type b WHERE a.employee_id = ? AND a.lv_status = ? AND a.lv_type = b.id AND a.lv_date_fr between ? AND ? ORDER BY a.lv_date_fr ASC", [$id, 2, $start->format('Y-m-d'), $end->format('Y-m-t')]);

        for ($i=1;$i<sizeof($this->leave_changes);$i++) {
            $v_bal = $this->leave_balance[$i-1]['vacation'];
            $s_bal = $this->leave_balance[$i-1]['sick'];
            

            // print_r("<pre>");
            // print_r($emp_leave);
            // print_r("</pre>");
            
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
                                    $this->leave_balance[$i]['vacation'] -= $this->leave_changes[$i-1][$j]['total_days'];
                                    break;
                                case 'Sick Leave':
                                    $s_bal >= 1 ? $this->leave_changes[$i-1][$j]['v_awp'] = 1 : $this->leave_changes[$i-1][$j]['v_awop'] = 1; 
                                    $this->leave_changes[$i-1][$j]['v_bal'] = $s_bal - 1;
                                    $s_bal -= 1;
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
                                        $this->leave_balance[$i+1]['vacation'] -= $this->leave_changes[$i][$j]['total_days'];
                                        break;
                                    case 'Sick Leave':
                                        $s_bal >= 1 ? $this->leave_changes[$i][$j]['v_awp'] = 1 : $this->leave_changes[$i][$j]['v_awop'] = 1; 
                                        $this->leave_changes[$i][$j]['v_bal'] = $s_bal - 1;
                                        $s_bal -= 1;
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
        // print_r("<pre>");
        // print_r($this->leave_changes);
        // print_r("</pre>");
    }
}