<?php
namespace Model;

use Database\DB;
use Model\Employee;

class DTR {

    public static function dtr_code () {
        return DB::db("db_master")->fetch_all("SELECT * FROM tbl_dtr_code ORDER BY dtr_code ASC");
    }

    public static function get_sched ($id, $date = NULL) {
        if ($date) {
            $day = date_format($date,'l');
            $sched = DB::db("db_master")->fetch_all("SELECT * FROM tbl_schedule  WHERE sched_code = (SELECT sched_code FROM tbl_employee_sched WHERE employee_id = ? AND `date` <= ? ORDER BY `date` DESC LIMIT 0,1) AND weekday = ?", [$id, $date->format('Y-m-d'), $day]);
        } else {
            $sched = DB::db("db_master")->fetch_all("SELECT * FROM tbl_schedule WHERE sched_code = (SELECT sched_code FROM tbl_employee_sched WHERE employee_id = ? ORDER BY `date` DESC LIMIT 0,1)", $id);
        }
        return $sched;
    }

    public static function is_payable ($code, $id) {
        $result = False;
        $pay = DB::db('db_master')->fetch_row ("SELECT * FROM tbl_dtr_code WHERE dtr_code = ?",$code);
        if (($pay['payable'] == "1") && ($pay['affected'] == "1")) {
            $result = True;
        } elseif ($pay) {
            $type = DB::db('db_master')->fetch_row ("SELECT a.jo FROM tbl_employee_type a, tbl_employee_status b WHERE employee_id = ? AND a.etype_id = b.etype_id ORDER BY date_start DESC LIMIT 0,1", $id);
            if ($type['jo'] == "0") {
                $result = True;
            }
        }
        return $result;
    }

    public static function change_log ($id, $attnd, $period, $date, $log_no = NULL) {
        $attendance = self::compute_log ($attnd, $id, $date);
        if ($log_no) {
            DB::db('db_attendance')->update("UPDATE `$period` SET ". DB::stmt_builder($attendance)." WHERE id = ".$log_no, $attendance);
        } else {
            $signature = $date.$id;
            $attendance['signature'] = base64_encode(md5(utf8_encode($signature), TRUE));
            $attendance['emp_id'] = $id;
            $attendance['date'] = $date;
            DB::db('db_attendance')->insert ("INSERT IGNORE INTO `$period` SET ". DB::stmt_builder($attendance), $attendance);
        }
    }  

    public static function compute_log ($attnd, $id, $date) {
        $preset = ["am_in", "am_out", "pm_in", "pm_out", "ot_in", "ot_out"];
        $attendance = ["is_absent" => 1, "total_hours" => 0, "late" => 0, "undertime" => 0];
        $sched = self::get_sched($id, date_create($date));
        if ($sched) {
            for ($i = 0; $i < 6; $i++) {
                if ($i < 4) { 
                    $payable = self::is_payable($attnd[$i], $id);
                    if ($payable) {
                        $code = $attnd[$i];
                        $attnd[$i] = $sched[0][$preset[$i]];
                    }
                    if (($attnd[$i]) && (date_create($attnd[$i]))) {
                        $schedule = date_create($sched[0][$preset[$i]]);
                        $log = date_create($attnd[$i]);
                        if (($i == 0) || ($i == 2)) {
                            if ($attnd[$i+1]) {
                                $late = $log > $schedule ? (strtotime($attnd[$i]) - strtotime($sched[0][$preset[$i]]))/60 : 0;
                                $attendance['late'] += $late;
                            }
                        } else {
                            if ($attnd[$i-1]) {
                                $undertime = $log < $schedule ? (strtotime($sched[0][$preset[$i]]) - strtotime($attnd[$i]))/60 : 0;
                                $attendance['undertime'] += $undertime;
                                if (date_create($attnd[$i-1]) && date_create($attnd[$i])) {
                                    $start = $late > 0 ? $attnd[$i-1] : $sched[0][$preset[$i-1]];
                                    $end = $undertime > 0 ? $attnd[$i] : $end = $sched[0][$preset[$i]];
                                    $attendance['total_hours'] += ((strtotime($end) - strtotime($start))/60)/60;
                                    $attendance['is_absent'] -= .5;
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
     
    public static function get_log ($period, $args) {
        return DB::db("db_attendance")->fetch_row ("SELECT * FROM `$period` WHERE emp_id = ? AND date = ?", $args);
    }

    public static function create_table ($period) {
        $query = "CREATE TABLE `$period` (
            `id` int(10) UNSIGNED NOT NULL,
            `emp_id` int(10) NOT NULL,
            `date` char(20) NOT NULL,
            `am_in` char(20) DEFAULT NULL,
            `am_out` char(20) DEFAULT NULL,
            `pm_in` char(20) DEFAULT NULL,
            `pm_out` char(20) DEFAULT NULL,
            `ot_in` char(20) DEFAULT NULL,
            `ot_out` char(20) DEFAULT NULL,
            `is_absent` double(3,2) DEFAULT NULL,
            `total_hours` double(3,2) DEFAULT NULL,
            `late` smallint(6) DEFAULT NULL,
            `undertime` smallint(6) NOT NULL DEFAULT '0',
            `remarks` char(255) DEFAULT NULL,
            `status` tinyint(4) NOT NULL DEFAULT '0',
            `signature` char(32) DEFAULT NULL
          ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

          ALTER TABLE `$period`
            ADD PRIMARY KEY (`id`),
            ADD UNIQUE KEY `signature` (`signature`),
            ADD KEY `emp_id` (`emp_id`);

          ALTER TABLE `$period`
            MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

          ALTER TABLE `$period`
            ADD CONSTRAINT `$period_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `db_master`.`tbl_employee` (`no`);";
        return DB::db('db_attendance') -> insert ($query);
    }
}