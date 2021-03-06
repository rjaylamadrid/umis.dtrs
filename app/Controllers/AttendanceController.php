<?php
namespace Controllers;

use Database\DB;
use Model\DTR;
use Model\Employee;
use DateTime;
use DateInterval;
use DatePeriod;
use View\PDF;

class AttendanceController extends Controller {
    private $period = [['01', '15'], ['16', '31'], ['01', '31']];
    public $attendance;

    protected function attendance ($id, $arr, $period = 2) {
        if (!($period == '3')) {
            if (($period == '2') || ($period == '1')) $this->period[$period][1] = date_create($arr['from'])->format('t');
            $tables[] = ["table" =>  date_create($arr['from'])->format('m-Y') , "begin" => date_create($arr['from'])->format('Y-m-'.$this->period[$period][0]), "end" => date_create($arr['from'])->format('Y-m-'.$this->period[$period][1])];
        } else {
            $table1 = date_create($arr['from'])->format('m-Y');
            $table2 = date_create($arr['to'])->format('m-Y');
            if ($table1 == $table2) {
                $tables[] = ["table" => $table1, "begin" => $arr['from'], "end" => $arr['to']];
            } else {
                $tables[] = ["table" => $table1, "begin" => $arr['from'], "end" => date_create($arr['from'])->format('Y-m-t')];
                $tables[] = ["table" => $table2, "begin" => date_create($arr['to'])->format('Y-m-01'), "end" => $arr['to']];
            }
        }

        foreach ($tables as $table) {
            $attendance['month'][] = date_create($table['begin'])->format('F, Y');
            $dtr = DB::db("db_attendance")->fetch_all ("SELECT * FROM `".$table['table']."` WHERE emp_id = ? AND `date` >= ? AND `date` <= ?", [$id, $table['begin'], $table['end']]);
            if (($dtr) && ($attendance['attn'])) $attendance['attn'] = array_merge($attendance['attn'], $dtr);
            if (!$attendance['attn']) $attendance['attn'] = $dtr;
        }
        $this->attendance = $attendance;
        return $this;
    }


    protected function authenticate($attn){
        if ($attn) {
            $data = $attn['date'].$attn['emp_id'].$attn['am_in'].$attn['am_out'].$attn['pm_in'].$attn['pm_out'].$attn['ot_in'].$attn['ot_out'];
            $data = md5(utf8_encode($data), TRUE);
            if(base64_encode($data) == $attn['signature']){
                $result = "true";
            }else{
                $result = "false";
            }
        }
        return $result;
    }

    protected function compute () {
        $attendance = [];
        if ($this->attendance['attn']) {
            for ($i=0; $i < sizeof ($this->attendance['attn']); $i++) {
                $this->attendance['attn'][$i]['auth'] = $this->authenticate($this->attendance['attn'][$i]);
                $attendance['attn'][$this->attendance['attn'][$i]['date']] = $this->attendance['attn'][$i];
                $attendance['total'] += $this->attendance[$i]['attn']['total_hours'];
                $attendance['ut'] += ($this->attendance[$i]['attn']['late'] + $this->attendance[$i]['attn']['undertime']); 
            }
        }
        $attendance['month'] = $this->attendance['month'];
        $this->attendance = $attendance;
        return $this->attendance;
    }

    protected function is_posted ($period) {
        $tables = [];
        $start = date_create($period['date_from'])->format('m-Y');
        $end = date_create($period['date_to'])->format('m-Y');
        for ($y = intval(substr($start, 3)); $y <= intval(substr($end, 3)); $y++) {
            for ($i = intval(substr($start, 0, 2)); $i <= intval(substr($end, 0, 2)); $i++) {
                if ($i < 10) $i = '0'.$i;
                $table = $i.'-'.$y;
                $posted = $this->check_table($table);
                if (!($posted)) $tables = ["month" => $i, "year" => $y];
            }
        }
        return $tables;
    }

    protected function check_table ($table) {
        return DB::db("db_attendance")->fetch_row ("SHOW tables LIKE '$table'");
    }

    protected function get_raw_data ($period, $args) {
        $raw_data = DB::db("db_raw_data")->fetch_all ("SELECT * FROM `$period` WHERE emp_id = ? AND log_date = ?", $args); 
        foreach($raw_data as $data) {
            $campus  = Employee::get_campus($data['campus_id']);
            $data['campus'] = $campus['campus_name'];
            $logs[] = $data;
        }
        return $logs;
    }

    protected function find ($period, $no) {
        return DB::db("db_attendance")->fetch_row ("SELECT * FROM `$period` WHERE id = ?", $no);
    }

    protected function to_pdf ($data, $title) {
        PDF::preview ($data, $title);
    }
    
    protected function dtr_data ($vars) {
        $pdf['content'] = $this->view->render ("pdf/dtr", $vars);
        $pdf['options'] = ["orientation" => "portrait"];
        return $pdf;
    }

    protected function save_log () {
        DTR::change_log ($this->data['employee_id'], $this->data['attnd'],$this->data['period'], $this->data['date'], $this->data['no'], $this->data['ot-paid']);
    }

    protected function set_default () {
        $interval = new DateInterval('P1D');
        $date_from = new DateTime($this->data['date_from']);
        $date_to = new DateTime($this->data['date_to']);
        $daterange = new DatePeriod($date_from, $interval, $date_to->modify('+1 day'));
        
        if ($this->data['employee_id']) {
            foreach ($daterange as $date) {
                $this->send_default($this->data['employee_id'], $date, date_format($date, 'm-Y'));
            }
        } else {
            if ($this->data['emp_type']) $employees = Employee::type ($this->data['emp_type']);
            else $employees = Employee::getAll();
            foreach ($employees as $employee) {
                foreach ($daterange as $date) {
                    $this->send_default($employee['employee_no'], $date, date_format($date, 'm-Y'));
                }
            }
        }
    }

    protected function send_default($id, $date, $period) {
        $period = date_format($date, 'm-Y');
        $sched = DTR::get_sched ($id, $date);
        if ($sched) {
            $logs = DTR::get_log ($period, [$id,date_format($date, 'Y-m-d')]);
            if (($sched) && (!($logs))) {
                $attnd = [$sched[0]['am_in'],$sched[0]['am_out'],$sched[0]['pm_in'],$sched[0]['pm_out']];
                DTR::change_log ($id, $attnd, $period, date_format($date, 'Y-m-d'));
            }
        }
    }  
}