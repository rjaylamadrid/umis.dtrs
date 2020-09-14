<?php
use Controllers\ProfileController;
use Model\Employee;

class Profile extends ProfileController {
    private $tab;

    public function index ($tab = 'basic-info') {
        $this->tab = $tab;

        $emp = Employee::find($this->user['employee_id'])->info($this->table ());
        $this->view->display ('profile', ["employee" => Employee::get(), "emp" => $emp, "tab" => $tab]);
    }

    private function table () {
        return $this->tab == 'basic-info' ? 'tbl_employee' : 'tbl_employee_'.str_replace ("-", "_", $this->tab);
    }

    public function update ($tab = 'basic-info'){
        $this->tab = $tab;

        $emp = Employee::find($this->user['employee_id'])->info($this->table ());
        $this->view->display ('profile', ["employee" => Employee::get(), "emp" => $emp, "tab" => $tab, "view" => "update"]);
    }
}