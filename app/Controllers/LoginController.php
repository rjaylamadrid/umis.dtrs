<?php
namespace Controllers;

use Database\DB;

class LoginController extends Controller {
    private $tmp_user;

    protected function find ($id) {
        $user = DB::select ("SELECT * FROM tbl_user_employee a, tbl_employee_status b WHERE a.employee_username = ? and a.employee_id = b.employee_id AND b.active_status = '1' ORDER BY b.date DESC", $id)[0];
        if ($user) {
            $this->tmp_user = $user;
            return $user;
        }
    }

    protected function verify ($pass) {
        return password_verify ($pass, $this->tmp_user['employee_password']);
    }

    protected function save_session () {
        $_SESSION['user'] = ['employee_no' => $this->tmp_user['no'], 'employee_id' => $this->tmp_user['employee_id'], 'campus_id' => $this->tmp_user['campus_id'], 'position' => Controller::get_position ($this->tmp_user['employee_id'])];
        $_SESSION['user'] = array_merge($_SESSION['user'], $this->user_data ());
        if ($this->tmp_user['privilege'] > 0) {
            $_SESSION['user']['is_admin'] = '1';
            $_SESSION['user']['type'] = 'admin';
        }
        $this->user = $_SESSION['user'];
    }

    private function user_data () {
        return DB::fetch_row ("SELECT first_name, middle_name, last_name, employee_picture FROM tbl_employee a, tbl_employee_status b WHERE a.employee_id = b.employee_id AND a.employee_id = ? AND b.campus_id = ? ORDER BY b.date DESC LIMIT 0, 1", [$this->tmp_user['employee_id'], $this->tmp_user['campus_id']]);
    }
}