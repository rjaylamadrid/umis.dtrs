<?php
namespace Model;

use Database\DB;
use Model\Position;

class Employee {
    static $employee;
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
            if ($e['etype_id'] == $type) $employees[] = $e;
        }
        return $employees;
    }
    
    public function status ($status = '1', $campus) {
        if (!self::$employees) self::employees ();
        $employees = [];
        foreach (self::$employees as $e) {
            if ($e['active_status'] == $status && $e['campus_id'] == $campus) $employees[] = $e;
        }
        return $employees;
    }

    public static function employees () {
        self::$employees = DB::fetch_all ("SELECT a.employee_id as employee_id, a.no as employee_no, first_name, last_name, gender, birthdate, active_status, b.* FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.no = (SELECT no FROM tbl_employee_status WHERE employee_id = a.no ORDER BY date_start DESC LIMIT 0,1) ORDER BY last_name ASC");
        return new self();
    }

    public static function position () {
        if (!self::$employees) self::employees ();
        $employees = [];
        foreach (self::$employees as $e) {
            $position = Position::position($e['position_id'])->find(); 
            $e['position'] = $position['position_desc'];
            $employees[] = $e;
        }
        self::$employees = $employees;
        return new self();
    }

    public static function find ($id) {
        self::$employee = DB::db("db_master")->fetch_row ("SELECT a.first_name, a.middle_name, a.last_name, b.*, a.employee_id  FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.employee_id = ? GROUP BY a.employee_id", $id);
        return new static();
    }

    public static function info ($profile) {
        if (self::$employee) {
            $stmt = '';
            if ($profile == "tbl_employee_education") {
                $stmt = " ORDER BY year_graduated";
            } elseif ($profile == "tbl_employee_employment") {
                $stmt = " ORDER BY date_from";
            }
            return DB::fetch_all ("SELECT * FROM $profile WHERE employee_id = ? $stmt", self::$employee['id']);
        }
    }

    public static function get () {
        return self::$employee;
    }
}