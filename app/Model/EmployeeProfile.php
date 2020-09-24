<?php
namespace Model;

use Database\DB;
use Model\Position;

class EmployeeProfile {
    public $id;
    public $info;
    public $basic_info;
    public $family_background;
    public $eligibility;
    public $employment;
    public $voluntary_work;
    public $training_seminar;
    public $references;
    public $other_info;
    public $position;
    public $employment_info;
    public $schedule;

    private $args = ["table" => "tbl_employee", "col" => "*", "options" => "", "type" => "all"];

    public function __construct ($id = null) {
        $this->id = $id;
        $this->info ();
        $this->position ();
    }

    public function id ($id) {
        $this->id = $id;
        return $this;
    }

    public function info () {
        $this->info = DB::fetch_row ("SELECT a.first_name, a.middle_name, a.last_name, b.* FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.employee_id = ? GROUP BY b.employee_id", $this->id);
    }

    public function basic_info () {
        $this->basic_info = $this->get (["type" => "row"]);
    }

    public function family_background () {
        $this->family_background = $this->get (["table" => "tbl_employee_family_background"]);
    }

    public function education () {
        $this->education = $this->get (["table" => "tbl_employee_education", "options" => " ORDER BY year_graduated DESC"]);
    }

    public function eligibility () {
        $this->eligibility = $this->get (["table" => "tbl_employee_eligibility"]);
    }

    public function employment () {
        $this->employment = $this->get (["col" => "*, (CASE when date_to IS NULL THEN NOW() ELSE date_to END) AS dateto", "table" => "tbl_employee_employment", "options" => " ORDER BY dateto DESC"]);
    }

    public function voluntary_work () {
        $this->voluntary_work = $this->get (["table" => "tbl_employee_voluntary_work"]);
    }

    public function training_seminar () {
        $this->training_seminar = $this->get (["table" => "tbl_employee_training_seminar"]);
    }

    public function references () {
        $this->references = $this->get (["table" => "tbl_employee_references"]);
    }

    public function other_info () {
        $this->other_info = $this->get (["table" => "tbl_employee_other_info"]);
    }

    public function employment_info () {
        $this->employment_info['department'] = Position::department ($this->info['department_id']);
        $this->employment_info['designation'] = Position::designation ($this->info['privilege']);
    }

    public function position () {
        $this->position = Position::position ($this->info['position_id']) -> get_salary($this->info['campus_id'],$this->info['date_start']);
    }

    public function schedule () {
        $this->schedule = DB::fetch_all ("SELECT a.* FROM tbl_schedule a, (SELECT * FROM tbl_employee_sched WHERE employee_id = ? ORDER BY `date` DESC LIMIT 0,1) b WHERE a.sched_code = b.sched_code", $this->id);
    }
    
    private function get ($args = []) {
        $this->args = array_merge ($this->args, $args);

        $id = $this->args['table'] == 'tbl_employee' ? 'no' : 'employee_id';
        $stmt = "SELECT ".$this->args['col']." FROM ".$this->args['table']." WHERE $id = ? ".$this->args['options'];
        return $this->args['type'] == "row" ? DB::fetch_row ($stmt, $this->id) : DB::fetch_all ($stmt, $this->id);
    }
}