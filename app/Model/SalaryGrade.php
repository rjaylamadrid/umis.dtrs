<?php
namespace Model;

use Database\DB;
class SalaryGrade {
    public $sg_id;
    public $date;
    public $tranche;
    public $tranches;
    public $salarygrades;

    public function __construct ($sg_id = null, $date = null) {
        $this->sg_id = $sg_id;
        $this->date = date('Y-m-d');
        $this->active_tranche();
        $this->sg_id = $this->tranche['sg_id'];
        $this->salary_grade();
    }

    public function all() {
        $this->tranches;
    }

    public function salary_tranches() {
       $this->tranches = DB::fetch_all('SELECT * FROM tbl_salary_tranche ORDER BY date ASC');
    }

    public function find($sg_id) {
        foreach ($this->tranches as $tranche) {
            if ($tranche['sg_id'] == $sg_id) $this->tranche = $tranche;
        }
        return $this->tranche;
    }

    public function active_tranche() {
        if (!$this->sg_id) {
            $this->tranche = DB::fetch_row('SELECT * FROM tbl_salary_tranche WHERE date <= ? ORDER BY date DESC', $this->date);
        } else {
            $this->tranche = DB::fetch_row('SELECT * FROM tbl_salary_tranche WHERE sg_id = ? ORDER BY date DESC', $this->sg_id);
        }
    }

    public function salary_grade($tranche = NULL) {
        $salaries = [];
        $i = 0;
        $this->salarygrades = DB::fetch_all('SELECT * FROM tbl_salary_grade WHERE sg_id = ?', $this->tranche['sg_id']);
        foreach ($this->salarygrades as $salary) {
            $salaries[$i]['salary_grade'] = $salary['salary_grade'];
            $salaries[$i]['steps'] = explode(',' , $salary['step_increment']);
            $i++;
        }
        $this->salarygrades = $salaries;
    }
}