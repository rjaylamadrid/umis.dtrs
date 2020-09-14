<?php
use Controllers\EmployeesController;
use Model\Employee;
use Model\EmployeeStats;

class Employees extends EmployeesController {
    private $stats;

    public function index () {
        $this->stats = EmployeeStats::campus ($this->user['campus_id'])->get_stats ();
        $this->view->display ('admin/employees', ["stats" => $this->stats, "employees" => $this->employees()->all()]);
    }

    public function profile ($id = null, $view = 'basic-info') {
        $table = $view == 'basic-info' ? 'tbl_employee' : 'tbl_employee_'.str_replace ("-", "_", $view);

        $emp = Employee::find($id)->info($table);
        $this->view->display ('profile', ["employee" => Employee::$employee, "emp" => $emp, "tab" => $view]);
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
        $this->view->display ('admin/employee_registration');
    }
}