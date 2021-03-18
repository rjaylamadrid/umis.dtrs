<?php
namespace Model;

use Database\DB;
use Model\Employee;
use Model\Position;

class Payroll{
    static $employees;

    public static function employees($type) {
        self::$employees = [];
        $types = $type == '1' ? '124' : $type;

        for ($i=0; $i<strlen($types); $i++) {
            $employees = Employee::type(substr($types, $i, 1));
            self::$employees = array_merge(self::$employees, $employees);
        }
        self::position();
        return self::$employees;
    }

    protected static function position() {
        $employees = [];
        foreach (self::$employees as $employee) {
            $position = new Position($employee['position_id'], $employee['date_start'], $employee['etype_id'], null, null, $employee['step']);
            $employee['position'] = $position->position['position_code'];
            $employee['salary'] = $position->position['salary'];
            $employee['sg'] = $position->position['salary_grade'];
            $employees[] = $employee;
        }
        self::$employees = $employees;
    }

    public static function get_headers ($type) {
        $payroll = DB::fetch_row ("SELECT * FROM tbl_payroll WHERE etype_id = ? ORDER BY date DESC", $type);
        $headers = Array ( 'A' => 'No.', 'B' => 'Name', 'C' => 'Employee ID', 'D' => 'Position');
        if ($payroll['compensation']) $headers['COMPENSATION'] = json_decode($payroll['compensation'], true);
        if ($payroll['deduction']) $headers['DEDUCTION'] = json_decode($payroll['deduction'], true);
        if ($payroll['employer-share']) $headers['EMPLOYER-SHARE'] = json_decode($payroll['employer-share'], true);
        return $headers;
    }
}