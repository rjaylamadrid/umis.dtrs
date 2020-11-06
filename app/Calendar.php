<?php
use Controllers\CalendarController;

class Calendar extends CalendarController {
    private $tab = "event";

    public function index () {
        $month=$this->data['month'] ? $this->data['month'] : date('m');
        // $this->get_calendar();
        $this->view->display ('admin/calendar', ["tab" => $this->tab, "date" => $this->date, "count" => $this->count, "days" => $this->days, "lastday" => $this->lastday, "month" => $month, "dtr_code" => $this->dtr_code]);
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
    }

    public function tab ($tab = "event") {
        $this->tab = $tab;
        $this->index();
    }

    public function del_event() {
        try {
            $this->{$this->data['action']} ($this->data['no']);
        } catch (\Throwable $th) {
            $this->index();
        }
    }
}