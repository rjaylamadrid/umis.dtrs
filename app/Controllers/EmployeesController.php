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
        $this->employees = DB::fetch_all ("SELECT a.employee_id as employee_id, a.no as employee_no, first_name, last_name, gender, birthdate, position_desc as position, active_status FROM tbl_employee a, tbl_employee_status b, tbl_position c WHERE a.no = b.employee_id AND b.campus_id = ? AND b.position_id = c.no GROUP BY a.employee_id", $this->user['campus_id']);
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

    public function status ($status = '1') {
        if (!$employees) $this->employees ();
        $employees = [];
        foreach ($this->employees as $employee) {
            if ($employee['active_status'] == $status) $employees[] = $employee;
        }
        return $employees;
    }
    
    public function get_position () {
        $positions = Position::positions()->type ($this->data['type']);
        echo json_encode($positions);
    }

    public function get_salary () {
        $salary = Position::position ($this->data['position_id']) -> get_salary ($this->data['campus_id'], $this->data['date_start']);
        print_r($salary['salary']);
    }

    protected function set_active () {
        if ($this->data['active'] == '0') {
            $set = DB::update ("UPDATE tbl_employee_status SET date_end = ? , active_status = 0 WHERE employee_id = ? AND active_status = 1", [date('Y-m-d'), $this->data['id']]);
            if ($set) $result = ['success' => date('Y-m-d')];
        }
        echo json_encode($result);
    }

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

    public static function update_status ($data) {
        return DB::update ("UPDATE tbl_employee_status SET ".DB::stmt_builder ($data)." WHERE employee_id = ?", $data);
    }

    public static function add_profile($id,$employeeinfo,$tab) {
        $tab = 'tbl_employee_'.str_replace ("-","_",$tab);
        if($tab == 'tbl_employee_other_info') {
            foreach ($employeeinfo as $key => $value) {
                $other_row=DB::fetch_row ("SELECT $key FROM $tab WHERE employee_id = $id");
                $other_row["$key"] = $other_row["$key"] == '' ? $value : $other_row["$key"].";".$value;
                return DB::update ("UPDATE $tab SET ".DB::stmt_builder($employeeinfo). " WHERE employee_id = $id",$other_row);
            }
        }
        else {
            return DB::insert("INSERT INTO $tab SET ".DB::stmt_builder ($employeeinfo), $employeeinfo);
        }
    }

    public static function update_profile($id, $employeeinfo, $tab) {
        $tab = 'tbl_employee_'.str_replace ("-","_",$tab);
        $tab = $tab == 'tbl_employee_basic_info' ? 'tbl_employee' : $tab;
        $id_col = $tab == 'tbl_employee' ? 'no' : 'employee_id';
        
        // BASIC_INFO
        if ($tab == 'tbl_employee') {
            return DB::update ("UPDATE " . $tab . " SET " .  DB::stmt_builder($employeeinfo) . " WHERE ". $id_col . "=" . $id,$employeeinfo);
        }
        // FAMILY_BACKGROUND
        else if ($tab == 'tbl_employee_family_background') {
            for ($i=0;$i<sizeof($employeeinfo);$i++) {
                if ($i == 0) {
                    for($j=1;$j<=sizeof($employeeinfo[$i]);$j++) {
                        $temp = DB::update ("UPDATE $tab SET " . DB::stmt_builder($employeeinfo[$i][$j]) . " WHERE no = ". $employeeinfo[$i][$j]['no'],$employeeinfo[$i][$j]);
                    }
                }
                else {
                    $temp = DB::update ("UPDATE $tab SET " . DB::stmt_builder($employeeinfo[$i]) . " WHERE $id_col = $id AND relationship = '$i'",$employeeinfo[$i]);
                }
            }
        }
        // EDUCATION
        else if ($tab == 'tbl_employee_education') {
            $levels = ['Elementary', 'Secondary', 'Vocational', 'College', 'Graduate Studies'];
            foreach ($levels as $value) {
                if ($employeeinfo[$value]['school_name']) {
                    $temp = DB::update ("UPDATE $tab SET " . DB::stmt_builder($employeeinfo[$value]) . " WHERE $id_col = $id AND level = '$value'",$employeeinfo[$value]);
                }
            }
        }
        else if ($tab == 'tbl_employee_other_info') {
            return DB::update ("UPDATE $tab SET other_skill = '" . implode(";", $employeeinfo['skill']) . "', other_recognition = '" . implode(";", $employeeinfo['recog']) . "', other_organization = '" . implode(";", $employeeinfo['org']) . "' WHERE $id_col = $id");
        }
    }

    // public static function get_education($id) {

    // }
    
    public function get_schedule () {
        $schedules = Schedule::schedule ($this->data['sched_code']);
        $this->view->display ('custom/schedule', ['schedules' => $schedules]);
    }
}