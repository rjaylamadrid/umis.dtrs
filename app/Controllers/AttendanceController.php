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
                $attendance[$i]['attn'] = DB::db("db_attendance")->select ("SELECT * FROM `$table` WHERE emp_id = ? AND date = ?", [$id, date_format($date, 'Y-m-d')])[0];
            }
            $i++;
        }
        $this->attendance = $attendance;
        return $this;
    }

    protected function compute () {
        $attendance = [];
        for ($i=0; $i < sizeof ($this->attendance); $i++) {
            $attendance['attn'][$i] = $this->attendance[$i];
            $attendance['total'] += $this->attendance[$i]['attn']['total_hours'];
            $attendance['ut'] += ($this->attendance[$i]['attn']['late'] + $this->attendance[$i]['attn']['undertime']);
        }
        return $attendance;
    }

    protected function is_posted ($period) {
        $table = $period['month'].'-'.$period['year'];
        $posted = DB::db("db_attendance")->select ("SELECT COUNT(*) AS count FROM `$table`")[0];
        return $posted['count'] > 0;
    }

    protected function get_raw_data ($period, $args) {
        return DB::db("db_raw_data")->select("SELECT * FROM `$period` WHERE emp_id = ? AND log_date = ?", $args);
    }

    protected function find ($no) {
        foreach ($this->attendance as $attn) {
            if ($attn['attn']['id'] == $no) return $attn['attn'];
        }
    }
    protected function type () {
        return DB::select ("SELECT * FROM tbl_employee_type");
    }
    protected function to_pdf ($data) {
        PDF::preview ($data);
    }
}