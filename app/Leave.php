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
        // print_r();
        // $dept_id = $this->employee->info.department_id;
        $this->office = DB::fetch_all ("SELECT a.department_desc, b.date_start FROM tbl_department a, tbl_employee_status b WHERE a.no = b.department_id AND b.employee_id = ? AND b.is_active = ?", [$this->user['employee_id'],1]);
        $this->getLeaveRecord();
        $this->getLeaveCredits();
        $this->getLeaveChanges();
        // $this->leaveBalanceChanges();
        // print_r($this->leave_balance);
        $attendance = $this->attendance($this->employee->id, ["from" => $this->leave_credits['date_credited'], "to" => date('Y-m-d')]);
        $this->view->display ('leave', ["employee" => $this->employee, "position" => $this->employee->position, "office" => $this->office, "credits" => $this->leave_credits, "changes" => $this->leave_changes, "records" => $this->leave_record, "attendance" => $attendance, "balance" => $this->leave_balance, "leave_types" => $this->leave_types]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }
}