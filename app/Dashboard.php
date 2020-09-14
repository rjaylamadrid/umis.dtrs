<?php
use Controllers\DashboardController;
use Model\EmployeeStats;

class Dashboard extends DashboardController {
    
    public function __construct () {
        parent::__construct ();
    }

    public function index () {
        if ($this->user['type']) {
            $employee = EmployeeStats::campus ($this->user['campus_id'])->get_stats ();

            $this->view->display ('admin/dashboard', ['bdaycelebrant' => $this->bday_celebrant(), "employee" => $employee]);
        } else {
            $this->view->display ('home');
        }
    }
}