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
        $this->family_background = $this->get (["table" => "tbl_employee_family_background"]);
    }

    public function education () {
        $this->education = $this->get (["table" => "tbl_employee_education", "options" => " ORDER BY year_graduated DESC"]);
    }

    public function eligibility () {
        $this->eligibility = $this->get (["table" => "tbl_employee_eligibility"]);
    }

    public function employment () {
        // $this->employment = $this->get (["col" => "*, 'Monthly' AS salary_type, (CASE when date_to IS NULL THEN NOW() ELSE date_to END) AS dateto", "table" => "tbl_employee_employment", "options" => " ORDER BY dateto DESC"]);
        // $employment_record = DB::fetch_all ("SELECT a.*, b.*, c.*, d.*, e.* FROM tbl_employee_status a, tbl_position b, tbl_campus c, tbl_salary_grade d, tbl_employee_type e WHERE a.employee_id = ? AND b.no = a.position_id AND a.campus_id = c.id AND b.salary_grade = d.salary_grade AND b.etype_id = e.etype_id ORDER BY a.date_start DESC", $this->id);
        // if ($employment_record) {
        //     $temp = sizeof($this->employment);
        //     foreach ($employment_record as $value) {
        //         $date_end = $value['date_end'] == '' ? date('Y-m-d') : $value['date_end'];
        //         $salary_amount = explode(",",$value['step_increment']);
        //         $this->employment[$temp]['position'] = $value['position_desc'];
        //         $this->employment[$temp]['date_from'] = $value['date_start'];
        //         $this->employment[$temp]['date_to'] = $value['date_end'];
        //         $this->employment[$temp]['company'] = "CBSUA - ".$value['campus_name'];
        //         $this->employment[$temp]['govt_service'] = "1";
        //         $this->employment[$temp]['appointment'] = $value['etype_desc'];
        //         $this->employment[$temp]['salary_grade'] = $value['salary_grade'];
        //         if ($value['jo'] == 1) {
        //             $cos_salary = DB::fetch_row ("SELECT * FROM tbl_cos_salary WHERE position_id = ?", $value['position_id']);
        //             $this->employment[$temp]['salary'] = $cos_salary['salary'];
        //             $this->employment[$temp]['salary_type'] = $cos_salary['salary_type'];
        //         } else {
        //             $this->employment[$temp]['salary'] = $salary_amount[Position::step($value['date_start'],$date_end) - 1];
        //             $this->employment[$temp]['salary_type'] = "Monthly";
        //         }
        //         $temp++;
        //     }
        // }
        // $keys = array_column($this->employment, 'date_to');
        // array_multisort($keys, SORT_ASC, $this->employment);
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
        // $record = DB::fetch_all ("SELECT a.no, a.date_start, a.date_end, a.is_active, a.position_id, b.position_desc, c.salary_grade, c.step_increment, c.date_implemented, d.campus_name, e.etype_desc, e.jo
        // FROM tbl_employee_status a, tbl_position b, tbl_salary_grade c, tbl_campus d, tbl_employee_type e
        // WHERE a.position_id = b.no AND b.salary_grade = c.salary_grade AND a.campus_id = d.id AND a.etype_id = e.etype_id AND a.employee_id = ?
        // ORDER BY a.date_start ASC", $this->id);
        // $ctr=0;
        // foreach ($record as $value) {
        //     if ($value['jo'] == '1') {
        //         $temp = DB::fetch_row ("SELECT CONCAT(salary_type,';',salary)AS salary FROM tbl_cos_salary WHERE position_id = ?", $value['position_id']);
        //         $record[$ctr]['step_increment'] = $temp['salary'];
        //     }
        //     else if ($value['jo'] == '0') {
        //         $salary_steps = explode(",",$record[$ctr]['step_increment']);
        //         if ($value['date_end'] == NULL) {
        //             $record[$ctr]['step_increment'] = $salary_steps[Position::step($value['date_start'], date("Y-m-d")) - 1];
        //             // $record[$ctr] += ['step' => Position::step($value['date_start'], date("Y-m-d"))];
        //         }
        //         else {
        //             $record[$ctr]['step_increment'] = $salary_steps[Position::step($value['date_start'], $value['date_end']) - 1];
        //             // $record[$ctr] += ['step' => Position::step($value['date_start'], date("Y-m-d"))];
        //         }
        //     }
        //     $ctr++;
        // }
        // $this->service_record = $record;
    }
    
    private function get ($args = []) {
        $this->args = array_merge ($this->args, $args);

        $id = $this->args['table'] == 'tbl_employee' ? 'no' : 'employee_id';
        $stmt = "SELECT ".$this->args['col']." FROM ".$this->args['table']." WHERE $id = ? ".$this->args['options'];
        return $this->args['type'] == "row" ? DB::fetch_row ($stmt, $this->id) : DB::fetch_all ($stmt, $this->id);
    }
}