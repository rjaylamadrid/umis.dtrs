<?php
use Database\DB;

class Attendance {
    private $attendance;

    public static function code() {
        return DB::fetch_all("SELECT * FROM tbl_dtr_code");
    }
}