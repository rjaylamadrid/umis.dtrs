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
    public $dtr_code = ["BO:BO" => "Brownout", "HL:HL" => "Holiday", "OB:OB" => "Official Business"];

    public function get_calendar () {
        $this->date = date_create($this->data['year'].'-'.$this->data['month'].'-01');
        $this->lastday = date_format($this->date, 't');
        $this->count = array_search(date_format($this->date,'l'),$this->days);
        $this->view->display ('admin/calendar/event', ["tab" => $this->tab, "date" => $this->date, "count" => $this->count, "lastday" => $this->lastday, "dtr_code" => $this->dtr_code, "events" => $this->events]);
    }

    public function get_events($day,$month,$year) {
        $this->selected_date = date_create($year.'-'.$month.'-'.$day);
        $event_date = date_create($year.'-'.$month.'-'.$day);
        $this->selected_date = date_format($event_date, 'Y-m-d');
        $events = DB::db('db_master')->fetch_all("SELECT a.no,a.event_name,a.event_date,a.event_start,a.event_end,b.dtr_code,b.dtr_code_desc FROM tbl_event a, tbl_dtr_code b WHERE a.event_date = '". date_format($event_date,'Y-m-d') ."' AND a.dtr_code_id = b.no");
        $this->view->display ('admin/calendar/show_events', ["event_date" => $event_date, "events" => $events, "selected_date" => $this->selected_date]);
    }

    public function add_event() {
        DB::db('db_master')->insert ("INSERT INTO tbl_event SET ". DB::stmt_builder($this->data['Event']),$this->data['Event']);
        self::attendance_event($this->data['Event']['event_date'], $this->data['Event']['dtr_code_id'], $this->data['Event']['event_start'], $this->data['Event']['event_end']);
        // header ("location: /calendar");
    }

    public function delete_event($id) {
        $row = DB::db('db_master')->fetch_row ("SELECT * FROM tbl_event WHERE no = $id");
        $data = $row['event_name'].";".$row['event_date'].";".$row['event_start'].";".$row['event_end'].";".$row['dtr_code_id'].";".$row['campus_id'];
        $data_array = ["updated_action" => 1, "updated_table" => 'tbl_event', "updated_old_data" => $data, "updated_new_data" => '', "updated_employee_id" => '0', "updated_admin_id" => 1,"updated_date"=>date("Y-m-d")];
        
        $in_out = ['am_in', 'am_out', 'pm_in', 'pm_out'];
        $monthtable = date_create($row['event_date'])->format('m-Y');
        $date = date_create($row['event_date'])->format('Y-m-d');
        $emp_sched = DB::db('db_master')->fetch_all ("SELECT a.* FROM tbl_employee_sched a WHERE a.no = (SELECT MAX(b.no) FROM tbl_employee_sched b WHERE b.employee_id = a.employee_id)");
        $dtr_code = DB::db('db_master')->fetch_row ("SELECT * FROM tbl_dtr_code WHERE no = ?",$row['dtr_code_id']);

        foreach ($emp_sched as $value) {
            $attendance = DB::db('db_attendance')->fetch_row("SELECT * FROM `$monthtable` WHERE emp_id = ? AND date = '$date'",$value['employee_id']);
            for($i=0;$i<4;$i++) {
                $replacement[$i] = $attendance[$in_out[$i]] == $dtr_code['dtr_code'] ? ':' : $attendance[$in_out[$i]];
            }
            DTR::change_log($value['employee_id'], $replacement, $monthtable, $date, $attendance['id']);
        }
        DB::db('db_master')->insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($data_array),$data_array);
        DB::db('db_master')->delete ("DELETE FROM tbl_event WHERE no = ?", $id);
    }

    public function attendance_event($date, $dtr_code_id, $start, $end) {
        $monthtable = date_create($date)->format('m-Y');
        $date = date_create($date)->format('Y-m-d');
        $employee_scheds = DB::db('db_master')->fetch_all ("SELECT a.* FROM tbl_employee_sched a WHERE a.no = (SELECT MAX(b.no) FROM tbl_employee_sched b WHERE b.employee_id = a.employee_id)");
        $date_logs = DB::db('db_attendance')->fetch_all("SELECT * FROM `$monthtable` WHERE date = '$date'");
        $dtr_code = DB::db('db_master')->fetch_row("SELECT * FROM tbl_dtr_code WHERE no = ?",$dtr_code_id);

        foreach ($employee_scheds as $value) {
            $attnd_logs = self::check_logs ($value['employee_id'], $monthtable, $date, $dtr_code['dtr_code'], $value['sched_code'], $start, $end);
            print_r($attnd_logs);
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
        $emp_sched = DB::db('db_master')->fetch_row("SELECT * FROM tbl_schedule WHERE sched_code = ? AND weekday = ?", [$sched_code, date_create($date)->format('l')]);

        for ($i=0; $i<4; $i++) {
            if($date_logs) {
                if(($date_logs[$in_out[$i]] == NULL) || ($date_logs[$in_out[$i]] == ':') || ($date_logs[$in_out[$i]] == '')) {
                    if((strtotime($emp_sched[$in_out[$i]]) >= strtotime($start)) && (strtotime($emp_sched[$in_out[$i]]) <= strtotime($end))) {
                        $value[$i] = $dtr_code;
                    } else {
                        $value[$i] = $date_logs[$in_out[$i]];
                    }
                } else {
                    $value[$i] = $date_logs[$in_out[$i]];
                }
            } else {
                $value[$i] = $date_logs[$in_out[$i]];
            }
        }
        return $value;
    }
}