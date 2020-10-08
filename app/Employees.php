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
        $status  = $this->data['inactive'] ? 0 : 1;
        $this->stats = EmployeeStats::campus ($this->user['campus_id'])->get_stats ();
        $this->view->display ('admin/employees', ["stats" => $this->stats, "employees" => $this->employees()->status($status), "status" => $status]);
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
        $this->profile ($id,$view,'update');
    }

    public function employment_update ($id, $tab = 'employment_info', $result = NULL) {
        $this->employment ($id,$tab,'update', $result);
    }

    public function save ($id, $tab = 'basic-info') {
        $empUpd = $this->update_profile($id,$_POST['employeeinfo'],$tab);
        header ("location: /employees/profile/$id/$tab");
    }

    // public function submit () {
    //     header ("location: /profile")
    // }

    public function add_profile_info ($id, $tab = 'basic-info') {
        $empAdd = EmployeesController::add_profile($id,$_POST['employeeinfo'],$tab);
        header ("location: /employees/update/$id/$tab");
    }

    public function registration ($success = NULL) {
        $positions = Position::positions()->all ();
        $presets = Schedule::presets()->all ();
        $this->view->display ('admin/employee_registration', ['positions' => $positions, 'emp_type' => $this->type(), 'schedules' => $presets , 'departments' => $this->departments(), 'designations' => $this->designations(), 'id' => $this->new_id ('1'), 'message' => $message]);
    }

    public function employment ($id, $tab = 'employment_info', $view = 'view', $message = NULL) {
        if ($success) $message = ['success' => '1', 'message' => 'New employee has been successfully registered!'];
        $this->employee = new EmployeeProfile ($id);
        try {
            $this->employee->{str_replace ("-", "_", $tab)}();
        } catch (\Throwable $th) {
            $tab = 'employment_info';
            $this->employee->info ();
        }
        $presets = Schedule::presets()->all();
        $positions = Position::positions()->type ($this->employee->info['etype_id']);
        $this->view->display ('admin/employee_employment', ['positions' => $positions, 'emp_type' => $this->type (), 'employee' => $this->employee, 'tab' => $tab, 'view' => $view, 'presets' => $presets , 'departments' => $this->departments(), 'designations' => $this->designations(), 'message' => $message]);
    }
}