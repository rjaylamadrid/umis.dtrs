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
        self::get_dtr_code();
        $this->view->display ('admin/calendar/event', ["tab" => $this->tab, "date" => $this->date, "count" => $this->count, "lastday" => $this->lastday, "dtr_code" => $this->dtr_code, "events" => $this->events]);
    }

    public function get_events($day,$month,$year) {
        $this->selected_date = date_create($year.'-'.$month.'-'.$day);
        $event_date = date_create($year.'-'.$month.'-'.$day);
        $this->selected_date = date_format($event_date, 'Y-m-d');
        $events = DB::fetch_all("SELECT a.*,b.* FROM tbl_event a, tbl_dtr_code b WHERE a.event_date = '". date_format($event_date,'Y-m-d') ."' AND a.dtr_code_id = b.no");
        $this->view->display ('admin/calendar/show_events', ["event_date" => $event_date, "events" => $events, "selected_date" => $this->selected_date]);
    }

    // public static function get_dtr_code() {
    //     $this->dtr_code = DB::fetch_all("SELECT * FROM tbl_dtr_code");
    // }

    public function add_event() {
        DB::insert("INSERT INTO tbl_event SET ". DB::stmt_builder($this->data['Event']),$this->data['Event']);
        header ("location: /calendar");
    }
}