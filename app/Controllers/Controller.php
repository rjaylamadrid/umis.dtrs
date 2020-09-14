<?php
namespace Controllers;

use View\SmartyView;
use Database\DB;

class Controller {
    public $user;
    public $view;
    public $data;

    public function __construct () {
        $this->user = $_SESSION['user'];
        $this->view = new SmartyView ();
        $this->data = $_POST;
        $this->view->assign (["user" => $this->user, "page" => $this->request_page ()]);
    }

    private function request_page () {
        $uri = explode ("/", rtrim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), "/"));
        return $uri[1];
    }

    protected function redirect ($location = '/dashboard') {
        header ("location: $location");
    }
    
    public function get_position ($id) {
        return DB::fetch_row ("SELECT b.position_desc as position FROM tbl_employee_employment a, tbl_position b WHERE a.position = b.no AND a.employee_id = ? and a.date_to IS NULL ORDER BY date_from DESC", $id)['position'];
    }
}