<?php
namespace Controllers;

use Database\DB;
use Model\Position;
use PhpOffice\PhpSpreadsheet\Calculation\Financial\Depreciation;
use PhpOffice\PhpSpreadsheet\RichText\Run;

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



    protected function department () {
        $employeeid = $this->user = $_SESSION['user']['employee_id'];
        $departmentInfo = DB::fetch_all("SELECT c.no,c.department_code,c.department_desc,c.is_project,department_status FROM tbl_employee_status a JOIN tbl_campus b ON b.id = a.campus_id JOIN tbl_department c ON c.campus_id = b.id WHERE a.employee_id = ".$employeeid."");
        $data['department'] = $departmentInfo;
        return $data;
    }

    public function addDeparment(){
        $c_id =$this->user['campus_id'];   
        DB::insert("INSERT INTO tbl_department SET `no`=?, department_code = ?, department_desc = ?, campus_id = ?, is_project =?",[NULL,$this->data['dep_code'],$this->data['dept_desc'],$c_id,$this->data['p_base']]);
        $this->view->display ("admin/settings/department", ['department'=> $this->department()]);
    }

    public function UpdateDepartment(){
        $c_id =$this->user['campus_id'];
        DB::update("UPDATE tbl_department SET `no` = ?,department_code=?,department_desc =?,campus_id=?,is_project=?,department_status=? WHERE `no` = ?",[$this->data['no'],$this->data['dept_code'],$this->data['dept_desc'],$c_id,$this->data['ProjectBase'],$this->data['CheckActive'],$this->data['no']]);
    }

    public function DeptInfo(){
        $this->view->display ("admin/settings/department", ['department'=> $this->department()]);
    }

    public function position ($emp_type = 1) {
        $this->positions = new Position();
        $this->positions->positions($emp_type, $this->user['campus_id']);
        $data['positions'] = $this->positions;
        return $data;
    }

    public function show_position (){
        $type = $this->data['emp_type'];
        $pos = $this->position($type);
        $this->view->display ("admin/settings/position", ['emp_type'=>$type, 'positions' => $pos['positions']]);
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