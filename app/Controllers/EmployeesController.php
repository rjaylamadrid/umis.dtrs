<?php
namespace Controllers;

use Database\DB;
use Profile;
use Model\Position;
use Model\Schedule;

class EmployeesController extends Controller {
    public $employees;
    public $profile;
    
    public function bday_celebrant () {
        return DB::fetch_all ("SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %d') AS BDate, (YEAR(NOW()) - YEAR(birthdate)) AS Age, DAYNAME(DATE_FORMAT(birthdate, '$this->year-%m-%d')) AS Araw, employee_picture FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.active_status = 1 AND b.campus_id = ? AND MONTH(a.birthdate) = ? AND DAY(birthdate) BETWEEN 1 AND 31 ORDER BY BDate", [$this->user['campus_id'], $this->year]);
    }

    public function employees () {
        $this->employees = DB::fetch_all ("SELECT * FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.campus_id = ? GROUP BY a.employee_id", $this->user['campus_id']);
        return $this;
    }

    public function all () {
        return $this->employees;
    }

    public function find ($id) {
        foreach ($this->employees as $employee) {
            if ($employee['employee_id'] == $id) return $employee;
        }
        return;
    }
    
    public function get_position () {
        $positions = Position::positions()->type ($this->data['type']);
        echo json_encode($positions);
    }

    protected function set_active () {}
    
    protected function type () {
        return DB::fetch_all ("SELECT * FROM tbl_employee_type");
    }
    
    protected function departments () {
        return DB::fetch_all ("SELECT * FROM tbl_department WHERE campus_id = ? ORDER BY department_desc", $this->user['campus_id']);
    }

    protected function designations () {
        return DB::fetch_all ("SELECT * FROM tbl_privilege ORDER BY priv_desc");
    }

    public function new_id ($e = NULL) {
        $year = date('y');
        $count = count($this->employees ()->all())+1;
        $id = $year.'-'.$count;
        if ($e) {
            return $id;
        }  else {
            echo $id;
        };
    }

    protected function register () {
        $id = DB::insert ("INSERT INTO tbl_employee SET ".DB::stmt_builder ($this->data['emp']), $this->data['emp']);
        if ($id) {
            $this->data['emp_status']['campus_id'] = $this->user['campus_id'];
            $this->data['emp_status']['employee_id'] = $id;
            if (!(self::add_status ($this->data['emp_status']))) header ("location: /employees/registration");
            if (!(self::set_schedule ($this->data['sched_code'], $id))) header ("location: /employees/registration");
            header ("location: /employees/registration/success");
        }
    }

    public static function set_schedule ($sched, $id){
        return DB::insert ("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?", [$sched, $id]);
    }

    public static function add_status ($data) {
        return DB::insert ("INSERT INTO tbl_employee_status SET ".DB::stmt_builder ($data), $data);
    }

    public static function update_profile($id, $employeeinfo, $tab) {
        $tab = 'tbl_'.str_replace ("-","_",$tab);
        $id_col = $tab == 'tbl_basic_info' ? 'no' : 'employee_id';
        $tab = $tab == 'tbl_basic_info' ? 'tbl_employee' : $tab;
        return DB::update ("UPDATE " . $tab . " SET " .  DB::stmt_builder($employeeinfo) . " WHERE ". $id_col . "=" . $id,$employeeinfo);
    }
    
    public function get_schedule () {
        $schedules = Schedule::schedule ($this->data['sched_code']);
        $this->view->display ('custom/schedule', ['schedules' => $schedules]);
    }
}