<?php
namespace Controllers;

use Database\DB;
use Model\Position;

class LoginController extends Controller {
    private $tmp_user;

    protected function find ($id) {
        $user = DB::fetch_row ("SELECT * FROM tbl_user_employee a, tbl_employee_status b WHERE a.employee_username = ? and a.employee_id = b.employee_id AND b.is_active = '1' ORDER BY b.date_added DESC", $id);
        if ($user) {
            $this->tmp_user = $user;
            return $user;
        }
    }

    protected function verify ($pass) {
        return password_verify ($pass, $this->tmp_user['employee_password']);
    }

    protected function save_session () {
        $this->position = new Position($this->tmp_user['position_id']);
        $this->position->position();
        $position = $this->position->position['position_desc'];
        $_SESSION['user'] = ['employee_id' => $this->tmp_user['employee_id'], 'campus_id' => $this->tmp_user['campus_id'], 'position' => $position];
        $_SESSION['user'] = array_merge($_SESSION['user'], $this->user_data ());
        if ($this->tmp_user['privilege'] > 0) {
            $_SESSION['user']['is_admin'] = '1';
            $_SESSION['user']['type'] = 'admin';
        }
        $this->get_user_access();
        $this->user = $_SESSION['user'];
    }

    private function user_data () {
        return DB::fetch_row ("SELECT first_name, middle_name, last_name, employee_picture FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND a.no = ? AND b.campus_id = ? ORDER BY b.date_added DESC LIMIT 0, 1", [$this->tmp_user['employee_id'], $this->tmp_user['campus_id']]);
    }

    private function get_user_access() {
        $_SESSION['user']['access'] = DB::fetch_row ("SELECT access FROM tbl_privilege WHERE priv_level = ?", $this->tmp_user['privilege'])['access'];
        $_SESSION['user']['isJO'] = DB::fetch_row ("SELECT isJobOrder FROM tbl_employee_type WHERE id = ?", $this->tmp_user['etype_id'])['isJobOrder'];
    }
}