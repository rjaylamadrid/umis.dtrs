<?php
namespace Controllers;

use Database\DB;

class SettingsController extends Controller {
    protected function general () {
        
    }

    protected function connection () {
        $result = DB::fetch_all ("SELECT * FROM tbl_settings WHERE keyword LIKE '%server%'");
        foreach ($result as $value) {
            $connection[$value['keyword']] = $value['value'];
        }
        return $connection;
    }

    protected function salary_grade () {
        $sg = DB::fetch_all ("SELECT * FROM tbl_salary_grade WHERE 1");
        for ($i=0; $i < sizeof($sg); $i++) {
            $salary[$sg[$i]['no']]['no'] = $sg[$i]['no'];
            $salary[$sg[$i]['no']]['step_increment'] = explode (",", $sg[$i]['step_increment']);
        }
        return $salary;
    }

    protected function payroll () {

    }

    protected function position () {
        $positions = DB::fetch_all ("SELECT * FROM tbl_position ORDER BY position_code ASC");
        $salaries = $this->salary_grade ();
        for ($i=0; $i < sizeof ($positions); $i++) { 
            $positions[$i]['salary_grade'] = $positions[$i]['salary_grade'] == '0' ? '-' : $positions[$i]['salary_grade'];
            if ($positions[$i]['salary_grade'] != 0) {
				$positions[$i]['salary'] = number_format ($salaries[$positions[$i]['salary_grade']]['step_increment'][$this->get_salary(date('Y-m-d'),1)], 2);
            }
            $positions[$i]['is_teaching'] = $positions[$i]['is_teaching'] == '1' ? 'Y' : 'N';
        }
        return $positions;
    }

    protected function w_tax () {

    }

    private function get_salary ($date, $type){
        $step = 0;
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
        }
        return $step;
    }
}