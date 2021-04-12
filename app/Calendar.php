<?php
use Controllers\CalendarController;

class Calendar extends CalendarController {
    private $tab = "event";

    public function index () {
        $this->data['month'] = $this->data['month'] ? $this->data['month'] : date('m');
        $this->data['year'] = $this->data['year'] ? $this->data['year'] : date('y');
        if ($this->tab == 'event') {
            $this->get_calendar();
        }
        $this->view->display ('admin/calendar', ["tab" => $this->tab, "date" => $this->date, "count" => $this->count, "days" => $this->days, "seldate" => $this->selected_date, "lastday" => $this->lastday, "month" => $this->data['month'], "dtr_code" => $this->dtr_code, "events" => $this->events]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    public function tab ($tab = "event") {
        $this->tab = $tab;
        $this->index();
    }
}