<?php
use Controllers\DashboardController;

class Dashboard extends DashboardController {
    
    public function __construct () {
        parent::__construct ();
    }

    public function index () {
        if ($this->user['type']) $this->view->display ('admin/dashboard', ['bdaycelebrant' => $this->bday_celebrant()]);
        else $this->view->display ('home');
    }
}