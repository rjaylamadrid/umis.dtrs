<?php
namespace Model;

use Database\DB;

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
        $this->education = $this->get (["table" => "tbl_employee_family_background"]);
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
        $this->training_seminar = $this->get (["table" => "tbl_training_seminar"]);
    }

    public function references () {
        $this->references = $this->get (["table" => "tbl_employee_reference"]);
    }

    public function other_info () {
        $other_info = $this->get (["table" => "tbl_employee_other", "type" => "row"]);
        foreach ($other_info as $key => $value) {
            $this->other_info[$key] = explode (";", $value);
        }
    }

    public function position () {
        $this->position = DB::fetch_row ("SELECT * FROM tbl_position WHERE no = ?", $this->info['position_id']);
    }

    private function get ($args = []) {
        $this->args = array_merge ($this->args, $args);

        $id = $this->args['table'] == 'tbl_employee' ? 'no' : 'employee_id';
        $stmt = "SELECT ".$this->args['col']." FROM ".$this->args['table']." WHERE $id = ? ".$this->args['options'];
        return $this->args['type'] == "row" ? DB::fetch_row ($stmt, $this->id) : DB::fetch_all ($stmt, $this->id);
    }
}