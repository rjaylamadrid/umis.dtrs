<?php
namespace Controllers;

// use Controllers\AttendanceController;
use Database\DB;
use Model\DTR;
use DateTime;
use DateInterval;
use DatePeriod;

class LeaveController extends Controller {
    public $leave_record;
    public $leave_credits;
    public $leave_changes;
    private $period = [['01', '15'], ['16', '31'], ['01', '31']];
    private $attendance;

    protected function getLeaveRecord() {
        $this->leave_record = DB::fetch_all("SELECT * FROM tbl_emp_leave WHERE employee_id = ? ORDER BY lv_date_fr DESC", $this->user['employee_id']);
    }

    protected function getLeaveCredits () {
        $this->leave_credits = DB::fetch_row("SELECT * FROM tbl_emp_leave_credits WHERE employee_id = ? AND is_active = ?", [$this->user['employee_id'], 1]);
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
            $date_start = date_create($arr['from'])->format('Y-m-d');
            $start_interval = new DateTime($date_start);
            $interval = new DateInterval('P1D');
            // $interval_monthly = new DateInterval('P30D');
            $emp_schedule = DTR::get_sched($id);
            for ($i=0;$i<sizeof($emp_schedule);$i++) {
                $scheds[$i] = $emp_schedule[$i]['weekday'];
            }
            $temp=0;
            // while ($date_start <= date_create($arr['to'])->format('Y-m-d')) {
                $end_interval = new DateTime(date_create($arr['to'])->format('Y-m-d'));
                // $monthtable = date_create($date_start)->format('m-Y');
                // $attendance = DB::db("db_attendance")->fetch_all("SELECT * FROM `$monthtable` WHERE emp_id = ? AND date > ? ORDER BY date ASC", [$this->user['employee_id'], $this->leave_credits['date_credited']]);
                $daterange = new DatePeriod($start_interval, $interval, $end_interval);
                
                foreach ($daterange as $dt) {
                    if ($dt->format('d') == 01) {
                        $monthtable[$temp] = $dt->format('m-Y');
                        $attendance[$temp] = DB::db("db_attendance")->fetch_all("SELECT * FROM `$monthtable[$temp]` WHERE emp_id = ? AND date > ? ORDER BY date ASC", [$id, $this->leave_credits['date_credited']]);
                        if ($attendance[$temp]) {
                            for ($i=0;$i<sizeof($attendance[$temp]);$i++) {
                                if ($attendance[$temp][$i]['total_hours'] < 8) {
                                    $this->leave_changes[$temp][$i] = ["period" => $attendance[$temp][$i]['date'], "particulars" => "Undertime"];
                                } else {
                                    $days_present[$temp][$i] = $attendance[$temp][$i]['date'];
                                }
                            }
                        }

                        $emp_leave[$temp] = DB::db("db_master")->fetch_all("SELECT * FROM tbl_emp_leave WHERE employee_id = ? AND response = ? AND lv_status = ? AND lv_date_fr BETWEEN ? AND ? ORDER BY lv_date_fr ASC", [$id, 1, 1, $dt->format('Y-m-d'), $dt->format('Y-m-t')]);
                        if ($emp_leave[$temp]) {
                            for ($i=0;$i<sizeof($emp_leave[$temp]);$i++) {
                                $this->leave_changes[$temp][$i] = ["period" => $emp_leave[$temp][$i]['lv_date_fr'], "particulars" => "On Leave"];
                            }
                        }
                        $temp++;
                    }
                    if (in_array($dt->format('l'),$scheds)) { //and not in $emp_leave or calendar events and not in attendance
                        if (!(in_array($dt->format('Y-m-d'), $days_present[$temp-1]))) {
                            $this->leave_changes[$temp-1][sizeof($this->leave_changes[$temp-1])] = ["period" => $dt->format('Y-m-d'), "particulars" => "Absent"];
                        }
                    }
                    
                    print_r("<pre>");
                    print_r($dt->format('Y-m-d')); print_r($dt->format('l')); print_r("<br>");
                    print_r("</pre>");
                }
                print_r("<pre>");
                print_r($attendance);
                print_r($days_present);
                print_r($emp_leave);
                print_r($scheds);
                print_r($this->leave_changes);
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
        // print_r($tables);
        // print_r("</pre>");
        // for ($i=0;$i<sizeof($tables);$i++) {
        //     $attendance['month'][] = date_create($tables[$i]['begin'])->format('F, Y');
        //     $dtr = DB::db("db_attendance")->fetch_all ("SELECT * FROM `".$tables[$i]['table']."` WHERE emp_id = ? AND `date` >= ? AND `date` <= ?", [$id, $tables[$i]['begin'], $tables[$i]['end']]);
        //     if (($dtr) && ($attendance['attn'])) $attendance['attn'] = array_merge($attendance['attn'], $dtr);
        //     if (!$attendance['attn']) $attendance['attn'] = $dtr;
        // }
        $this->attendance = $attendance;
        return $this;
    }

    protected function compute () { //from attendance controller to compute attendance
        $attendance = [];
        if ($this->attendance['attn']) {
            for ($i=0; $i < sizeof ($this->attendance['attn']); $i++) {
                $this->attendance['attn'][$i]['auth'] = $this->authenticate($this->attendance['attn'][$i]);
                $attendance['attn'][$this->attendance['attn'][$i]['date']] = $this->attendance['attn'][$i];
                $attendance['total'] += $this->attendance[$i]['attn']['total_hours'];
                $attendance['ut'] += ($this->attendance[$i]['attn']['late'] + $this->attendance[$i]['attn']['undertime']); 
            }
        }
        $attendance['month'] = $this->attendance['month'];
        $this->attendance = $attendance;
        return $this->attendance;
    }

    protected function authenticate($attn){
        if ($attn) {
            $data = $attn['date'].$attn['emp_id'].$attn['am_in'].$attn['am_out'].$attn['pm_in'].$attn['pm_out'].$attn['ot_in'].$attn['ot_out'];
            $data = md5(utf8_encode($data), TRUE);
            if(base64_encode($data) == $attn['signature']){
                $result = "true";
            }else{
                $result = "false";
            }
        }
        return $result;
    }
}