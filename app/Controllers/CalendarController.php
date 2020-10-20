<?php
namespace Controllers;

use Database\DB;
use Model\Calendar;

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

    // public static function get_dtr_code() {
    //     $this->dtr_code = DB::fetch_all("SELECT * FROM tbl_dtr_code");
    // }

    public function add_event() {
        DB::insert ("INSERT INTO tbl_event SET ". DB::stmt_builder($this->data['Event']),$this->data['Event']);
        header ("location: /calendar");
    }

    public function delete_event($id) {
        $row = DB::fetch_row ("SELECT * FROM tbl_event WHERE no = $id");
        $data = $row['event_name'].";".$row['event_date'].";".$row['event_start'].";".$row['event_end'].";".$row['dtr_code_id'].";".$row['campus_id'];
        $data_array = ["updated_action" => 1, "updated_table" => 'tbl_event', "updated_old_data" => $data, "updated_new_data" => '', "updated_employee_id" => '0', "updated_admin_id" => 1,"updated_date"=>date("Y-m-d")];
        DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($data_array),$data_array);
        DB::delete ("DELETE FROM tbl_event WHERE no = ?", $id);
    }

    // public function prepare_qry ($row) {
    //     foreach ($row as $key => $data) {
    //         $data_arra
    //     }
    // }
}