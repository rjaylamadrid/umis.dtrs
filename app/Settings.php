<?php
use Controllers\SettingsController;

class Settings extends SettingsController {
    private $tabs = ["connection", "security", "salary-grade", "position", "payroll", "w-tax", "department"];
    private $vars;

    public function index() {
        $this->tab();
    }

    public function tab ($tab = "security") {
        if (in_array ($tab, $this->tabs)) {
            $this->vars = call_user_func_array ([$this, str_replace ("-", "_", $tab)], []);
            $this->vars['tab'] = $tab;
        }
        $this->view->display ("admin/settings", $this->vars);
    }
    
    public function do_action () {  
        call_user_func_array ([$this, $this->data['action']], $this->data);
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