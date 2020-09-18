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