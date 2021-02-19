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
    public $service_record;

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
        $this->info = DB::fetch_row ("SELECT a.first_name, a.middle_name, a.last_name, a.employee_picture, b.* FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.employee_id = ?  AND b.no = (SELECT no FROM tbl_employee_status WHERE employee_id = a.no ORDER BY date_start DESC LIMIT 0,1)", $this->id);
    }

    public function basic_info () {
        $this->basic_info = $this->get (["type" => "row"]);
    }

    public function family_background () {
        $this->family_background['children'] = DB::fetch_all("SELECT CONCAT(first_name,' ',middle_name,' ',last_name,' ',ext_name) as name, first_name, middle_name,last_name, ext_name, birthdate, no, employee_id FROM tbl_employee_family_background WHERE employee_id = ? AND relationship = 0 ORDER BY birthdate ASC", $this->id);
        $this->family_background['spouse'] = DB::fetch_row("SELECT * FROM tbl_employee_family_background WHERE employee_id = ? AND relationship = 1", $this->id);
        $this->family_background['mother'] = DB::fetch_row("SELECT no, employee_id, first_name, middle_name, last_name FROM tbl_employee_family_background WHERE employee_id = ? AND relationship = 2", $this->id);
        $this->family_background['father'] = DB::fetch_row("SELECT no, employee_id, first_name, middle_name, last_name, ext_name FROM tbl_employee_family_background WHERE employee_id = ? AND relationship = 3", $this->id);
    }

    public function education () {
        $this->education = $this->get (["type" => "all", "table" => "tbl_employee_education", "options" => " ORDER BY year_graduated DESC"]);
    }

    public function eligibility () {
        $this->eligibility = $this->get (["type" => "all", "table" => "tbl_employee_eligibility", "options" => " ORDER BY eligibility_date_exam DESC"]);
    }

    public function employment () {
        $this->employment = DB::fetch_all ("SELECT * FROM tbl_employee_employment WHERE employee_id = ?", $this->id);
        $this->service_record();
        foreach($this->service_record as $record) {
            $govt = $record['type_id'] == '7' ? 0 : 1;
            $this->employment[] = array('position' => $record['position_desc'], 'date_from' => $record['date_start'], 'date_to' => $record['date_end'], 'company' => 'Central Bicol State University of Agriculture', 'appointment' => $record['type_desc'], 'salary' => $record['salary'], 'salary_grade' => $record['salary_grade'], 'step' => $record['step'], 'govt_service' => $govt);
        }
        $this->service_record = [];
    }

    public function voluntary_work () {
        $this->voluntary_work = $this->get (["type" => "all", "table" => "tbl_employee_voluntary_work", "options" => " ORDER BY date_from DESC"]);
    }
    
    public function training_seminar () {
        $this->training_seminar = $this->get (["table" => "tbl_employee_training_seminar", "options" => " ORDER BY training_from DESC"]);
    }

    public function references () {
        $this->references = $this->get (["type" => "all", "table" => "tbl_employee_references", "options" => ""]);
    }

    public function other_info () {
        $this->other_info = $this->get (["type" => "row", "table" => "tbl_employee_other_info", "options" => ""]);
    }

    public function employment_info () {
        $this->employment_info['department'] = DB::fetch_row("SELECT * FROM tbl_department WHERE no = ?",$this->info['department_id'])['department_desc'];
        $this->employment_info['designation'] = Position::designation ($this->info['privilege']);
    }

    public function position () {
        $position = new Position($this->info['position_id'], $this->info['date_start'], $this->info['etype_id']);
        $this->position = $position->position;
        $this->position['step'] = $position->step;
    }

    public function schedule () {
        $this->schedule = DB::fetch_all ("SELECT a.* FROM tbl_schedule a, (SELECT * FROM tbl_employee_sched WHERE employee_id = ? ORDER BY `date` DESC LIMIT 0,1) b WHERE a.sched_code = b.sched_code", $this->id);
    }

    public function service_record () {
        $this->service_record = DB::fetch_all ("SELECT position_desc, date_start, date_end, type_id, type_desc, salary, step, a.salary_grade,campus_name FROM tbl_employee_service a, tbl_position b, tbl_employee_type c, tbl_campus d WHERE a.position_id = b.no AND a.etype_id = c.id AND a.campus_id = d.id AND employee_id = ? ORDER BY date_start DESC", $this->id);
    }
    
    private function get ($args = []) {
        $this->args = array_merge ($this->args, $args);

        $id = $this->args['table'] == 'tbl_employee' ? 'no' : 'employee_id';
        $stmt = "SELECT ".$this->args['col']." FROM ".$this->args['table']." WHERE $id = ? ".$this->args['options'];
        return $this->args['type'] == "row" ? DB::fetch_row ($stmt, $this->id) : DB::fetch_all ($stmt, $this->id);   
        //return
    }
}