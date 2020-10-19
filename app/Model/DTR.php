<?php
namespace Model;

use Database\DB;
use Model\Employee;

class DTR {

    public static function dtr_code () {
        return DB::db("db_master")->fetch_all("SELECT * FROM tbl_dtr_code");
    }

    public static function get_sched ($id, $day = NULL) {
        if ($day) {
            $sched = DB::db("db_master")->fetch_all("SELECT * FROM tbl_schedule  WHERE sched_code = (SELECT sched_code FROM tbl_employee_sched WHERE employee_id = ? ORDER BY `date` DESC LIMIT 0,1) AND weekday = ?", [$id,$day]);
        } else {
            $sched = DB::db("db_master")->fetch_all("SELECT * FROM tbl_schedule WHERE sched_code = (SELECT sched_code FROM tbl_employee_sched WHERE employee_id = ? ORDER BY `date` DESC LIMIT 0,1)", $id);
        }
        return $sched;
    }

    public static function is_payable ($code, $id) {
        if ($code == "BO:BO") {
            return True;
        } else {
            $type = DB::fetch_row ("SELECT etype_id FROM tbl_employee_status WHERE employee_id = ? ORDER BY date_start DESC LIMIT 0,1", $id)['etype_id'];
            $pay = DB::fetch_row ("SELECT payable FROM tbl_dtr_code WHERE dtr_code = ?",$code)['payable'];
            if (($type <= 4) & ($pay == 1)) return True;
            else return False;
        }
    }
}