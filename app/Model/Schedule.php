<?php
namespace Model;

use Database\DB;
class Schedule {
    static $presets;
    static $schedules;

    function all () {
        return self::$presets;
    }

    public static function presets () {
        self::$presets = DB::fetch_all ("SELECT * FROM tbl_schedule_preset WHERE 1 ORDER BY sched_code");
        return new self();
    }
}