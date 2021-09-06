<?php
namespace Model;

use Database\DB;
class Schedule{
    static $presets;
    static $schedules;

    function all () {
        return self::$presets;
    }

    public static function presets () {
        self::$presets = DB::fetch_all ("SELECT * FROM tbl_schedule_preset WHERE 1 ORDER BY sched_code");
        return new self();
    }

    public static function schedule ($preset) {
        return DB::fetch_all ("SELECT * FROM tbl_schedule WHERE sched_code = ?", $preset);
    }

    public static function emp_sched ($emp_id) {
        return DB::fetch_row ("SELECT * FROM tbl_employee_sched WHERE employee_id = ? ORDER BY date DESC", $emp_id);
    }

    public static function get_schedules($emps) {
        $employees = [];
        foreach($emps as $emp) {
            $emp['sched'] = self::emp_sched($emp['employee_no']);
            $employees[] = $emp;
        }
        return $employees;
    }
}