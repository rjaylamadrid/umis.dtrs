<?php
use Controllers\LeaveController;
use Database\DB;
use Model\EmployeeProfile;
use Model\Position;

class Leave extends LeaveController{
    public $office;
    public $employee;
    private $status = 0;

    public function index () {
        $this->employee = new EmployeeProfile ($this->user['employee_id']);
        $this->office = DB::fetch_all ("SELECT a.department_desc, b.date_start FROM tbl_department a, tbl_employee_status b WHERE a.no = b.department_id AND b.employee_id = ? AND b.is_active = ?", [$this->user['employee_id'],1]);
        // $this->user['is_admin'] ? '' : $this->getLeaveCredits();
        
        $this->getLeaveCredits();
        $this->getLeaveRecord($this->status);
        // $this->getLeaveChanges();
        $attendance = $this->attendance($this->employee->id, ["from" => $this->leave_credits['date_credited'], "to" => date('Y-m-d')]);
        $this->view->display ('leave', ["employee" => $this->employee, "position" => $this->employee->position, "office" => $this->office, "credits" => $this->leave_credits, "changes" => $this->leave_changes, "records" => $this->leave_record, "attendance" => $attendance, "balance" => $this->leave_balance, "leave_types" => $this->leave_types, "requests" => $this->all_leave_requests, "tab" => $this->status, "stats" => $this->stats, "emp_list" => $this->emp_list, "message" => $this->message]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    public function tab ($tab) {
        $this->status = $tab;
        $this->index();
    }

    public function show_leave_credits () {
        $this->getLeaveCredits('forced_leave', $this->data['emp_id']);
        $this->getLeaveRecord('', 'forced_leave', $this->data['emp_id']);
        $attendance = $this->attendance($this->data['emp_id'], ["from" => $this->leave_credits['date_credited'], "to" => date('Y-m-d')]);
        
        $this->view->display ('custom/show_leave_credits', ["vl" => $this->leave_balance[sizeof($this->leave_balance)-1]['vacation'], "sl" => $this->leave_balance[sizeof($this->leave_balance)-1]['sick'], "changes" => $this->leave_changes]);
    }

    public function emp_leave_record () {
        $this->getLeaveCredits('forced_leave', $this->data['emp_id']);
        $this->getLeaveRecord('', 'forced_leave', $this->data['emp_id']);
        $attendance = $this->attendance($this->data['emp_id'], ["from" => $this->leave_credits['date_credited'], "to" => date('Y-m-d')]);
        
        $this->view->display ('custom/leave_record_card', ["balance" => $this->leave_balance, "changes" => $this->leave_changes]);
    }
}