<?php
namespace Model;

use Database\DB;
use Model\Employee;

class DTR {

    public static function dtr_code () {
        return DB::db("db_master")->fetch_all("SELECT * FROM tbl_dtr_code");
    }

    public static function get_sched ($id) {
        $sched_code = DB::db("db_master")->fetch_row("SELECT sched_code FROM tbl_employee_sched WHERE employee_id = ? ORDER BY `date` DESC LIMIT 0,1", $id);
        $sched = DB::db("db_master")->fetch_all("SELECT * FROM tbl_schedule WHERE sched_code = ?", $sched_code['sched_code']);
        return $sched;
    }
}