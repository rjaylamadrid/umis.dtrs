<?php
namespace Model;

use Model\Employee;

class Payroll{
    public $employees;
    public $payroll;

    public function __construct() {
    }

    public function initialize($type) {
        $this->employees = Employee::employees()->type($type);
        // $this->display("");
    }
}