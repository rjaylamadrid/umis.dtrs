<?php
namespace Controllers;

use View\SmartyView;
use Database\DB;

class Controller {
    public $user;
    public $view;
    public $user_access;
    public $data;

    public function __construct () {
        $this->user = $_SESSION['user'];
        $this->view = new SmartyView ();
        $this->data = $_POST;
        $this->access(); 
        // print_r($this->user);
        $this->view->assign (["user" => $this->user, "page" => $this->request_page ()]);
    }

    private function request_page () {
        $uri = explode ("/", rtrim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), "/"));
        return $uri[1];
    }

    protected function redirect ($location = '/dashboard') {
        header ("location: $location");
    }

    protected function access () {
        $access = $this->user['access'];

        $headers = array(["url" => "dashboard", "icon" => "home", "title" => "Dashboard"], ["url" => "employees", "icon" => "users", "title" => "Employees"], ["url" => "payroll", "icon" => "credit-card", "title" => "Payroll"], ["url" => "attendance", "icon" => "clock", "title" => "Daily Time Record"], ["url" => "calendar", "icon" => "calendar", "title" => "Calendar"],["url" => "leave", "icon" => "mail", "title" => "Leave Request"], ["url" => "settings", "icon" => "settings", "title" => "Settings"], ["url" => "profile", "icon" => "user", "title" => "Profile"], ["url" => "payslip", "icon" => "credit-card", "title" => "Payroll"], ["url" => "dtr", "icon" => "clock", "title" => "Daily Time Record"], ["url" => "leave", "icon" => "file", "title" => "Leave Management"]);
        $u_headers = [];

        if (!$this->user['is_admin']) {
            $access = $this->user['isJO'] ? '()*' : '()*+';
        }

        for($i=0; $i<strlen($access); $i++) {
            $u_headers[] = $headers[ord(substr($access, $i, 1))-33];
        }

        $this->view->assign(["headers" => $u_headers]);
    }
}