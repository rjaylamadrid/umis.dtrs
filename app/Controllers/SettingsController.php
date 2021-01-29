<?php
namespace Controllers;

use Database\DB;
use Model\Position;

class SettingsController extends Controller {
    private $positions;

    protected function connection () {
        $result = DB::fetch_all ("SELECT * FROM tbl_settings WHERE keyword LIKE '%server%'");
        foreach ($result as $value) {
            $connection[$value['keyword']] = $value['value'];
        }
        return $connection;
    }

    protected function salary_grade () {
        $sg = DB::fetch_all ("SELECT * FROM tbl_salary_grade WHERE 1");
        for ($i=0; $i < sizeof($sg); $i++) {
            $salary[$sg[$i]['no']]['no'] = $sg[$i]['no'];
            $salary[$sg[$i]['no']]['step_increment'] = explode (",", $sg[$i]['step_increment']);
        }
        return $salary;
    }

    protected function security () {

    }

    protected function position () {
        $this->positions = [];
        $positions = Position::positions()->all();
        foreach ($positions as $position) {
            $position['salary'] = Position::position($position['no'])->get_salary(4, date_create()->format('Y-m-d'));
            $this->positions[] = $position;
        }
        $data['positions'] = $this->positions;
        $data['emp_types'] = Position::emp_type();
        return $data;
    }

    protected function w_tax () {

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