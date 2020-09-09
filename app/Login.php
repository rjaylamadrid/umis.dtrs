<?php
use Controllers\LoginController;

class Login extends LoginController {
    private $message;

    public function index () {
        if ($this->user) {
            if ($this->user['type'] == 'admin') $this->redirect ();
            else $this->redirect ("profile");
        }

        $this->view->display ('login', ["message" => $this->message]);
    }

    public function do_action () {
        call_user_func_array ([$this, $this->data['action']], $this->data);
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
        if($_SESSION['user']['type'] == 'admin') unset($_SESSION['user']['type']);
        else $_SESSION['user']['type'] = 'admin';

        $this->user = $_SESSION['user'];
        $this->index ();
    }
}