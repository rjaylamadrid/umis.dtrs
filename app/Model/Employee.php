<?php
namespace Model;

use Database\DB;

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
            if ($e['emp_type'] == $type) $employees[] = $e;
        }
        return $employees;
    }

    public static function employees () {
        self::$employees = DB::fetch_all ("SELECT a.first_name, a.middle_name, a.last_name, b.* FROM tbl_employee a, tbl_employee_status b WHERE a.employee_id = b.employee_id AND b.active_status = 1 GROUP BY a.employee_id ORDER BY a.last_name");
        return new self();
    }

    public static function find ($id) {
        self::$employee = DB::db("db_master2")->fetch_row ("SELECT a.first_name, a.middle_name, a.last_name, b.* FROM tbl_employee a, tbl_employee_status b WHERE a.employee_id = b.employee_id AND b.employee_id = ? GROUP BY a.employee_id", $id)[0];
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
            return DB::fetch_all ("SELECT * FROM $profile WHERE employee_id = ? $stmt", self::$employee['employee_id']);
        }
    }

    public static function get () {
        return self::$employee;
    }

    public static function update ($id, $col = [], $val) {
        $table = $view == 'basic-info' ? 'tbl_employee' : 'tbl_employee_'.str_replace ("-", "_", $view);
        $emp = Employee::employee($id)->info($table);
        $this->view->display ('profile', ["employee" => Employee::$employee, "emp" => $emp, "tab" => $view, "view" => "update"]);
    }
}