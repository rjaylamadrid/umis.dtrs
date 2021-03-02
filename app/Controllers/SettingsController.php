<?php
namespace Controllers;

use Database\DB;
use Model\Position;

class SettingsController extends Controller {
    public $positions;
    public $salary_grade;

    protected function connection () {
        $result = DB::fetch_all ("SELECT * FROM tbl_settings WHERE keyword LIKE '%server%'");
        foreach ($result as $value) {
            $connection[$value['keyword']] = $value['value'];
        }
        return $connection;
    }

    protected function security () {

    }

    public function position ($emp_type = 1) {
        $this->positions = new Position();
        $this->positions->positions($emp_type);
        $data['positions'] = $this->positions;
        return $data;
    }

    public function show_position (){
        $type = $this->data['emp_type'];
        $data = $this->position($type);
        $this->view->display ("admin/settings/position", $data);
    }

    public function change_password($id,$cur_pass,$new_pass,$confirm_pass) {
        $user_info = DB::fetch_row ("SELECT * FROM tbl_user_employee a, tbl_employee_status b WHERE a.employee_id = ? and a.employee_id = b.employee_id AND b.active_status = '1' ORDER BY b.date_added DESC", $id);
        if ($user_info) {
            $this->tmp_user = $user_info;

            // if (self::verify($cur_pass)) {
            if (password_verify($cur_pass, $this->tmp_user['employee_password'])) {
                $updated = password_hash($new_pass,PASSWORD_DEFAULT);
                $update_pass = DB::update("UPDATE tbl_user_employee SET employee_password = ? WHERE employee_id = ?", [$updated, $id]);
                if($update_pass != NULL) {
                    return ["result" => "success", "message" => "Password changed successfully."];
                    // $this->view->display ('success_changepass');
                }
            } else {
                return ["result" => "failed", "message" => "Old password given was incorrect."];
                // $this->view->display ('error_changepass', ["message" => "Old password given was incorrect."]);
            }
        }
    }
}