<?php
use Controllers\SettingsController;

class Settings extends SettingsController {
    private $view = ["connection", "salary-grade", "payroll", "position", "w-tax"];
    private $vars;

    public function index () {
        $this->view->display ("admin/settings", $this->vars);
    }

    public function view ($view) {
        if (in_array ($view, $this->view)) {

        }
        $this->index ();
    }
}