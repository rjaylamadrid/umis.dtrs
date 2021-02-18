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
        $record = DB::fetch_all ("SELECT a.no, a.date_start, a.date_end, a.is_active, a.position_id, b.position_desc, c.salary_grade, c.step_increment, c.date_implemented, d.campus_name, e.etype_desc, e.jo
        FROM tbl_employee_status a, tbl_position b, tbl_salary_grade c, tbl_campus d, tbl_employee_type e
        WHERE a.position_id = b.no AND b.salary_grade = c.salary_grade AND a.campus_id = d.id AND a.etype_id = e.etype_id AND a.employee_id = ?
        ORDER BY a.date_start ASC", $this->id);
        $ctr=0;
        foreach ($record as $value) {
            if ($value['jo'] == '1') {
                $temp = DB::fetch_row ("SELECT CONCAT(salary_type,';',salary)AS salary FROM tbl_cos_salary WHERE position_id = ?", $value['position_id']);
                $record[$ctr]['step_increment'] = $temp['salary'];
            }
            else if ($value['jo'] == '0') {
                $salary_steps = explode(",",$record[$ctr]['step_increment']);
                if ($value['date_end'] == NULL) {
                    $record[$ctr]['step_increment'] = $salary_steps[Position::step($value['date_start'], date("Y-m-d")) - 1];
                    // $record[$ctr] += ['step' => Position::step($value['date_start'], date("Y-m-d"))];
                }
                else {
                    $record[$ctr]['step_increment'] = $salary_steps[Position::step($value['date_start'], $value['date_end']) - 1];
                    // $record[$ctr] += ['step' => Position::step($value['date_start'], date("Y-m-d"))];
                }
            }
            $ctr++;
        }
        $this->service_record = $record;
    }
    
    private function get ($args = []) {
        $this->args = array_merge ($this->args, $args);

        $id = $this->args['table'] == 'tbl_employee' ? 'no' : 'employee_id';
        $stmt = "SELECT ".$this->args['col']." FROM ".$this->args['table']." WHERE $id = ? ".$this->args['options'];
        return $this->args['type'] == "row" ? DB::fetch_row ($stmt, $this->id) : DB::fetch_all ($stmt, $this->id);
    }
}