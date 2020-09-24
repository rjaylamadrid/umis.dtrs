<?php
use Controllers\ProfileController;
use Model\Employee;
use Model\EmployeeProfile;

class Profile extends ProfileController {
    private $tab;

    public function index ($tab = 'basic-info', $view = 'view') {
        $this->employee = new EmployeeProfile ($this->user['employee_id']);
        try {
            $this->employee->{str_replace ("-", "_", $tab)}();
        } catch (\Throwable $th) {
            $tab = 'basic-info';
            $this->employee->basic_info ();
        }
        $this->view->display ('profile', ["employee" => $this->employee, "tab" => $tab, "view" => $view]);
    }

    private function table () {
        return $this->tab == 'basic-info' ? 'tbl_employee' : 'tbl_employee_'.str_replace ("-", "_", $this->tab);
    }

    public function update ($tab = 'basic-info'){
        $this->index($tab, 'update');
    }
}