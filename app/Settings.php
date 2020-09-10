<?php
use Controllers\SettingsController;

class Settings extends SettingsController {
    private $tab = "general";
    private $tabs = ["connection", "salary-grade", "payroll", "position", "w-tax"];
    private $vars;

    public function index () {
        $this->view->display ("admin/settings", ["tab" => $this->tab, "var" => $this->vars]);
    }

    public function tab ($tab = "general") {
        if (in_array ($tab, $this->tabs)) {
            $this->tab = $tab;
            $this->vars = call_user_func_array ([$this, str_replace ("-", "_", $this->tab)], []);
        }
        $this->index ();
    }
}