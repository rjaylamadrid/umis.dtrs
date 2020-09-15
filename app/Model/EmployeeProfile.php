<?php
namespace Model;

use Database\DB;

class EmployeeProfile {
    public $id;
    public $info;
    public $basic_info;
    public $family_background;
    public $eligibility;
    public $work_experience;
    public $voluntary_work;
    public $references;
    public $other_info;

    public function __construct ($id = null) {
        $this->id = $id;
        $this->info ();
    }
    public function id ($id) {
        $this->id = $id;
        return $this;
    }
    public function info () {
        $this->info = DB::fetch_row ("SELECT a.first_name, a.middle_name, a.last_name, b.* FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.emp_no AND b.emp_no = ? GROUP BY b.emp_no", $id);
    }
    public function basic_info () {
        $this->basic_info = DB::fetch_row ("SELECT a.* FROM tbl_employee a WHERE no = ?", $this->id);
    }
    public function family_background () {
        $this->education = DB::fetch_all ("SELECT * FROM tbl_employee_dependent WHERE emp_no = ?", $this->id);
    }
    public function education () {
        $this->education = DB::fetch_all ("SELECT * FROM tbl_employee_education WHERE emp_no = ?", $this->id);
    }
    public function eligibility () {
        $this->eligibility = DB::fetch_all ("SELECT * FROM tbl_employee_eligibility WHERE emp_no = ?", $this->id);
    }
    public function work_experience () {
        $this->work_experience = DB::fetch_all ("SELECT * FROM tbl_employee_employment WHERE emp_no = ?", $this->id);
    }
    public function voluntary_work () {
        $this->work_experience = DB::fetch_all ("SELECT * FROM tbl_employee_voluntary_work WHERE emp_no = ?", $this->id);
    }
    public function references () {
        $this->work_experience = DB::fetch_all ("SELECT * FROM tbl_employee_reference WHERE emp_no = ?", $this->id);
    }
    public function other_info () {
        $this->work_experience = DB::fetch_all ("SELECT * FROM tbl_employee_other WHERE emp_no = ?", $this->id);
    }
}