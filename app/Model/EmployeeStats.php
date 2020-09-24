<?php
namespace Model;

use Database\DB;

class EmployeeStats {
    private static $campus;
    private static $stats;

    public static function campus ($id) {
        self::$campus = $id;
        return new self ();
    }

    public static function get_stats () {
        if (!self::$campus) return;

        self::$stats['total'] = self::employees_count ();
        self::$stats['type'] = self::employees_status ();
        self::$stats['gender'] = self::employees_gender ();
        self::$stats['inactive'] = self::employees_count (0);

        return self::$stats;
    }

    public static function employees_count ($status = 1) {
        $result = DB::fetch_row ("SELECT COUNT(*) as total FROM (SELECT active_status FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.campus_id = ? GROUP BY a.employee_id) a WHERE active_status = ?", [self::$campus, $status]);
        return $result['total'];
    }

    public static function employees_status () {
        return DB::fetch_row ("SELECT COUNT(CASE WHEN b.jo=0 THEN 1 END) permanent, COUNT(CASE WHEN b.jo=1 THEN 1 END) cos FROM tbl_employee_status a, tbl_employee_type b, tbl_position c WHERE a.active_status = 1 AND a.campus_id = ? AND a.position_id = c.no AND c.etype_id = b.etype_id", self::$campus);
    }

    public static function employees_gender () {
        return DB::fetch_row ("SELECT COUNT(CASE WHEN gender='Male' THEN 1 END) AS male, COUNT(CASE WHEN gender='Female' THEN 1 END) AS female FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.campus_id = ? AND b.active_status = 1", self::$campus);
    }
}