<?php
use Controllers\PayrollController;

class Payroll extends PayrollController {
    private $tab = "page";

    public function index () {
        $this->view->display ('admin/payroll', ["tab" => $this->tab, "days" => $this->days]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    public function tab ($tab = "page") {
        $this->tab = $tab;
        $this->index();
    }

    public function pay_slip() {
        
    }
}