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
            // $date_start = date_create($arr['from'])->format('Y-m-d');
            $start_interval = new DateTime(date_create($arr['from'])->format('Y-m-d'));
            $interval = new DateInterval('P1D');
            $emp_schedule = DTR::get_sched($id);
            for ($i=0;$i<sizeof($emp_schedule);$i++) {
                $this->schedule[$i] = $emp_schedule[$i]['weekday'];
            }
            $temp=0;
            // while ($date_start <= date_create($arr['to'])->format('Y-m-d')) {
                $end_interval = new DateTime(date_create($arr['to'])->format('Y-m-d'));
                // $monthtable = date_create($date_start)->format('m-Y');
                // $attendance = DB::db("db_attendance")->fetch_all("SELECT * FROM `$monthtable` WHERE emp_id = ? AND date > ? ORDER BY date ASC", [$this->user['employee_id'], $this->leave_credits['date_credited']]);
                $daterange = new DatePeriod($start_interval, $interval, $end_interval);
                foreach ($daterange as $dt) {
                    if ($dt->format('d') == $start_interval->format('d')) {
                        $monthtable[$temp] = $dt->format('m-Y');
                        $attendance[$temp] = DB::db("db_attendance")->fetch_all("SELECT * FROM `$monthtable[$temp]` WHERE emp_id = ? AND date > ? ORDER BY date ASC", [$id, $this->leave_credits['date_credited']]);
                        // LOOP ATTENDANCE AND STORE ABSENCES, UNDERTIME AND PRESENT DATES TO $this->leave_changes AND $days_present
                        if ($attendance[$temp]) {
                            for ($i=0;$i<sizeof($attendance[$temp]);$i++) {
                                if (empty($this->leave_changes[$temp][$i])) {
                                    // if ($attendance[$temp][$i]['date'] < date('Y-m-d')) {
                                        if (($attendance[$temp][$i]['total_hours'] < 8) && ($attendance[$temp][$i]['total_hours'] > 0) && ($attendance[$temp][$i]['is_absent'] != 1)) {
                                            $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Undertime", "total_hours" => $attendance[$temp][$i]['total_hours']];
                                            $days_present[$temp][$i] = $attendance[$temp][$i]['date'];
                                        } else if (($attendance[$temp][$i]['total_hours'] == 0) && ($attendance[$temp][$i]['is_absent'] == 1)) {
                                            $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Absent", "total_hours" => $attendance[$temp][$i]['total_hours']];
                                        } else {
                                            $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Present", "total_hours" => $attendance[$temp][$i]['total_hours']];
                                            $days_present[$temp][$i] = $attendance[$temp][$i]['date'];
                                        }
                                    // }
                                } else {
                                    print_r("<pre>");
                                    print_r($attendance[$temp]);
                                    print_r("</pre>");
                                    // $key = array_search($this->leave_changes[$temp][$i]['period'],$attendance[$temp]);
                                    // print_r($key);
                                    // $idx = 0;
                                    // foreach ($this->leave_changes[$temp][$i] as $key => $lv_ch) {
                                    //     $key == 'period' ? $result[] = key(array_splice($this->leave_changes[$temp][$i], $idx, 1)) : '';
                                    //     $idx++;
                                    // }
                                    // print_r($result);
                                    // unset($attendance[$temp][array_search($this->leave_changes[$temp][$i]['period'],$attendance[$temp])]);
                                }
                            }
                        }
                        // LOOP LEAVE APPROVED AND STORE DATES TO $this->leave_changes AND $days_onleave
                        $emp_leave[$temp] = DB::db("db_master")->fetch_all("SELECT * FROM tbl_emp_leave WHERE employee_id = ? AND lv_status = ? AND lv_date_fr BETWEEN ? AND ? ORDER BY lv_date_fr ASC", [$id, 2, $dt->format('Y-m-d'), $dt->format('Y-m-t')]);
                        if ($emp_leave[$temp]) {
                            $k = sizeof($emp_leave[$temp]);
                            for ($i=0; $i < sizeof($emp_leave[$temp]); $i++) {
                                // if (empty($this->leave_changes[$temp][$i])) {
                                    if ($emp_leave[$temp][$i]['lv_no_days'] == 1) {
                                        if ($k > sizeof($emp_leave[$temp])) {
                                            $this->leave_changes[$temp][$k - sizeof($emp_leave[$temp])] = ["period" => $emp_leave[$temp][$i]['lv_date_fr'], "particulars" => "On Leave", "total_days" => 1];
                                            $days_onleave[$temp][$k - sizeof($emp_leave[$temp])] = $emp_leave[$temp][$i]['lv_date_fr'];
                                        } else {
                                            $this->leave_changes[$temp][$i] = ["period" => $emp_leave[$temp][$i]['lv_date_fr'], "particulars" => "On Leave", "total_days" => 1];
                                            $days_onleave[$temp][$i] = $emp_leave[$temp][$i]['lv_date_fr'];
                                        }
                                        $k++;
                                    } else {
                                        if (date_create($emp_leave[$temp][$i]['lv_date_fr'])->format('m-Y') == date_create($emp_leave[$temp][$i]['lv_date_to'])->format('m-Y')) {
                                            for ($j=0;$j<$emp_leave[$temp][$i]['lv_no_days'];$j++) {
                                                if ($k > sizeof($emp_leave[$temp])) {
                                                    $this->leave_changes[$temp][$k - sizeof($emp_leave[$temp])] = ["period" => date_create($emp_leave[$temp][$i]['lv_date_fr'])->modify("+$j day")->format('Y-m-d'), "particulars" => "On Leave", "total_days" => 1];
                                                    $days_onleave[$temp][$k - sizeof($emp_leave[$temp])] = date_create($emp_leave[$temp][$i]['lv_date_fr'])->modify("+$j day")->format('Y-m-d');
                                                } else {
                                                    $this->leave_changes[$temp][$i+$j] = ["period" => date_create($emp_leave[$temp][$i]['lv_date_fr'])->modify("+$j day")->format('Y-m-d'), "particulars" => "On Leave", "total_days" => 1];
                                                    $days_onleave[$temp][$i+$j] = date_create($emp_leave[$temp][$i]['lv_date_fr'])->modify("+$j day")->format('Y-m-d');
                                                }
                                                $k++;
                                            }
                                        } else {
                                            $leave_start = new DateTime(date_create($emp_leave[$temp][$i]['lv_date_fr'])->format('Y-m-d'));
                                            $day = new DateInterval('P1D');
                                            $leave_end = new DateTime(date_create($emp_leave[$temp][$i]['lv_date_to'])->modify("+1 day")->format('Y-m-d'));
                                            $leave_range = new DatePeriod($leave_start, $day, $leave_end);

                                            $m = $temp;
                                            $l = $k > sizeof($emp_leave[$temp]) ? $k - sizeof($emp_leave[$temp]) : $i;
                                            // $month_diff = date_create($emp_leave[$temp][$i]['lv_date_fr'])->format('m')->diff(date_create($emp_leave[$temp][$i]['lv_date_to'])->format('m')) + (date_create($emp_leave[$temp][$i]['lv_date_fr'])->format('Y')->diff(date_create($emp_leave[$temp][$i]['lv_date_to'])->format('Y')*12));
                                            foreach ($leave_range as $lv) {
                                                
                                                $m = $lv->format('d') == 01 ? $m+1 : $m;
                                                $l = $lv->format('d') == 01 ? 0 : $l;
                                                // print_r($l);print_r($m);
                                                if (in_array($lv->format('l'),$this->schedule)) {
                                                    // if ($lv->format('m-Y') == date_create($emp_leave[$temp][$i]['lv_date_fr'])->format('m-Y')) {
                                                    $this->leave_changes[$m][$l] = ["period" => $lv->format('Y-m-d'), "particulars" => "On Leave", "total_days" => 1];
                                                    $days_onleave[$m][$l] = $lv->format('Y-m-d');
                                                    // } else {
                                                        // $month_diff = 
                                                    // }
                                                    print_r("<pre>");
                                                    print_r($m . $l);
                                                    // print_r($days_onleave);
                                                    print_r("</pre>");
                                                    $l++;
                                                }
                                            }
                                            // $month_diff = date_create($emp_leave[$temp][$i]['lv_date_fr'])->format('m')->diff(date_create($emp_leave[$temp][$i]['lv_date_to'])->format('m')) + (date_create($emp_leave[$temp][$i]['lv_date_fr'])->format('Y')->diff(date_create($emp_leave[$temp][$i]['lv_date_to'])->format('Y')*12));
                                            // for ($l=0,$j=0; $l < $month_diff; $l++,$j++) {
                                            //     while (date_create($emp_leave[$temp][$i]['lv_date_fr'])->modify("+$l month"))
                                            //     for ($j=0; $j < $emp_leave[$temp][$i]['lv_no_days']; $j++) {
                                                    
                                            //     }
                                            // }
                                        }
                                    }
                                // }
                            }
                        }
                        $temp++;
                    }
                    
                    if (in_array($dt->format('l'),$this->schedule)) {
                        if (!empty($days_present[$temp-1])) {
                            if (!(in_array($dt->format('Y-m-d'), $days_present[$temp-1]))) {
                                if (empty($days_onleave[$temp-1])) {
                                    if (is_array($this->leave_changes[$temp-1])) {
                                        $this->leave_changes[$temp-1][sizeof($this->leave_changes[$temp-1])] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                                    } else {
                                        $this->leave_changes[$temp-1][0] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                                    }
                                } else {
                                    if (!(in_array($dt->format('Y-m-d'), $days_onleave[$temp-1]))) {
                                        if (is_array($this->leave_changes[$temp-1])) {
                                            $this->leave_changes[$temp-1][sizeof($this->leave_changes[$temp-1])] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absents"];
                                        } else {
                                            $this->leave_changes[$temp-1][0] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                                        }
                                    }
                                }
                            }
                        } else {
                            if (empty($days_onleave[$temp-1])) {
                                if (is_array($this->leave_changes[$temp-1])) {
                                    $this->leave_changes[$temp-1][sizeof($this->leave_changes[$temp-1])] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                                } else {
                                    $this->leave_changes[$temp-1][0] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                                }
                            }
                        }
                    }
                }
                for ($i=0;$i<sizeof($this->leave_changes);$i++) {
                    array_multisort(array_map('strtotime', array_column($this->leave_changes[$i], 'period')), SORT_ASC, $this->leave_changes[$i]);
                }
                print_r("<pre>");
                // // print_r($attendance);
                // // print_r($days_present);
                // // print_r($emp_leave);
                // // print_r($scheds);
                print_r($this->leave_changes);
                // // echo sizeof($this->leave_changes[$temp-1]);
                // // echo $temp;
                // // sizeof($this->leave_changes[$temp-1]);
                print_r("</pre>");

                // $monthrange = new DatePeriod($start_interval,$interval_monthly,$end_interval);
                // // print_r($monthrange);
                // foreach ($monthrange as $mt) {
                //     $monthtable = $mt->format('m-Y');
                //     $attendance = DB::db("db_attendance")->fetch_all("SELECT * FROM `$monthtable` WHERE emp_id = ? AND date > ? ORDER BY date ASC", [$this->user['employee_id'], $this->leave_credits['date_credited']]);
                //     print_r("<pre>");
                //     print_r($attendance); print_r("<br>");
                //     print_r("</pre>");
                // }

                // $date_start = strtotime("+30 days", $date_start);
                // print_r(date_create($date_start)->format('Y-m-d'));
                // $monthtable = date_create($monthtable)->format('Y-m-t');
                // $monthtable = $monthtable->modify('+1 month');
                // $monthtable = date_create($monthtable);
                // $monthtable = strtotime("+1 month", date_create($monthtable)->format('Y-m-d'));
                // print_r($monthtable);
                
                
            // $i=0;
            // while (date_create($arr['from'])->format('m-Y') <= date_create($arr['to'])->format('m-Y')) {
                // $tables[] = ["table" => $table1, "begin" => $arr['from'], "end" => date_create($arr['from'])->format('Y-m-t')];
                // $tables[] = ["table" => $table2, "begin" => date_create($arr['to'])->format('Y-m-01'), "end" => $arr['to']];
            //     $arr['from'] = strtotime("+1 month", date_create($arr['from'])->format('Y-m-d'));
            //     $i++;
            // }
        }
        // }
        // print_r("<pre>");
        // print_r($this->leave_changes);
        // print_r($this->leave_balance);
        // print_r("</pre>");
        // for ($i=0;$i<sizeof($tables);$i++) {
        //     $attendance['month'][] = date_create($tables[$i]['begin'])->format('F, Y');
        //     $dtr = DB::db("db_attendance")->fetch_all ("SELECT * FROM `".$tables[$i]['table']."` WHERE emp_id = ? AND `date` >= ? AND `date` <= ?", [$id, $tables[$i]['begin'], $tables[$i]['end']]);
        //     if (($dtr) && ($attendance['attn'])) $attendance['attn'] = array_merge($attendance['attn'], $dtr);
        //     if (!$attendance['attn']) $attendance['attn'] = $dtr;
        // }
        $this->leaveBalanceChanges();
        $this->attendance = $attendance;
        return $this;
    }

    protected function leaveBalanceChanges () {
        // ADD CONDITION CHECKING IF THERE IS ENOUGH BALANCE
        // if ($type == 'undertime') {
        //     $this->leave_balance[$index]['date'] = date_create($dt)->format('Y-m-d');
        //     $this->leave_balance[$index]['vacation'] -= ((8-$total_hours) * .125);
        //     // print_r("<pre>");
        //     // print_r($this->leave_balance);
        //     // print_r("</pre>");
        //     // $this->leave_changes[$index][0] = ["period" => date_create($dt)->format('Y-m-d'), "particulars" => "Leave Credits"];
        // } else if ($type == 'onleave') {
        //     $this->leave_balance[$index]['date'] = date_create($dt)->format('Y-m-d');
        //     $this->leave_balance[$index]['vacation'] -= 1;
        // }
        // print_r("<pre>");
        // print_r(in_array(date_create($this->leave_changes[0][11]['period'])->format('l'),$this->schedule));
        // print_r("</pre>");
        for ($i=1;$i<sizeof($this->leave_changes);$i++) {
            for ($j=0;$j<sizeof($this->leave_changes[$i-1]);$j++) {
                $leave_deduction = in_array(date_create($this->leave_changes[$i-1][$j]['period'])->format('l'), $this->schedule) ? 0.0416666666666667 : 0.0625000000000001;
                
                if ($this->leave_changes[$i-1][$j]['particulars'] == 'Absent') {
                    $this->leave_changes[$i-1][$j]['awp'] = 1;
                    $this->leave_balance[$i]['vacation'] -= 1;
                } else if ($this->leave_changes[$i-1][$j]['particulars'] == 'Undertime') {
                    $this->leave_balance[$i]['sick'] += (($this->leave_changes[$i-1][$j]['total_hours'] * .125) * $leave_deduction);
                    $this->leave_balance[$i]['vacation'] += (($this->leave_changes[$i-1][$j]['total_hours'] * .125) * $leave_deduction);
                    $this->leave_balance[$i]['vacation'] -= (((8-$this->leave_changes[$i-1][$j]['total_hours']) * .125) * $leave_deduction);
                } else if ($this->leave_changes[$i-1][$j]['particulars'] == 'On Leave') {
                    $this->leave_balance[$i]['vacation'] -= $this->leave_changes[$i-1][$j]['total_days'];
                } else if ($this->leave_changes[$i-1][$j]['particulars'] == 'Present') {
                    $this->leave_balance[$i]['vacation'] += $leave_deduction;
                    $this->leave_balance[$i]['sick'] += $leave_deduction;
                }
            }
            if ($i < sizeof($this->leave_changes)) {
                $this->leave_balance[$i] = ["date" => date_create($this->leave_balance[$i-1]['date'])->modify('+1 month')->format('Y-m-d'), "vacation" => ($this->leave_balance[$i]['vacation'] + $this->leave_balance[$i-1]['vacation']), "sick" => ($this->leave_balance[$i]['sick'] + $this->leave_balance[$i-1]['sick'])];
            }
        }
    }
}