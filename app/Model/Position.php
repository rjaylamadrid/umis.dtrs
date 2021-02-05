<?php
namespace Model;

use Database\DB;
use Model\SalaryGrade;
class Position {
    public $id;
    public $sg_id;
    public $date;
    public $date_start;
    public $emp_type;
    public $emp_types;
    public $position;
    public $positions;
    public $step;
    public $salarygrade;
    public $type;

    public function __construct($id = null, $date_start = null, $emp_type = null, $date = null) {
        $this->id = $id;
        $this->date = $date;
        $this->date_start = $date_start;
        $this->emp_type = $emp_type;
        $this->step = 0;
        $this->position();
    }

    public function positions($emp_type = null) {
        $this->salary_grade();
        $i = 0;
        $positions = [];
        if ($emp_type) {
            $this->emp_type = $emp_type;
            $this->emp_type();
            $this->positions = DB::fetch_all("SELECT * FROM tbl_position WHERE etype_id = ? ORDER BY position_desc ASC", $this->emp_type['type_id']);
        } else {
            $this->positions = DB::fetch_all("SELECT * FROM tbl_position ORDER BY position_desc ASC");
        } 
        foreach ($this->positions as $position) {
            $positions[$i] = $position;
            $positions[$i]['salary'] = $this->get_salary($position['salary_grade'], $position['no']);
            if ($position['salary_grade'] == 0) {
                $positions[$i]['salary_grade'] = 'N/A';
                $positions[$i]['salary_type'] = $this->type;
            }
            $i++;
        }
        $this->positions = $positions;
    }

    public function position() {
        if($this->id) {
            $this->emp_type();
            $this->position = DB::fetch_row("SELECT * FROM tbl_position WHERE no = ? ORDER BY position_desc ASC", $this->id);
            if ($this->emp_type['isRegular'] == '1') { $this->step(); }
            $this->salary_grade();
            $this->position['salary'] = $this->get_salary($this->position['salary_grade'], $this->id);
            $this->position['type'] = $this->type;
            $this->position['emp_type'] = $this->emp_type['type_desc'];
        }
    }

    public function salary_grade() {
        if (!$this->date) $this->date = date('Y-m-d');
        $tranche = new SalaryGrade($this->sg_id, $this->date);
        $this->salarygrade = $tranche->salarygrades;
    }

    public function emp_type(){
        $this->emp_type = DB::fetch_row("SELECT * FROM tbl_employee_type WHERE id = ?", $this->emp_type);
    }

    public function emp_types() {
        $this->emp_types = DB::fetch_all("SELECT * FROM tbl_employee_type");
    }

    public function step() {
        $diff = date_diff(date_create(), date_create($this->date_start));
        $step = floor($diff->format('%y')/3) + 1;
        $step = $step > 8 ? 8 : $step;
        $this->position['step'] = $step;
        $this->step = $step;
    }

    public function get_salary($sg_id, $position_id = null) {
        foreach($this->salarygrade as $salarygrade) {
            if ($sg_id == $salarygrade['salary_grade']) $result = number_format($salarygrade['steps'][$this->step],2,".",",");
        }
        if ($sg_id == 0) {
            $salary = DB::fetch_row("SELECT * FROM tbl_cos_salary WHERE position_id = ?", $position_id);
            $result = number_format($salary['salary'],2,".",",");
            $this->type = $salary['salary_type'];
        }
        return $result;
    }
}