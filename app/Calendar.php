<?php
use Controllers\CalendarController;

class Calendar extends CalendarController {
    private $tab = "event";

    public function index () {
        // $this->date = date('YYYY-M-D');
        // $this->count = array_search(date_format($this->date,'l'),$this->days);
        // $this->get_calendar();
        print_r($this->date);
        $this->view->display ('admin/calendar', ["tab" => $this->tab, "date" => $this->date, "count" => $this->count, "days" => $this->days, "lastday" => $this->lastday, "month" => $this->data['month']]);
        
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    public function show_events() {
        try {
            $this->{$this->data['action']} ($this->data['day'], $this->data['month'], $this->data['year']);
        } catch (\Throwable $th) {
            $this->index();
        }
        // $this->view->display ('admin/calendar/show_events', ["date" => $this->data['day']]);
        // $this->view->display ('admin/calendar/show_events', ["date" => date_create('2020-01-01')]);
    }

    public function tab ($tab = "event") {
        $this->tab = $tab;
        $this->index();
    }
}