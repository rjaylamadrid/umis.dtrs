<?php
use Controllers\CalendarController;

class Calendar extends CalendarController {
    private $tab = "event";

    public function index () {
        // $this->date = date('YYYY-M-D');
        // $this->count = array_search(date_format($this->date,'l'),$this->days);
        // $this->get_calendar();
        $this->view->display ('admin/calendar', ["tab" => $this->tab, "date" => $this->date, "count" => $this->count, "days" => $this->days, "lastday" => $this->lastday]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    // public function show_calendar($year,$month,$day) {

    // }

    public function tab ($tab = "event") {
        $this->tab = $tab;
        $this->index();
    }
}