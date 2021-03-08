<?php
use Controllers\PayrollController;

class Payroll extends PayrollController {
    private $tab;

    public function index () {
        if (!$this->tab) $this->tab = "payroll";
        $this->view->display ('admin/payroll', ["tab" => $this->tab, "days" => $this->days, "setting" => $setting]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    public function tab ($tab = "salary-grade") {
        $this->tab = $tab;
        $vars = call_user_func_array ([$this, str_replace ("-", "_", $tab)], []);

        $this->view->assign($vars);
        $this->index();
    }
}