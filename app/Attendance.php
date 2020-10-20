<?php
use Controllers\AttendanceController;
use Model\Employee;
use Model\Position;
use Model\DTR;

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
            
            $begin = date_create($this->data['date_from']);
            $end = date_create($this->data['date_to'])->modify('+1 day');
            if ($this->data['month']) {
                $begin = date_create($this->data['year']."-".$this->data['month']."-01");
                $end = date_create($this->data['year']."-".$this->data['month'])->format('Y-m-t+1');
                $end = date_create($end);
            }
            if ($this->data['employee_id']) {
                $employees[] = Employee::find ($this->data['employee_id'])->get();
            } else {
                if ($this->data['emp_type']) $employees = Employee::type ($this->data['emp_type']);
                else $employees = Employee::getAll();
            }
            $interval = new DateInterval('P1D');
            $month = ['0'=> $begin->format('F, Y'), '1' => $end->format('F, Y')];
            if ($this->data['per_month']) {
                $daterange = new DatePeriod(new DateTime($begin->format('Y-m-01')), $interval, new DateTime($begin->format('Y-m-t+1')));
                $datas[] = ["month" => $month[0], "daterange" => $daterange];
                if (!($month[0] == $month[1])) {
                    $daterange = new DatePeriod(new DateTime($end->format('Y-m-01')), $interval, new DateTime($end->format('Y-m-t+1')));
                    $datas[] = ["month" => $month[1], "daterange" => $daterange];
                }
            } else {
                $daterange = new DatePeriod(new DateTime($begin->format('Y-m-d')), $interval, new DateTime($end->format('Y-m-d')));
                if (!($month[0] == $month[1])) $month[0] = $month[0]." - ".$month[1];
                $datas[] = ["month" => $month[0], "daterange" => $daterange];
            }
            $campus = Employee::get_campus($this->user['campus_id']);
            foreach ($employees as $profile) {
                $attendance = $this->attendance ($profile['employee_no'], ["from" => $begin->format('Y-m-d'), "to" => $end->format('Y-m-d')], ($this->data['period'] - 1))->compute (); // Employee Attendance
                foreach($datas as $data) {
                    $vars = ["attendance" => $attendance, "employee" => $profile, "campus" => $campus, "daterange" => $data['daterange'], "month" => $data['month']];
                    $pdf[] = $this->dtr_data ($vars);
                }
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

        $this->view->display ('custom/dtr', ["attendance" => $attendance, "period" => $this->data, "daterange" => $daterange, "employee_id" => $this->data['id']]);
    }

    protected function raw_data () {
        $this->view->display ("custom/attendance_raw_data", ["rawdata" => $this->get_raw_data ($this->data['period'], [$this->data['id'], $this->data['date']])]);
    }

    protected function update_log () {
        $period = $this->data['month'].'-'.$this->data['year'];
        $attn = $this->find ($period, $this->data['id']);
        $rawdata = $this->get_raw_data ($this->data['month'].'-'.$this->data['year'], [$this->data['emp_id'], $this->data['date']]);
        $this->view->display ("custom/attendance_update_log", ["attn" => $attn, "rawdata" => $rawdata, "codes" => DTR::dtr_code(), "period" => $period, "employee_id" => $this->data['emp_id'], "date" => $this->data['date']]);
    }
}