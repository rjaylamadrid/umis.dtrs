<?php
use Controllers\LeaveController;
use Database\DB;
use Model\EmployeeProfile;
use Model\Position;

class Leave extends LeaveController{
    public $office;
    public $employee;

    public function index () {
        $this->employee = new EmployeeProfile ($this->user['employee_id']);
        // print_r($this->employee);
        // $dept_id = $this->employee->info.department_id;
        // $this->office = DB::fetch_row ("SELECT department_desc FROM tbl_department WHERE department_code = ?", $dept_id);
        $this->view->display ('leave', ["employee" => $this->employee, "office" => $this->office]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }
}