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
        $this->leave_changes = self::attendance($this->user['employee_id'], ["from" => $this->leave_credits['date_credited'], "to" => '2021-01-01'], 2);

        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod(date_create($this->leave_credits['date_credited']), $interval, date_create('2021-01-29'));
        $sched = DTR::get_sched($this->user['employee_id']);
        foreach ($daterange as $date) {
            $monthtable = date_create($this->leave_credits['date_credited'])->format('m-Y');
            $attendance = DB::db("db_attendance")->fetch_all("SELECT * FROM $monthtable WHERE emp_id = ? AND date > ?", [$this->user['employee_id'], $this->leave_credits['date_credited']]);
        }
        print_r("<pre>");
        print_r($sched);
        print_r("</pre>");
    }

    protected function computeLeaveCredits($id, $date_start) {
        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod($date_start, $interval ,$date_start->modify('+30 day'));
    }

    protected function attendance ($id, $arr, $period = 2) {
        if (!($period == '3')) {
            if (($period == '2') || ($period == '1')) $this->period[$period][1] = date_create($arr['from'])->format('t');
            $tables[] = ["table" =>  date_create($arr['from'])->format('m-Y') , "begin" => date_create($arr['from'])->format('Y-m-'.$this->period[$period][0]), "end" => date_create($arr['from'])->format('Y-m-'.$this->period[$period][1])];
        } else {
            $table1 = date_create($arr['from'])->format('m-Y');
            $table2 = date_create($arr['to'])->format('m-Y');
            if ($table1 == $table2) {
                $tables[] = ["table" => $table1, "begin" => $arr['from'], "end" => $arr['to']];
            } else {
                $tables[] = ["table" => $table1, "begin" => $arr['from'], "end" => date_create($arr['from'])->format('Y-m-t')];
                $tables[] = ["table" => $table2, "begin" => date_create($arr['to'])->format('Y-m-01'), "end" => $arr['to']];
            }
        }

        foreach ($tables as $table) {
            $attendance['month'][] = date_create($table['begin'])->format('F, Y');
            $dtr = DB::db("db_attendance")->fetch_all ("SELECT * FROM `".$table['table']."` WHERE emp_id = ? AND `date` >= ? AND `date` <= ?", [$id, $table['begin'], $table['end']]);
            if (($dtr) && ($attendance['attn'])) $attendance['attn'] = array_merge($attendance['attn'], $dtr);
            if (!$attendance['attn']) $attendance['attn'] = $dtr;
        }
        $this->attendance = $attendance;
        return $this;
    }
}