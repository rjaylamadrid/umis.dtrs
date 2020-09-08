<?php
use Database\DB;

class Employee {
    static $employees;
    static $campus;
    
    public static function getAll () {
        if (!self::$employees) self::employees ();
        return self::$employees;
    }

    public static function type ($type) {
        if (!self::$employees) self::employees ();
        $employees = [];
        foreach (self::$employees as $e) {
            if ($e['emp_type'] == $type) $employees[] = $e;
        }
        return $employees;
    }

    public static function employees () {
        self::$employees = DB::select ("SELECT a.first_name, a.middle_name, a.last_name, b.* FROM tbl_employee a, tbl_employee_status b WHERE a.employee_id = b.employee_id AND b.active_status = 1 GROUP BY a.employee_id ORDER BY a.last_name");
        return new self();
    }
}