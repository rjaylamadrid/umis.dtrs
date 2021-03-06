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
        $result = DB::fetch_row ("SELECT COUNT(*) as total FROM (SELECT is_active FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.campus_id = ? AND b.no = (SELECT no FROM tbl_employee_status WHERE employee_id = a.no ORDER BY date_start DESC LIMIT 0,1)) a WHERE is_active = ?", [self::$campus, $status]);
        return $result['total'];
    }

    public static function employees_status () {
        return DB::fetch_row ("SELECT COUNT(CASE WHEN b.isJobOrder=0 THEN 1 END) Permanent, COUNT(CASE WHEN b.isJobOrder=1 THEN 1 END) COS FROM tbl_employee_status a, tbl_employee_type b, tbl_position c WHERE a.is_active = 1 AND a.campus_id = ? AND a.position_id = c.no AND c.etype_id = b.id", self::$campus);
    }

    public static function employees_gender () {
        return DB::fetch_row ("SELECT COUNT(CASE WHEN gender='Male' THEN 1 END) AS Male, COUNT(CASE WHEN gender='Female' THEN 1 END) AS Female FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.campus_id = ? AND b.is_active = 1", self::$campus);
    }
}