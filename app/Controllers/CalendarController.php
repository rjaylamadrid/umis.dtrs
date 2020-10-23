<?php
namespace Controllers;

use Database\DB;
use Model\Calendar;
use Model\DTR;

class CalendarController extends Controller {
    public $days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    private $months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    public $date;
    public $count;
    public $lastday;
    private $dates;
    public $events;
    public $selected_date;
    public $dtr_code = ["BO:BO" => "Brownout", "HL:HL" => "Holiday"];

    public function get_calendar () {
        $this->date = date_create($this->data['year'].'-'.$this->data['month'].'-01');
        $this->lastday = date_format($this->date, 't');
        $this->count = array_search(date_format($this->date,'l'),$this->days);
        // self::get_dtr_code();
        $this->view->display ('admin/calendar/event', ["tab" => $this->tab, "date" => $this->date, "count" => $this->count, "lastday" => $this->lastday, "dtr_code" => $this->dtr_code, "events" => $this->events]);
    }

    public function get_events($day,$month,$year) {
        $this->selected_date = date_create($year.'-'.$month.'-'.$day);
        $event_date = date_create($year.'-'.$month.'-'.$day);
        $this->selected_date = date_format($event_date, 'Y-m-d');
        $events = DB::fetch_all("SELECT a.no,a.event_name,a.event_date,a.event_start,a.event_end,b.dtr_code,b.dtr_code_desc FROM tbl_event a, tbl_dtr_code b WHERE a.event_date = '". date_format($event_date,'Y-m-d') ."' AND a.dtr_code_id = b.no");
        $this->view->display ('admin/calendar/show_events', ["event_date" => $event_date, "events" => $events, "selected_date" => $this->selected_date]);
    }

    public function add_event() {
        // print_r(date_create($this->data['Event']['event_date'])->format('m-Y'));
        // $monthtable = date_create($this->data['Event']['event_date'])->format('m-Y');
        // $date = date_create($this->data['Event']['event_date'])->format('Y-m-d');
        // $data = DB::db('db_attendance')->fetch_row("SELECT * FROM `$monthtable` WHERE date = '$date' AND emp_id = 1");
        // print_r ($data);
        // print_r($this->data['Event']['dtr_code_id']);
        self::attendance_event($this->data['Event']['event_date'], $this->data['Event']['dtr_code_id'], $this->data['Event']['event_start'], $this->data['Event']['event_end']);
        // DB::insert ("INSERT INTO tbl_event SET ". DB::stmt_builder($this->data['Event']),$this->data['Event']);
        // header ("location: /calendar");
    }

    public function delete_event($id) {
        $row = DB::fetch_row ("SELECT * FROM tbl_event WHERE no = $id");
        $data = $row['event_name'].";".$row['event_date'].";".$row['event_start'].";".$row['event_end'].";".$row['dtr_code_id'].";".$row['campus_id'];
        $data_array = ["updated_action" => 1, "updated_table" => 'tbl_event', "updated_old_data" => $data, "updated_new_data" => '', "updated_employee_id" => '0', "updated_admin_id" => 1,"updated_date"=>date("Y-m-d")];
        DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($data_array),$data_array);
        DB::delete ("DELETE FROM tbl_event WHERE no = ?", $id);
    }

    // public function attendance_event($date, $dtr_code_id) {
    //     $monthtable = date_create($date)->format('m-Y');
    //     $date = date_create($date)->format('Y-m-d');
    //     $employee_scheds = DB::fetch_all ("SELECT a.* FROM tbl_employee_sched a WHERE a.no = (SELECT MAX(b.no) FROM tbl_employee_sched b WHERE b.employee_id = a.employee_id)");
    //     $attnd = DB::fetch_row("SELECT * FROM tbl_dtr_code WHERE no = ?",$dtr_code_id);
    //     $attnd_logs = ['', 'BO:BO'];
    //     foreach ($employee_scheds as $value) {
    //         // $date_logs = DB::db('db_attendance')->fetch_row("SELECT * FROM `$monthtable` WHERE date = '$date' AND emp_id = ?",$value['employee_id']);
    //         $date_logs = DB::db('db_attendance')->fetch_row("SELECT * FROM `$monthtable` WHERE date = '$date' AND emp_id = 1");
    //         if($date_logs) {
    //             DTR::change_log($value['employee_id'], $attnd_logs, $monthtable, $date, $date_logs['id']);
    //         } else {
    //             DTR::change_log($value['employee_id'], $attnd_logs, $monthtable, $date);
    //         }
    //     }
    // }

    public function attendance_event($date, $dtr_code_id, $start, $end) {
        $monthtable = date_create($date)->format('m-Y');
        $date = date_create($date)->format('Y-m-d');
        $employee_scheds = DB::fetch_all ("SELECT a.* FROM tbl_employee_sched a WHERE a.no = (SELECT MAX(b.no) FROM tbl_employee_sched b WHERE b.employee_id = a.employee_id)");
        $date_logs = DB::db('db_attendance')->fetch_all("SELECT * FROM `$monthtable` WHERE date = '$date'");
        $dtr_code = DB::db('db_master')->fetch_row("SELECT * FROM tbl_dtr_code WHERE no = ?",$dtr_code_id);
        // print_r("<pre>");
        // print_r($date_logs);
        // print_r("</pre>");
        foreach ($employee_scheds as $value) {
            $attnd_logs = self::check_logs ($value['employee_id'], $monthtable, $date, $dtr_code['dtr_code'], $value['sched_code'], $start, $end);
            print_r("<pre>");
            print_r($attnd_logs);
            print_r("</pre>");
            // if(array_search($value['employee_id'], array_column($date_logs,'emp_id')) !== false) {
            //     foreach ($date_logs as $logs) {
            //         if($value['employee_id'] == $logs['emp_id']) {
            //             DTR::change_log($value['employee_id'], $attnd_logs, $monthtable, $date, $logs['id']);
            //         }
            //     }
            // }
            // else {
            //     DTR::change_log($value['employee_id'], $attnd_logs, $monthtable, $date);
            // }
        }
    }

    public function check_logs($id, $monthtable, $date, $dtr_code, $sched_code, $start, $end) {
        $in_out = ['am_in', 'am_out', 'pm_in', 'pm_out'];
        $date_logs = DB::db('db_attendance')->fetch_row("SELECT * FROM `$monthtable` WHERE date = '$date' AND emp_id = ?", $id);
        $emp_sched = DB::db('db_master')->fetch_all("SELECT * FROM tbl_schedule WHERE sched_code = ? AND weekday = ?", [$sched_code, date_create($date)->format('l')]);
        print_r("<pre>");
        print_r($emp_sched);
        print_r(strtotime($start));
        print_r("<br />");
        print_r($emp_sched['am_in']);
        print_r("<br />");
        print_r(strtotime($end));
        print_r("</pre>");
        for ($i=0; $i<4; $i++) {
            if(($date_logs[$in_out[$i]] == NULL) || ($date_logs[$in_out[$i]] == ':') || ($date_logs[$in_out[$i]] == '')) {
                if((strtotime($empsched[$in_out[$i]]) > strtotime($start)) && (strtotime($empsched[$in_out[$i]]) < strtotime($end))) {
                    $value[$i] = $dtr_code;
                }
            }
        }
        return $value;
    }

    // public function in_multid_array($data, $stack, $result = false) {
    //     foreach ($stack as $value) {
    //         if (($result ? $value['emp_id'] === $data : $value['emp_id'] == $data) || (is_array($value['emp_id']) && in_multid_array($data, $value, $result))) {
    //             return true;
    //         }
    //     }
    //     return false;
    // }
}