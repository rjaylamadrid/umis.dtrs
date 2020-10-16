<?php
namespace Controllers;

class CalendarController extends Controller {
    public $days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    private $months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    public $date;
    public $count;
    public $lastday;
    private $dates;

    public function get_calendar () {
        $this->date = date_create($this->data['year'].'-'.$this->data['month'].'-01');
        $this->lastday = date_format($this->date, 't');
        $this->count = array_search(date_format($this->date,'l'),$this->days);
        $this->view->display ('admin/calendar/event', ["tab" => $this->tab, "date" => $this->date, "count" => $this->count, "lastday" => $this->lastday]);
    }

    // public function get_events($id) {
    //     print_r($date);
    // }
}