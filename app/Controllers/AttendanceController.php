<?php
namespace Controllers;

use Database\DB;
use Model\DTR;
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
            $attendance['month'][] =date_create($table['begin'])->format('F, Y');
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
        for ($i=0; $i < sizeof ($this->attendance['attn']); $i++) {
            $this->attendance['attn'][$i]['auth'] = $this->authenticate($this->attendance['attn'][$i]);
            $attendance['attn'][$this->attendance['attn'][$i]['date']] = $this->attendance['attn'][$i];
            $attendance['total'] += $this->attendance[$i]['attn']['total_hours'];
            $attendance['ut'] += ($this->attendance[$i]['attn']['late'] + $this->attendance[$i]['attn']['undertime']); 
        }
        $attendance['month'] = $this->attendance['month'];
        $this->attendance = $attendance;
        return $this->attendance;
    }

    protected function is_posted ($period) {
        $tbls = "";
        if ($period['period'] == "4") {
            $start = date_create($period['date_from'])->format('m-Y');
            $end = date_create($period['date_to'])->format('m-Y');
            for ($y = intval(substr($start, 3)); $y <= intval(substr($end, 3)); $y++) {
                for ($i = intval(substr($start, 0, 2)); $i <= intval(substr($end, 0, 2)); $i++) {
                    if ($i < 10) $i = '0'.$i;
                    $table = $i.'-'.$y;
                    $posted = DB::db("db_attendance")->fetch_row ("SELECT COUNT(*) AS count FROM `$table`");
                    if (!($posted['count'])) $tbls .= $table ." ";
                }
            }
        } else {
            $table = $period['month'].'-'.$period['year'];
            $posted = DB::db("db_attendance")->fetch_row ("SELECT COUNT(*) AS count FROM `$table`");
            if (!($posted['count'])) $tbls = $table;
        }
        return $tbls;
    }

    protected function get_raw_data ($period, $args) {
        return DB::db("db_raw_data")->fetch_all ("SELECT * FROM `$period` WHERE emp_id = ? AND log_date = ?", $args);
    }

    protected function find ($period, $no) {
        return DB::db("db_attendance")->fetch_row ("SELECT * FROM `$period` WHERE id = ?", $no);
    }

    protected function to_pdf ($data) {
        PDF::preview ($data);
    }
    
    protected function dtr_data ($vars) {
        $pdf['content'] = $this->view->render ("pdf/dtr", $vars);
        $pdf['options'] = ["orientation" => "portrait"];
        return $pdf;
    }

    protected function save_log () {
        $period =  $this->data['period'];
        $attendance = $this->compute_log($this->data['attnd'], $this->data['employee_id'], $this->data['date']);
        if ($this->data['no']) {
            DB::db('db_attendance')->update("UPDATE `$period` SET ". DB::stmt_builder($attendance)." WHERE id = ".$this->data['no'], $attendance);
        } else {
            $signature = $this->data['date'].$this->data['employee_id'];
            $attendance['signature'] = base64_encode(md5(utf8_encode($signature), TRUE));
            $attendance['emp_id'] = $this->data['employee_id'];
            $attendance['date'] = $this->data['date'];
            DB::db('db_attendance')->insert ("INSERT INTO `$period` SET ". DB::stmt_builder($attendance), $attendance);
        }
    }

    protected function compute_log ($attnd, $id, $date) {
        $preset = ["am_in", "am_out", "pm_in", "pm_out", "ot_in", "ot_out"];
        $attendance = ["is_absent" => 0, "total_hours" => 0, "late" => 0, "undertime" => 0];
        $day = date_create($date)->format('l');
        $sched = DTR::get_sched($id, $day);
        if ($sched) {
            for ($i = 0; $i < 6; $i++) {
                if ($i < 4) { 
                    $payable = DTR::is_payable($attnd[$i], $id);
                    if ($payable) {
                        $code = $attnd[$i];
                        $attnd[$i] = $sched[0][$preset[$i]];
                    }
                    if (($attnd[$i]) && (date_create($attnd[$i]))) {
                        $schedule = date_create($sched[0][$preset[$i]]);
                        $log = date_create($attnd[$i]);
                        if (($i == 0) || ($i == 2)) {
                            if ($attnd[$i+1]) {
                                $attendance['late'] += $log > $schedule ? (strtotime($attnd[$i]) - strtotime($sched[0][$preset[$i]]))/60 : 0;
                            }
                        } else {
                            if ($attnd[$i-1]) {
                                $attendance['undertime'] += $log < $schedule ? (strtotime($sched[0][$preset[$i]]) - strtotime($attnd[$i]))/60 : 0;
                                if (date_create($attnd[$i-1]) && date_create($attnd[$i])) {
                                    $attendance['total_hours'] += ((strtotime($attnd[$i]) - strtotime($attnd[$i-1]))/60)/60;
                                    $attendance['is_absent'] += .5;
                                }
                            }
                        }
                        $attendance[$preset[$i]] = $payable ? $code : $log -> format("g:iA");
                    } else { 
                        $attendance[$preset[$i]] = ":";
                    }
                } else {
                    $attendance[$preset[$i]] = $attnd[$i];
                }
            }
        }
        return $attendance;
    }
}