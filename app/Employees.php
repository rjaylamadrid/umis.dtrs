<?php
use Model\Position;
use Model\Employee;
use Model\EmployeeStats;
use Model\EmployeeProfile;
use Controllers\EmployeesController;

class Employees extends EmployeesController {
    private $stats;
    public $employee;

    public function index () {
        $this->stats = EmployeeStats::campus ($this->user['campus_id'])->get_stats ();
        $this->view->display ('admin/employees', ["stats" => $this->stats, "employees" => $this->employees()->all()]);
    }

    public function profile ($id = null, $view = 'basic-info') {
        $this->employee = new EmployeeProfile ($id);
        try {
            $this->employee->{str_replace ("-", "_", $view)}();
        } catch (\Throwable $th) {
            $view = 'basic-info';
            $this->employee->basic_info ();
        }
        $this->view->display ('profile', ["employee" => $this->employee, "tab" => $view, "view" => "view"]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        }
    }

    public function update ($id, $view = 'basic-info') {
        $table = $view == 'basic-info' ? 'tbl_employee' : 'tbl_employee_'.str_replace ("-", "_", $view);
        $emp = Employee::find($id)->info($table);
        $this->view->display ('profile', ["employee" => Employee::$employee, "emp" => $emp, "tab" => $view, "view" => "update"]);
    }

    public function save ($id, $view = 'basic-info') {
        header ("location: /employees/profile/$id/$view");
    }

    public function registration () {    
        $positions = Position::positions()->all ();
        $this->view->display ('admin/employee_registration', ['positions' => $positions, 'emp_type' => $this->type()]);
    }

    public function get_position () {
        $positions = Position::positions()->type ($this->data['type']);
        return $positions;
        //$this->view->display ()
    }
}