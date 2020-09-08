<?php
namespace Controllers;

use Database\DB;

class LoginController extends Controller {
    public function __construct () {
        parent::__construct ();
    }

    public function find ($id) {
        $user = DB::select ("SELECT * FROM tbl_user_employee a, tbl_employee_status b WHERE a.employee_username = ? and a.employee_id = b.employee_id AND b.active_status = '1' ORDER BY b.date DESC", $id)[0];
        if ($user) {
            $this->user = $user;
            return $user;
        }
        return;
    }

    public function verify ($pass) {
        return password_verify ($pass, $this->user['employee_password']);
    }

    public function save_session () {
        $_SESSION['user'] = ['employee_id' => $this->user['employee_id'], 'campus_id' => $this->user['campus_id']];
        if ($this->user['privilege'] > 0) {
            $_SESSION['user']['is_admin'] = '1';
            $_SESSION['user']['type'] = 'admin';
        }
    }
}