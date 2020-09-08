<?php
use Controllers\LoginController;

class Login extends LoginController {
    private $message;

    public function __construct () {
        parent::__construct ();
    }

    public function index () {
        if ($_SESSION['user']) header ("location: /dashboard");
        $this->view->display ('login', ["message" => $this->message]);
    }

    public function do_login () {
        if ($this->find ($_POST['username'])) {
            if ($this->verify ($_POST['password'])) {
                $this->save_session ();
            } else {
                $this->message = ["error" => ["message" => "Incorrect password."]];
            }
        } else {
            $this->message = ["error" => ["message" => "Invalid ID. Please try again."]];
        }
        $this->index ();
    }
    
    public function change_type () {
        if($_SESSION['user']['type'] == 'admin'){
            unset($_SESSION['user']['type']);
        }else{
            $_SESSION['user']['type'] = 'admin';
        }
        header ("location: /login");
    }
}