<?php
namespace Model;

use Database\DB;
class Position {
    static $positions;

    public static function type ($type) {
        if(!self::$positions) self::positions ();
        $positions = [];
        foreach(self::$positions as $position) {
            if($position['etype_id'] == $type) $positions[] = $position;
        }
        return $positions;
    }

    public static function positions () {
        self::$positions = DB::fetch_all ("SELECT * FROM tbl_position WHERE 1 ORDER BY position_code ASC");
        return new self();
    }
    
    public static function find ($id) {
        return DB::fetch_row ("SELECT b.position_desc as position FROM tbl_employee_employment a, tbl_position b WHERE a.position = b.no AND a.employee_id = ? and a.date_to IS NULL ORDER BY date_from DESC", $id)['position'];
    }
}