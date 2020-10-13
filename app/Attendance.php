<?php
use Controllers\AttendanceController;
use Model\Employee;
use Model\Position;

class Attendance extends AttendanceController {
    private $month;

    public function index () {
        if (!($this->month)) $this->month = date('m');
        $this->view->display ('attendance', ["emp_type" => Position::emp_type(), "month" => $this->month]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        } 
    }

    public function print_preview () {
        if ($this->data) {
            $attendance = $this->attendance ($this->data['employee_id'], ["month" => $this->data['month'], "year" => $this->data['year']])->compute (); // Employee Attendance
            $profile = Employee::find ($this->data['employee_id'])->get ();
            $campus = Employee::get_campus($this->user['campus_id']);
            
            $vars = ["attendance" => $attendance, "employee" => $profile, "campus" => $campus];
            
            $pdf['content'] = $this->view->render ("pdf/dtr", $vars);
            $pdf['options'] = ["orientation" => "portrait"];
            $this->to_pdf ($pdf);
        }
    }

    protected function generate () {
        if ($this->data['emp_type']) $employees = Employee::type ($this->data['emp_type']);
        else $employees = Employee::getAll();
        $this->view->display ('attendance', ["period" => $this->data, "emp_type" => Position::emp_type(), "employees" => $employees, "posted" => $this->is_posted ($this->data), "month" => $this->data['month']]);
    }

    protected function get_attendance () {
        $attendance = $this->attendance ($this->data['id'], ["month" => $this->data['month'], "year" => $this->data['year']], ($this->data['period'] - 1))->compute ();
        $this->view->display ('custom/dtr', ["attendance" => $attendance, "period" => $this->data]);
    }

    protected function raw_data () {
        $this->view->display ("custom/attendance_raw_data", ["rawdata" => $this->get_raw_data ($this->data['period'], [$this->data['id'], $this->data['date']])]);
    }

    protected function update_log () {
        $attn = $this->find ($this->data['month'].'-'.$this->data['year'], $this->data['id']);
        $rawdata = $this->get_raw_data ($this->data['month'].'-'.$this->data['year'], [$this->data['emp_id'], $this->data['date']]);

        $this->view->display ("custom/attendance_update_log", ["attn" => $attn, "rawdata" => $rawdata]);
    }
}