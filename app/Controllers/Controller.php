<?php
namespace Controllers;

use View\SmartyView;

class Controller {
    public $user;
    public $view;
    public $data;

    public function __construct () {
        if (!$_SESSION['user'] && $this->request_page () != 'login') header ("location: /login");
        $this->user = $_SESSION['user'];
        $this->view = new SmartyView ();
        $this->data = array_merge ($_GET, $_POST);
        $this->view->assign (["user" => $this->user, "page" => $this->request_page ()]);
    }

    private function request_page () {
        $uri = explode ("/", rtrim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), "/"));
        return $uri[1];
    }
}