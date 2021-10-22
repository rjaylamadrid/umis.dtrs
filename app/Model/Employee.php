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

    public static function type ($type=null, $status = '1') {
        if (!self::$employees) self::employees ();
        if($type) {
            $employees = [];
            foreach (self::$employees as $e) {
                if ($e['etype_id'] == $type) {
                    if ($e['is_active'] == $status) $employees[] = $e;
                }
            }
        }else{$employees = [];
            foreach (self::$employees as $e) {
                if ($e['is_active'] == $status) $employees[] = $e;
            }
        }
        return $employees;
    }
    
    public static function campus($campus = null) {
        if (!self::$employees) self::employees ();
        if ($campus) {
            $employees = [];
            foreach (self::$employees as $e) {
                if ($e['campus_id'] == $campus) $employees[] = $e;
            }
            self::$employees = $employees;
        }
        return new self();
    }

    public static function employees () {
        self::$employees = DB::fetch_all ("SELECT a.no as employee_no, a.employee_id as emp_id, first_name, middle_name, last_name, gender, birthdate, is_active, b.*, a.employee_id as employee_id FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.no = (SELECT no FROM tbl_employee_status WHERE employee_id = a.no ORDER BY date_start DESC LIMIT 0,1) ORDER BY last_name ASC");
        return new self();
    }

    public static function position () {
        if (!self::$employees) self::employees ();
        $employees = [];
        foreach (self::$employees as $e) {
            if($e['position_id']) {
                $position = new Position($e['position_id'], $e['date_start'], $e['etype_id']);
                $e['position'] = $position->position['position_desc'];
                $employees[] = $e;
            }
        }
        self::$employees = $employees;
        return new self();
        // return self::$employees;
    }

    public static function find ($id) {
        self::$employee = DB::db("db_master")->fetch_row ("SELECT a.no as employee_no, a.first_name, a.middle_name, a.last_name, b.*, a.employee_id  FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.employee_id = ? GROUP BY a.employee_id", $id);
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
    
    public static function getAll_id () {
        return DB::fetch_all ("SELECT a.no as employee_no FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.no = (SELECT no FROM tbl_employee_status WHERE employee_id = a.no ORDER BY date_start DESC LIMIT 0,1) ORDER BY last_name ASC");
    }

    public static function get () {
        return self::$employee;
    }

    public static function get_campus ($campus) {
        return DB::db("db_master")->fetch_row ("SELECT * FROM tbl_campus WHERE id = ?", $campus);
    }

    public static function employee_status ($is_cos = true, $is_active  = 1) {
        $employees = [];
        if ($is_cos) {
            for ($i = 1; $i<= 4; $i++){
                $employee = self::type($i, $is_active);
                $employees = array_merge ($employees, $employee);
            }
        } else {
            for ($i = 5; $i<= 7; $i++){
                $employee = self::type($i, $is_active);
                $employees = array_merge ($employees, $employee);
            }
        }
        return $employees;
    }
}