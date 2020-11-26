<?php
use Controllers\SettingsController;

class Settings extends SettingsController {
    private $tab = "security";
    private $tabs = ["connection", "security", "salary-grade", "payroll", "position", "w-tax"];
    private $vars;

    public function index () {
        $this->view->display ("admin/settings", ["tab" => $this->tab, "var" => $this->vars]);
    }
    
    public function do_action () {
        call_user_func_array ([$this, $this->data['action']], $this->data);
    }

    public function tab ($tab = "security") {
        if (in_array ($tab, $this->tabs)) {
            $this->tab = $tab;
            $this->vars = call_user_func_array ([$this, str_replace ("-", "_", $this->tab)], []);
        }
        $this->index ();
    }

    public function change_pass () {
        if ($_POST['new_pass'] == $_POST['confirm_pass']) {
            $message = $this->change_password($_POST['id'],$_POST['current_pass'],$_POST['new_pass'],$_POST['confirm_pass']);
        } else {
            $message = ["result" => "failed", "message" => "New password was not confirmed correctly."];
        }
        $this->view->display ("admin/settings", ["tab" => 'security', "message" => $message]);
    }
}