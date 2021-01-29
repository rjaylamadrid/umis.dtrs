<?php
namespace Model;

use Database\DB;
class SalaryGrade{
    static $tranche;
    static $tranches;
    static $sg;

    public static function salary_tranche() {
        self::$tranches =  DB::fetch_all('SELECT * FROM tbl_salary_tranche ORDER BY date ASC');
        return self::$tranches;
    }

    public static function salary_grade($tranche = NULL) {
        if(!$tranche) $tranche = self::$tranche['sg_id'];
        return DB::fetch_all('SELECT * FROM tbl_salary_grade WHERE sg_id = ?', $tranche);
    }

    public static function tranche($sg_id = NULL) {
        if (!$sg_id) {
            self::$tranche =  DB::fetch_row('SELECT * FROM tbl_salary_tranche WHERE date <= ? ORDER BY date DESC', date('Y-m-d'));
        } else {
            self::$tranche =  DB::fetch_row('SELECT * FROM tbl_salary_tranche WHERE sg_id = ?', $sg_id);
        }
        return self::$tranche;
    }
}