<?php
namespace Controllers;

use Database\DB;

class DashboardController extends Controller {
    public $user;

    public function __construct () {
        parent::__construct();
    }

    public function bday_celebrant () {
        return DB::select ("SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %d') AS BDate, (YEAR(NOW()) - YEAR(birthdate)) AS Age, DAYNAME(DATE_FORMAT(birthdate, '%Y-%m-%d')) AS Araw, employee_picture FROM tbl_employee a, tbl_employee_status b WHERE a.employee_id = b.employee_id AND b.active_status = 1 AND b.campus_id = ? AND MONTH(a.birthdate) = ? AND DAY(birthdate) BETWEEN 1 AND 31 ORDER BY BDate", [$this->user['campus_id'], date('m')]);
    }
}