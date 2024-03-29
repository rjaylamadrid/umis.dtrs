<?php

use Controllers\Controller;
use Controllers\DashboardController;
use Model\EmployeeStats;
use Controllers\ScheduleController;
class Dashboard extends DashboardController {
    
    public function __construct () {
        parent::__construct ();
    }

    public function index () {
        if ($this->user['is_admin']) {
            $employee = EmployeeStats::campus ($this->user['campus_id'])->get_stats ();

            $this->view->display ('admin/dashboard', ['bdaycelebrant' => $this->bday_celebrant(), "employee" => $employee]);
        } else {
            header ('location: /profile');
        }
         ScheduleController::Auto_update_schedule();
      
    }
    public function do_action () {
        call_user_func_array ([$this, $this->data['action']], $this->data);
    }
}