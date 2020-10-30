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
            $interval = new DateInterval('P1D');
            $begin = date_create($this->data['date_from']);
            $end = date_create($this->data['date_to']);
            
            if ($this->data['employee_id']) {
                $employees[] = Employee::find ($this->data['employee_id'])->get();
            } else {
                $employees = $this->data['emp_type'] ? Employee::type ($this->data['emp_type']) : Employee::getAll();
            }

            $month = ['0'=> $begin->format('F, Y'), '1' => $end->format('F, Y')];
            if ($this->data['per_month']) {
                $daterange = new DatePeriod(new DateTime($begin->format('Y-m-01')), $interval, new DateTime($begin->format('Y-m-t+1')));
                $datas[] = ["month" => $month[0], "daterange" => $daterange, "from" => $begin, "to" =>$end];
                if (!($month[0] == $month[1])) {
                    $datas[0]['to'] = new DateTime($begin->format('Y-m-t'));
                    $daterange = new DatePeriod(new DateTime($end->format('Y-m-01')), $interval, new DateTime($end->format('Y-m-t+1')));
                    $datas[] = ["month" => $month[1], "daterange" => $daterange, "from" => new DateTime($end->format('Y-m-01')), "to" =>$end];
                }
            } else {
                $daterange = new DatePeriod(new DateTime($begin->format('Y-m-d')), $interval, new DateTime($end->format('Y-m-d+1')));
                if (!($month[0] == $month[1])) $month[0] = $month[0]." - ".$month[1];
                $datas[] = ["month" => $month[0], "daterange" => $daterange, "from" => $begin, "to" =>$end];
            }

            $campus = Employee::get_campus($this->user['campus_id']);
            foreach ($employees as $profile) {
                $attendance = $this->attendance ($profile['employee_no'], ["from" => $begin->format('Y-m-d'), "to" => $end->format('Y-m-d')], ($this->data['period'] - 1))->compute (); // Employee Attendance
                foreach($datas as $data) {
                    $tdays = $data['to']->diff($data['from'])->format('%a')+1;
                    $cdays = ($tdays + intval($data['from']->format('w')))-1;
                    $sat = intval($cdays/7);
                    $days = $tdays - (2 * $sat);
                    if (($cdays % 7) >= 6) { 
                        $sat++;
                        $days--;
                    }
                    $vars = ["attendance" => $attendance, "employee" => $profile, "campus" => $campus, "daterange" => $data['daterange'], "from" => $begin, "to" => $end, "month" => $data['month'], "days" => $days, "sat" => $sat];
                    $pdf[] = $this->dtr_data ($vars);
                }
            }
            $this->to_pdf($pdf); 
        }
    }

    protected function generate () {
        $employees = $this->data['emp_type'] ? Employee::type ($this->data['emp_type']) : Employee::getAll();
        $emp_type = Position::emp_type();

        $this->view->display ('attendance', ["period" => $this->data, "emp_type" => $emp_type, "employees" => $employees, "posted" => $this->is_posted ($this->data)]);
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
        $period = date_create($this->data['date'])->format('m-Y');
        $this->view->display ("custom/attendance_raw_data", ["rawdata" => $this->get_raw_data ($period, [$this->data['id'], $this->data['date']])]);
    }

    protected function update_log () {
        $period = date_create($this->data['date'])->format('m-Y');
        $attn = $this->find ($period, $this->data['id']);
        $rawdata = $this->get_raw_data ($period, [$this->data['emp_id'], $this->data['date']]);
        $this->view->display ("custom/attendance_update_log", ["attn" => $attn, "rawdata" => $rawdata, "codes" => DTR::dtr_code(), "period" => $period, "employee_id" => $this->data['emp_id'], "date" => $this->data['date']]);
    }

    protected function sync_attendance () {
        print_r($this->data);
    }
}