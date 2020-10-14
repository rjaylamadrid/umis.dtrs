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
            $attendance = $this->attendance ($this->data['employee_id'], ["from" => $this->data['date_from'], "to" => $this->data['date_to']], ($this->data['period'] - 1))->compute (); // Employee Attendance
            $profile = Employee::find ($this->data['employee_id'])->get ();
            $campus = Employee::get_campus($this->user['campus_id']);
            if ($this->data['per_month']) {
                for($i = 0; $i < count($attendance['month']); $i++) {
                    $begin = new DateTime(date_create($attendance['month'][$i])->format('Y-m-01'));
                    $end = new DateTime(date_create($attendance['month'][$i])->format('Y-m-t'));
                    $interval = new DateInterval('P1D');
                    $daterange = new DatePeriod($begin, $interval, $end->modify('+1 day'));

                    $vars = ["attendance" => $attendance, "employee" => $profile, "campus" => $campus, "daterange" => $daterange, "month" => [$attendance['month'][$i]]];
                    $pdf[] = $this->dtr_data ($vars);
                }
            } else {
                $begin = new DateTime($this->data['date_from']);
                $end = new DateTime($this->data['date_to']);
                $interval = new DateInterval('P1D');
                $daterange = new DatePeriod($begin, $interval, $end->modify('+1 day'));

                $vars = ["attendance" => $attendance, "employee" => $profile, "campus" => $campus, "daterange" => $daterange, "month" => $attendance['month']];
                $pdf[] = $this->dtr_data ($vars);
            }
            $this->to_pdf($pdf);
        }
    }

    protected function generate () {
        if ($this->data['emp_type']) $employees = Employee::type ($this->data['emp_type']);
        else $employees = Employee::getAll();
        $this->view->display ('attendance', ["period" => $this->data, "emp_type" => Position::emp_type(), "employees" => $employees, "posted" => $this->is_posted ($this->data), "month" => $this->data['month']]);
    }

    protected function get_attendance () {
        $attendance = $this->attendance ($this->data['id'], ["from" => $this->data['date_from'], "to" => $this->data['date_to']], ($this->data['period'] - 1))->compute ();
        $begin = new DateTime(date_create($this->data['date_from'])->format('Y-m-d'));
        $end = new DateTime(date_create($this->data['date_to'])->format('Y-m-d'));
        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod($begin, $interval, $end->modify('+1 day'));

        $this->view->display ('custom/dtr', ["attendance" => $attendance, "period" => $this->data, "daterange" => $daterange]);
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