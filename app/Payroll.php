<?php
use Controllers\PayrollController;

class Payroll extends PayrollController {
    private $settings = ["formula", "content", "signatories"];
    private $tab = "payroll";

    public function index () {
        $setting  = in_array($this->tab, $this->settings) ? true : false;
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