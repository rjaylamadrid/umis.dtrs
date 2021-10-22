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

    public static function get_payroll_factors ($type) {
        $compensation = DB::fetch_all ("SELECT * FROM tbl_compensation WHERE etype_id = ?", $type);
        $deduction = DB::fetch_all ("SELECT * FROM tbl_deduction WHERE etype_id = ?", $type);
        $employer_share = DB::fetch_all ("SELECT * FROM tbl_employer_share WHERE etype_id = ?", $type);
        $factors = array('0' => array('title' => 'Compensation', 'data' => $compensation), 
                        '1' => array('title' => 'Deduction', 'data' => $deduction), 
                        '2' => array('title' => 'Employer-share', 'data' => $employer_share));
        return $factors;
    }
}