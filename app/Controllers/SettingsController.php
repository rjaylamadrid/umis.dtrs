<?php
namespace Controllers;

use Database\DB;

class SettingsController extends Controller {
    protected function general () {
        
    }

    protected function salary_grade () {
        $salary = DB::fetch_all ("SELECT * FROM tbl_salary_grade WHERE 1");
        for ($i=0; $i < sizeof($salary); $i++) { 
            $salary[$i]['step_increment'] = explode (",", $salary[$i]['step_increment']);
        }
        return $salary;
    }

    protected function payroll () {

    }

    protected function position () {
        $positions = DB::fetch_all ("SELECT * FROM tbl_position ORDER BY position_code ASC");
        for ($i=0; $i < sizeof ($positions); $i++) { 
            $positions[$i]['salary_grade'] = $positions[$i]['salary_grade'] == '0' ? '-' : $positions[$i]['salary_grade'];
            if ($positions[$i]['salary_grade'] != 0) {
				$salaries = DB::fetch_row ("SELECT * FROM tbl_salary_grade WHERE no = ?", $positions[$i]['salary_grade']);
				$positions[$i]['salary'] = number_format ($this->get_salary($salaries['step_increment'],date('Y-m-d'),1), 2);
            }
            $positions[$i]['is_teaching'] = $positions[$i]['is_teaching'] == '1' ? 'Y' : 'N';
        }
        return $positions;
    }

    private function get_salary ($salary, $date, $type){
        if(($type ==1) || ($type == 2)){
            $date = date_create($date);
            $now = date_create(date('Y-m-d'));
            $day = $now->format('d') - $date->format('d');
            $mon = $now->format('m') - $date->format('m');
            $year = $now->format('Y') - $date->format('Y');

            $interval = $year;
            $interval -= $mon < 0 ? 1 : 0;
            if($mon == 0){
                $interval -= $day < 0 ? 1 : 0;
            }
            $step = intval($interval/3);
            $step = $step > 7 ? 7 : $step;
        }else{
            $step = 0;
        }
        $salary_step = explode(',', $salary);
        return $salary_step[$step];
    }
}