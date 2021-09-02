<?php
use Controllers\AttendanceController;
use Model\Employee;
use Model\Position;
use Model\DTR;

class Attendance extends AttendanceController {
    private $month;

    public function index () {
        $position = new Position();
        $position->emp_types();
        if (!($this->month)) $this->month = date('m');
        $this->view->display ('attendance', ["emp_type" => $position->emp_types, "month" => $this->month]);
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
            $month = ['0'=> $begin->format('F, Y'), '1' => $end->format('F, Y')];

            if ($this->data['employee_id']) {
                $employee = Employee::find ($this->data['employee_id'])->get();
                $title = $employee['last_name'].$month[0];
                $employees[] = $employee;
            } else {
                if ($this->data['emp_type']) {
                    $employees = Employee::type ($this->data['emp_type']);
                } else {
                    $employees = Employee::getAll();
                    $title = "CBSUA_".$month[0];
                }
            }

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
            $this->to_pdf($pdf, $title); 
        }
    }

    protected function generate () {
        $employees = $this->data['emp_type'] ? Employee::type ($this->data['emp_type']) : Employee::getAll();
        $position = new Position;
        $position->emp_types();

        $this->view->display ('attendance', ["period" => $this->data, "emp_type" => $position->emp_types, "employees" => $employees, "posted" => $this->is_posted ($this->data), "month" => $this->data['month']]);
    }

    protected function get_attendance () {
        $begin = new DateTime(date_create($this->data['date_from'])->format('Y-m-d'));
        $end = new DateTime(date_create($this->data['date_to'])->format('Y-m-d'));
        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod($begin, $interval, $end->modify('+1 day'));
        $attendance = $this->attendance ($this->data['id'], ["from" => $this->data['date_from'], "to" => $this->data['date_to']], ($this->data['period'] - 1))->compute ();

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
        $sched = DTR::get_sched($this->data['emp_id']);
        $scheds = [0 => $sched[0]['weekday'], 1 => $sched[1]['weekday'], 2 => $sched[2]['weekday'], 3 => $sched[3]['weekday'], 4 => $sched[4]['weekday'], 5 => $sched[5]['weekday'], 6 => $sched[6]['weekday']];
        //if(!(in_array(date_create($this->data['date'])->format('l'),$scheds))) { $checkbox = True; }
        $this->view->display ("custom/attendance_update_log", ["attn" => $attn, "rawdata" => $rawdata, "codes" => DTR::dtr_code(), "period" => $period, "employee_id" => $this->data['emp_id'], "date" => $this->data['date']]);
    }

    protected function sync_attendance () {
        $period = $this->data['month']."-".$this->data['year'];
        DTR::create_table($period);
    } 
}