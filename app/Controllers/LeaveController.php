<?php
namespace Controllers;

use Model\Attendance;
use Database\DB;

class LeaveController extends Controller {
    public $first_day;
    // private $employee_type;

    protected function getLeaveCredits () {
        // loop and get attendance first
    }

    protected function getLeaveChanges () {
        // loop and get attendance first
    }

    public function getFirstDay() {
        $this->first_day = DB::fetch_row ("", );
    }
}