<?php
use Controllers\CalendarController;

class Calendar extends CalendarController {
    private $tab = "event";

    public function index () {
        $this->view->display ('admin/calendar', ["tab" => $this->tab, "days" => $this->days]);
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