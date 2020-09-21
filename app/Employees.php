<?php
use Model\Position;
use Model\Employee;
use Model\EmployeeStats;
use Model\EmployeeProfile;
use Controllers\EmployeesController;
use Model\Schedule;

class Employees extends EmployeesController {
    private $stats;
    public $employee;

    public function index () {
        $this->stats = EmployeeStats::campus ($this->user['campus_id'])->get_stats ();
        $this->view->display ('admin/employees', ["stats" => $this->stats, "employees" => $this->employees()->all()]);
    }

    public function profile ($id = null, $tab = 'basic-info', $view='view') {
        $this->employee = new EmployeeProfile ($id);
        print_r($this->employee);
        try {
            $this->employee->{str_replace ("-", "_", $tab)}();
        } catch (\Throwable $th) {
            $tab = 'basic-info';
            $this->employee->basic_info ();
        }
        $this->view->display ('profile', ["employee" => $this->employee, "tab" => $tab, "view" => $view]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        }
    }

    public function update ($id, $view = 'basic-info') {
        $this->profile($id,$view,'update');
    }

    public function save ($id, $view = 'basic-info') {
        header ("location: /employees/profile/$id/$view");
    }

    public function registration ($success = NULL) {
        if ($success) $message = ['success' => '1', 'message' => 'New employee has been successfully registered!'];
        $positions = Position::positions()->all ();
        $presets = Schedule::presets()->all ();
        $this->view->display ('admin/employee_registration', ['positions' => $positions, 'emp_type' => $this->type(), 'schedules' => $presets , 'departments' => $this->departments(), 'designations' => $this->designations(), 'id' => $this->new_id ('1'), 'message' => $message]);
    }

    public function employment ($id, $tab = 'employment') {
        $this->employee = new EmployeeProfile ($id);
        $this->view->display ('admin/employee_employment', ['employee' => $this->employee, 'tab' => $tab]);
    }
}