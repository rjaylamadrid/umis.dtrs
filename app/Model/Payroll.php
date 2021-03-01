<?php
namespace Model;

use Model\Employee;
use Model\Position;
use View\Excel;

class Payroll{
    static $employees;
    static $payroll;

    public static function initialize($type) {
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
            $employee['position'] = $position->position['position_desc'];
            $employee['salary'] = $position->position['salary'];
            $employee['sg'] = $position->position['salary_grade'];
            $employees[] = $employee;
        }
        self::$employees = $employees;
    }

    public static function download() {
        Excel::generate('payroll.xlxs');
    }
}