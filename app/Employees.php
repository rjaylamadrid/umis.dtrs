<?php
use Model\Employee;
use Model\EmployeeStats;
use Model\EmployeeProfile;
use Controllers\EmployeesController;
use Model\Position;

class Employees extends EmployeesController {
    private $stats;
    public $employee;

    public function index () {
        $this->stats = EmployeeStats::campus ($this->user['campus_id'])->get_stats ();
        $this->view->display ('admin/employees', ["stats" => $this->stats, "employees" => $this->employees()->all()]);
    }

    public function profile ($id = null, $view = 'basic-info') {
        $this->employee = new EmployeeProfile ($id);
        $this->employee->{str_replace ("-", "_", $view)}();
        print_r ($this->employee);
        $this->view->display ('profile', ["employee" => $this->employee, "tab" => $view]);
    }

    public function do_action () {
        
    }

    public function update ($id, $view = 'basic-info') {
        $table = $view == 'basic-info' ? 'tbl_employee' : 'tbl_employee_'.str_replace ("-", "_", $view);
        $emp = Employee::find($id)->info($table);
        $this->view->display ('profile', ["employee" => Employee::$employee, "emp" => $emp, "tab" => $view, "view" => "update"]);
    }

    public function save ($id, $view = 'basic-info') {
        
        header ("location: /employees/profile/$id/$view");
    }

    public function registration (){    
        $positions = Position::positions();
        $this->view->display ('admin/employee_registration', ['positions' => $positions, 'emp_type' => $this->type()]);
    }
}