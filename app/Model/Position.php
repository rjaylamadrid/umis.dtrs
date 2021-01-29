<?php
namespace Model;

use Database\DB;
class Position {
    static $positions;
    static $salary;
    static $position;

    public static function type ($type) {
        if(!self::$positions) self::positions ();
        $positions = [];
        foreach(self::$positions as $position) {
            if($position['etype_id'] == $type) $positions[] = $position;
        }
        return $positions;
    }

    public static function all () {
        return self::$positions;
    }

    public static function positions () {
        self::$positions = DB::fetch_all ("SELECT * FROM tbl_position WHERE 1 ORDER BY position_code ASC");
        return new self();
    }
    
    public static function position ($id) {
        if(!self::$positions) self::positions ();
        foreach(self::$positions as $position) {
            if ($position['no'] == $id) self::$position = $position;
        }
        return new self();
    }

    public static function find () {
        return self::$position;
    }

    public static function get_salary ($date = NULL) {
        if (!$date) $date = date('Y-m-d');
        if (self::$position['salary_grade'] == 0) {
            // $salary  = DB::fetch_row ("SELECT * FROM tbl_cos_salary WHERE position_id = ? AND date_implemented < ?  AND campus_id = ? ORDER BY date_implemented DESC", [self::$position['no'], $date, $campus]);
            // self::$position['salary'] = $salary['salary'];
            // self::$position['salary_type'] = $salary['salary_type'];
        }else{
            // $salary  = DB::fetch_row ("SELECT step_increment as salary FROM tbl_salary_grade WHERE salary_grade = ? AND date_implemented < ?  AND campus_id = ? ORDER BY date_implemented DESC", [self::$position['salary_grade'], $date, $campus])['salary'];
            // $steps = explode (',' , $salary);
            // self::$position['increment'] = self::step ($date);
            // self::$position['salary'] = $steps[self::$position['increment'] - 1];
        }
        return "hello world";
    }

    public static function step ($date_start) {
        $date = date('Y-m-d');
        $diff = date_diff(date_create($date), date_create($date_start));
        $step = floor($diff->format('%y')/3) + 1;
        $step = $step > 8 ? 8 : $step;
        return $step;
    }

    public static function department ($dept_id) {
        return DB::fetch_row ("SELECT department_desc as department FROM tbl_department WHERE no = ?", $dept_id)['department'];
    }

    public static function designation ($priv_level) {
        return DB::fetch_row ("SELECT priv_desc as designation FROM tbl_privilege WHERE priv_id = ?", $priv_level)['designation'];
    }
    
    public static function emp_type () {
        return DB::fetch_all ("SELECT * FROM tbl_employee_type");
    }
}