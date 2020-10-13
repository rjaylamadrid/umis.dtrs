<?php
namespace Controllers;

use Database\DB;
use DateTime;
use DateInterval;
use DatePeriod;
use View\PDF;

class AttendanceController extends Controller {
    private $period = [[1, 15], [16, 31], [1, 31]];
    public $attendance;

    protected function attendance ($id, $arr, $period = 2) {
        $table = $arr['month'].'-'.$arr['year'];
        $begin = new DateTime ($arr['year'].'-'.$arr['month'].'-'.$this->period[$period][0]);
        $end = new DateTime ($arr['year'].'-'.$arr['month'].'-'.$this->period[$period][1]);
        $end = $end->modify( '+1 day');

        $interval = new DateInterval('P1D');
        $daterange = new DatePeriod($begin, $interval ,$end);
        
        $i = 0;
        foreach ($daterange as $date) {
            if (date_format($date, 'm') <= $arr['month']) {
                $attendance[$i]['date'] = date_format($date, 'Y-m-d');
                $attendance[$i]['attn'] = DB::db("db_attendance")->fetch_all ("SELECT * FROM `$table` WHERE emp_id = ? AND date = ?", [$id, date_format($date, 'Y-m-d')])[0];
                $attendance[$i]['attn'] = $this->authenticate($attendance[$i]['attn']);
            }
            $i++;
        }
        $this->attendance = $attendance;
        return $this;
    }

    protected function authenticate($attn){
        if ($attn) {
            $data = $attn['date'].$attn['emp_id'].$attn['am_in'].$attn['am_out'].$attn['pm_in'].$attn['pm_out'].$attn['ot_in'].$attn['ot_out'];
            $data = md5(utf8_encode($data), TRUE);
            if(base64_encode($data) == $attn['signature']){
                $attn['auth'] = "true";
            }else{
                $attn['auth'] = "false";
            }
        }
        return $attn;
    }

    protected function compute () {
        $attendance = [];
        for ($i=0; $i < sizeof ($this->attendance); $i++) {
            $attendance['attn'][$i] = $this->attendance[$i];
            $attendance['total'] += $this->attendance[$i]['attn']['total_hours'];
            $attendance['ut'] += ($this->attendance[$i]['attn']['late'] + $this->attendance[$i]['attn']['undertime']);
            $attendance['abs'] += $this->attendance[$i]['attn']['is_absent'];
        }
        return $attendance;
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
}