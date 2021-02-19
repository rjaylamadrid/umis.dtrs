<?php
namespace Controllers;

use Database\DB;
use Profile;
use Model\Position;
use Model\Employee;
use Model\Schedule;

class EmployeesController extends Controller {
    public $employees;
    public $profile;
    public $result;
    public $message;
    
    public function bday_celebrant () {
        return DB::fetch_all ("SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %d') AS BDate, (YEAR(NOW()) - YEAR(birthdate)) AS Age, DAYNAME(DATE_FORMAT(birthdate, '$this->year-%m-%d')) AS Araw, employee_picture FROM tbl_employee a, tbl_employee_status b WHERE a.no = b.employee_id AND b.active_status = 1 AND b.campus_id = ? AND MONTH(a.birthdate) = ? AND DAY(birthdate) BETWEEN 1 AND 31 ORDER BY BDate", [$this->user['campus_id'], $this->year]);
    }

    public function get_position () {
        $this->position = new Position();
        $this->position->positions($this->data['type']);
        echo json_encode($this->position->positions);
    }

    public function get_salary () {
        $position = new Position($this->data['position_id'], $this->data['date_start'], $this->data['emp_type']);
        echo $position->position['salary'];
    }

    protected function set_active () {
        if ($this->data['active'] == '0') {
            $set = DB::update ("UPDATE tbl_employee_status SET date_end = ? , is_active = 0 WHERE employee_id = ? AND is_active = 1", [date('Y-m-d'), $this->data['id']]);
            if ($set) $result = ['success' => date('Y-m-d')];
        }
        echo json_encode($result);
    }

    public function set_inactive () {
        $set = DB::update ("UPDATE tbl_employee_status SET date_end = ?, is_active = ? WHERE employee_id = ?", [$this->data['date_end'], $this->data['status'], $this->data['emp_id']]);
        if ($set) $this->result = 'success';
        $this->view->index();
    }
    
    protected function departments () {
        return DB::fetch_all ("SELECT * FROM tbl_department WHERE campus_id = ? ORDER BY department_desc", $this->user['campus_id']);
    }

    protected function designations () {
        return DB::fetch_all ("SELECT * FROM tbl_privilege ORDER BY priv_level");
    }

    public function new_id ($e = NULL) {
        $count = count(Employee::employees ()->getAll())+1;
        $id = date('y').'-'.$count;
        if ($e) {
            return $id;
        }  else {
            echo $id;
        };
    }

    public function employee_no() {
        $count = str_pad(count(Employee::employees ()->getAll())+1, 4, '0', STR_PAD_LEFT);
        $no = $this->user['campus_id'].$count;
        return $no;
    }

    protected function register () {
        $result = True;
        $this->message = [];
        if ($this->data['emp']) {
            $id = DB::insert ("INSERT INTO tbl_employee SET ".DB::stmt_builder ($this->data['emp']), $this->data['emp']);
            if ($id) {
                $this->data['emp_status']['campus_id'] = $this->user['campus_id'];
                $this->data['emp_status']['employee_id'] = $id;
                if (!($this->add_status ($this->data['emp_status']))) $result = False;
                if (!($this->set_schedule ($this->data['sched_code'], $id, $this->data['emp_status']['date_start']))) $result = False;
                $this->add_user($id);
            } else {
                $result = false;
            }
            if ($result) {
                $this->message = ['success' => 'success', 'message' => 'Employee registration has been successful!'];
            } else { $this->message = ['success' => null, 'message' => 'Employee registration failed!']; }
        }
        $this->registration($message);
    }

    public function add_user ($id) {
        $password = password_hash("12345467890", PASSWORD_DEFAULT);
        DB::insert ("INSERT INTO tbl_user_employee SET employee_id = ?, employee_username = ?, employee_password = ?", [$id, $this->data['emp']['email_address'], $password]);
    }

    public static function add_profile($id,$employeeinfo,$tab,$admin_id) {
        $tab = 'tbl_employee_'.str_replace ("-","_",$tab);
        $inserted_data='';
        $ctr=1;
        if($tab == 'tbl_employee_other_info') {
            foreach ($employeeinfo as $key => $value) {
                $other_row=DB::fetch_row ("SELECT $key FROM $tab WHERE employee_id = $id");
                if ($other_row) {
                    $other_row["$key"] = $other_row["$key"] == '' ? $value : $other_row["$key"].";".$value;
                    $inserted_vals = array('updated_action'=>2,'updated_table'=>$tab,'updated_old_data'=>'','updated_new_data'=>$key."=".$value,'updated_employee_id'=>$id,'updated_admin_id'=>$admin_id,'updated_date'=>date("Y-m-d"));
                    DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder($inserted_vals),$inserted_vals);
                    return DB::update ("UPDATE $tab SET ".DB::stmt_builder($employeeinfo). " WHERE employee_id = $id",$other_row);
                } else {
                    $inserted_vals = array('updated_action'=>2,'updated_table'=>$tab,'updated_old_data'=>'','updated_new_data'=>$key."=".$value,'updated_employee_id'=>$id,'updated_admin_id'=>$admin_id,'updated_date'=>date("Y-m-d"));
                    DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder($inserted_vals),$inserted_vals);
                    return DB::insert ("INSERT INTO $tab SET employee_id = ?, $key = ?",[$id,$employeeinfo["$key"]]);
                }
            }
        }
        else {
            foreach ($employeeinfo as $key => $value) {
                if ($ctr != sizeof($employeeinfo)) {
                    $inserted_data .= $key."=".$value.";";
                }
                else {
                    $inserted_data .= $key."=".$value;
                }
                $ctr++;
            }
            if (($tab == 'tbl_employee_eligibility') && ($employeeinfo['eligibility_validity'] == '')) {
                $employeeinfo['eligibility_validity'] = '0000-00-00';
            }
            $inserted_vals = array('updated_action'=>2,'updated_table'=>$tab,'updated_old_data'=>'','updated_new_data'=>$inserted_data,'updated_employee_id'=>$id,'updated_admin_id'=>$admin_id,'updated_date'=>date("Y-m-d"));
            DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder($inserted_vals),$inserted_vals);
            return DB::insert("INSERT INTO $tab SET ".DB::stmt_builder ($employeeinfo), $employeeinfo);
        }
    }

    public function delete_row () {
        $row = DB::fetch_row ("SELECT * FROM tbl_employee_". str_replace ("-","_",$this->data['tab']) ." WHERE no = ?", $this->data['no']);
        if($this->data['tab'] == 'other-info') {
            $data_array = explode(";",$row[$this->data['other_info_col']]);
            $key = array_search($this->data['other_info_data'], $data_array);
            array_splice($data_array, $key, 1);
            DB::update ("UPDATE tbl_employee_other_info SET ". $this->data['other_info_col'] ."= ? WHERE no = ". $this->data['no'], [implode(";",$data_array)]);
            DB::insert ("INSERT INTO tbl_employee_update_delete SET updated_action = ?, updated_table = ?, updated_old_data = ?, updated_new_data = ?, updated_employee_id = ?, updated_admin_id = ?, updated_date = ?", [1,$this->data['tab'],$this->data['other_info_col'].";".$this->data['other_info_data'],'',$row['employee_id'],$this->user['employee_id'],date("Y-m-d")]);
        }
        else {
            if ($row) {
                $i=1;
                foreach ($row as $value) {
                    if ($i == sizeof($row)) {
                        $data .= $value;
                    }
                    else {
                        $data .= $value . ";";
                    }
                    $i++;
                }
                $values = array(updated_action=>1,updated_table=>$this->data['tab'],updated_old_data=>$data,updated_new_data=>'',updated_employee_id=>$row['employee_id'],updated_admin_id=>$this->user['employee_id'],updated_date=>date("Y-m-d"));
                DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($values), $values);
                DB::delete ("DELETE FROM tbl_employee_". str_replace ("-","_",$this->data['tab']) ." WHERE no = ?", $this->data['no']);
            }
        }
    }  

    public static function update_profile($id, $employeeinfo, $picture='', $tab, $admin_id) {
        $tab = 'tbl_employee_'.str_replace ("-","_",$tab);
        $tab = $tab == 'tbl_employee_basic_info' ? 'tbl_employee' : $tab;
        $id_col = $tab == 'tbl_employee' ? 'no' : 'employee_id';
        $ctr=1;
        // BASIC_INFO
        if ($tab == 'tbl_employee') {
            $row = DB::fetch_row ("SELECT * FROM $tab WHERE $id_col = ?", $id);

            // employee_picture saving
            if ($picture['name'] != '') {
                $target_file = "../public/assets/employee_picture/$id." . strtolower(pathinfo($picture['name'],PATHINFO_EXTENSION));
                if(file_exists("../public/assets/employee_picture/$id")) unlink("../public/assets/employee_picture/$id");
                if(move_uploaded_file($picture['tmp_name'], $target_file) === true) {
                    $employeeinfo += ['employee_picture' => "$id." . strtolower(pathinfo($picture['name'],PATHINFO_EXTENSION))];
                }
            }
            else {
                $employeeinfo += ['employee_picture' => $row['employee_picture']];
            }

            $difference = array_diff($row,$employeeinfo);
            foreach ($difference as $key => $value) {
                $old_data .= $key."=".$value;
                $new_data .= $key."=".$employeeinfo[$key];
                if($ctr != sizeof($difference)) {
                    $old_data .= ";";
                    $new_data .= ";";
                }
                $ctr++;
            }
            $ctr=1;
            $difference2 = array_diff($employeeinfo,$row);
            foreach ($difference2 as $key => $value) {
                if(strpos($new_data,$key) !== false) {
                    // print_r($key.$value);
                }
                else {
                    $old_data .= ";".$key."=".$row[$key];
                    $new_data .= ";".$key."=".$value;
                }
            }
            $updated_vals = array('updated_action'=>0,'updated_table'=>$tab,'updated_old_data'=>$old_data,'updated_new_data'=>$new_data,'updated_employee_id'=>$id,'updated_admin_id'=>$admin_id,'updated_date'=>date("Y-m-d"));
            
            $update_qry = DB::update ("UPDATE " . $tab . " SET " .  DB::stmt_builder($employeeinfo) . " WHERE ". $id_col . "=" . $id,$employeeinfo);
            if ($update_qry != NULL) {
                DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($updated_vals),$updated_vals);
                return 'success';
            }
        }
        // FAMILY_BACKGROUND
        else if ($tab == 'tbl_employee_family_background') {
            for ($i=1; $i<=sizeof($employeeinfo); $i++) {
                if($employeeinfo[$i]['no']) {
                    $old = DB::fetch_row ("SELECT * FROM $tab WHERE no = ?", $employeeinfo[$i]['no']);
                    $new_data = self::get_array_differences($old,$employeeinfo[$i]);
                    $updated_vals = array('updated_action'=>0,'updated_table'=>$tab,'updated_old_data'=>"no=".$old['no'].";relationship=0;".$new_data[0],'updated_new_data'=>"no=".$employeeinfo[$i]['no'].";relationship=0;".$employeeinfo[$i]['relatioship'],'updated_employee_id'=>$id,'updated_admin_id'=>$admin_id,'updated_date'=>date("Y-m-d"));
                    DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($updated_vals),$updated_vals);
                    $temp = DB::update ("UPDATE $tab SET " . DB::stmt_builder($employeeinfo[$i]) . " WHERE no = ". $employeeinfo[$i]['no'],$employeeinfo[$i]);
                } else if($employeeinfo[$i]['first_name']) {
                    $employeeinfo[$i][$id_col] = $id;
                    $employeeinfo[$i]['no'] = NULL;
                    $temp = DB::insert ("INSERT INTO $tab SET " . DB::stmt_builder($employeeinfo[$i]),$employeeinfo[$i]);
                } 
            }
        }
        // EDUCATION
        else if ($tab == 'tbl_employee_education') {
            for ($i=1; $i<=count($employeeinfo); $i++) {
                if ($employeeinfo[$i]['school_name']) {
                    $no = $employeeinfo[$i]['no'];
                    $row[$i] = DB::fetch_row ("SELECT * FROM $tab WHERE no = ?", $employeeinfo[$i]['no']);
                    if ((sizeof(array_diff($row[$i],$employeeinfo[$i])) > 0) || (sizeof(array_diff($employeeinfo[$i],$row[$i])) > 0)) {
                        $new_data = self::get_array_differences($row[$i],$employeeinfo[$i]);
                        $updated_vals = array('updated_action'=>0,'updated_table'=>$tab,'updated_old_data'=>"no=".$row[$i]['no'].";".$new_data[0],'updated_new_data'=>"no=".$row[$i]['no'].";".$new_data[1],'updated_employee_id'=>$id,'updated_admin_id'=>$admin_id,'updated_date'=>date("Y-m-d"));
                        $update_qry = DB::update ("UPDATE $tab SET " . DB::stmt_builder($employeeinfo[$i]) . " WHERE $id_col = $id AND no = '$no'",$employeeinfo[$i]);
                        if ($update_qry != NULL) {
                            DB::insert ("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($updated_vals),$updated_vals);
                        }
                    }
                }
            }
            return 'success';
        }
        // OTHER_INFO
        else if ($tab == 'tbl_employee_other_info') {
            if (($employeeinfo['skill']) || ($employeeinfo['recog']) || ($employeeinfo['org'])) {
                $ans = json_encode($employeeinfo['question']);
                $row = DB::fetch_row("SELECT * FROM $tab WHERE $id_col = ?",$id);
                $skill = $employeeinfo['skill'][0] != '' ? implode(";",$employeeinfo['skill']) : $employeeinfo['skill'][0];
                $recog = $employeeinfo['recog'][0] != '' ? implode(";",$employeeinfo['recog']) : $employeeinfo['recog'][0];
                $org = $employeeinfo['org'][0] != '' ? implode(";",$employeeinfo['org']) : $employeeinfo['org'][0];

                $frm = array('no'=>$employeeinfo['no'],'employee_id'=>$employeeinfo['employee_id'],'other_skill'=>$skill,'other_recognition'=>$recog,'other_organization'=>$org);
                $new_data = self::get_array_differences($row,$frm);

                foreach ($new_data as $key => $value) {
                $new_data[$key] = str_replace([";other_recognition",";other_organization"],["|other_recognition","|other_organization"],$value);
                }
                $updated_vals = array('updated_action'=>0,'updated_table'=>$tab,'updated_old_data'=>$new_data[0],'updated_new_data'=>$new_data[1],'updated_employee_id'=>$id,'updated_admin_id'=>$admin_id,'updated_date'=>date("Y-m-d"));
                $update_qry = DB::update ("UPDATE $tab SET other_skill = '$skill', other_recognition = '$recog', other_organization = '$org', answers = '$ans'  WHERE $id_col = $id");
                if ($update_qry != NULL) {
                    DB::insert("INSERT INTO tbl_employee_update_delete SET ". DB::stmt_builder ($updated_vals),$updated_vals);
                    return 'success';
                }
            } else {
                return '';
            }
        }
    }

    public static function get_array_differences($db_data,$frm_data,$old_data='',$new_data='') {
        $diff1 = array_diff($db_data, $frm_data);
        $diff2 = array_diff($frm_data, $db_data);
        $ctr=1;
        foreach ($diff1 as $key => $value) {
            $old_data .= $key."=".$value;
            $new_data .= $key."=".$frm_data[$key];
            if ($ctr != sizeof($diff1)) {
                $old_data .= ";";
                $new_data .= ";";
            }
            $ctr++;
        }
        $ctr=1;
        foreach ($diff2 as $key => $value) {
            if (strpos($new_data,$key) !== false) {
            }
            else {
                if (sizeof($diff2) == 1) {
                    $old_data .= $key."=".$db_data[$key];
                    $new_data .= $key."=".$value;
                }
                else {
                    if (sizeof($diff2) == $ctr) {
                        $old_data .= ";".$key."=".$db_data[$key];
                        $new_data .= ";".$key."=".$value;
                    }
                    else {
                        $old_data .= $key."=".$db_data[$key];
                        $new_data .= $key."=".$value;
                    }
                }
            }
            $ctr++;
        }
        return [$old_data, $new_data];
    }

    //EMPLOYMENT MODULE
    public function update_schedule () {
        $update = $this->set_schedule ($this->data['sched_code'], $this->data['employee_id']);
        header ("location: /employees/employment-update/{$this->data['employee_id']}/schedule/success");
    }

    public function update_employment_info () {
        if ($this->data['type'] == "current"){
            $this->update_status ($this->data['emp_status'], $this->data['employee_id'], $this->data['admin_id']);
            header ("location: /employees/employment-update/{$this->data['employee_id']}/employment_info/success");
        }
        else if ($this->data['type'] == "new") {
            $this->data['emp_status'] += ['active_status' => 0];
            $set = DB::insert ("INSERT INTO tbl_employee_status SET ". DB::stmt_builder ($this->data['emp_status']), $this->data['emp_status']);
            header ("location: /employees/employment/{$this->data['emp_status']['employee_id']}/service_record/success");
        }
        else{
            $set = DB::update ("UPDATE tbl_employee_status SET date_end = ? , active_status = 0 WHERE employee_id = ? AND active_status = 1", [$this->data['date_end'], $this->data['emp_status']['employee_id']]);
            if ($set) self::add_status ($this->data['emp_status']);
            header ("location: /employees/employment/{$this->data['emp_status']['employee_id']}/employment_info/success");
        }
    }

    public function get_schedule () {
        $schedules = Schedule::schedule ($this->data['sched_code']);
        $this->view->display ('custom/schedule', ['schedules' => $schedules]);
    }

    public static function set_schedule ($sched, $id, $date = NULL){
        if (!($date)) $date = date('Y-m-d');
        return DB::insert ("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ?", [$sched, $id, $date]);
    }

    public static function add_status ($data) {
        return DB::insert ("INSERT INTO tbl_employee_status SET ".DB::stmt_builder ($data), $data);
    }

    public static function update_status ($data, $id, $admin_id='') {
        $old_data = DB::fetch_row ("SELECT privilege,department_id,date_start,position_id,etype_id FROM tbl_employee_status WHERE employee_id = ? AND active_status = '1'",$id);
        $frm = array('privilege' => $data['privilege'], 'department_id' => $data['department_id'], 'date_start' => $data['date_start'], 'position_id' => $data['position_id'], 'etype_id' => $data['etype_id']);
        $diff = self::get_array_differences($old_data, $frm);
        $updated_vals = array('updated_action'=>0,'updated_table'=>'current_employment_info','updated_old_data'=>$diff[0],'updated_new_data'=>$diff[1],'updated_employee_id'=>$id,'updated_admin_id'=>$admin_id,'updated_date'=>date("Y-m-d"));
        DB::insert ("INSERT INTO tbl_employee_update_delete SET ".DB::stmt_builder ($updated_vals),$updated_vals);
        return DB::update ("UPDATE tbl_employee_status SET ".DB::stmt_builder ($data)." WHERE no = (SELECT no FROM tbl_employee_status WHERE employee_id = ".$id." ORDER BY date_start DESC LIMIT 0,1)", $data);
    }

    public function create_sched_preset() {
        $scheds = DB::fetch_row ("SELECT COUNT(*)AS COUNT FROM tbl_schedule_preset");
        $this->data['schedule_preset'] += ['sched_code' => "SCHED".str_pad($scheds['COUNT']+1,4,'0',STR_PAD_LEFT)];
        DB::insert ("INSERT INTO tbl_schedule_preset SET ". DB::stmt_builder ($this->data['schedule_preset']),$this->data['schedule_preset']);
        foreach ($this->data['day'] as $key => $days) {
            $has_sched = False;
            $inout = array('sched_code' => $this->data['schedule_preset']['sched_code'], 'weekday' => $days);
            if ($this->data['amin'.$key] != '') {$inout += ['am_in' => date("H:i:s",strtotime($this->data['amin'.$key]))]; $has_sched = True;}
            if ($this->data['amout'.$key] != '') {$inout += ['am_out' => date("H:i:s",strtotime($this->data['amout'.$key]))]; $has_sched = True;}
            if ($this->data['pmin'.$key] != '') {$inout += ['pm_in' => date("H:i:s",strtotime($this->data['pmin'.$key]))]; $has_sched = True;}
            if ($this->data['pmout'.$key] != '') {$inout += ['pm_out' => date("H:i:s",strtotime($this->data['pmout'.$key]))]; $has_sched = True;}
            if ($has_sched) { DB::insert ("INSERT INTO tbl_schedule SET ". DB::stmt_builder ($inout),$inout); }
        }
        $id=$this->data['id'];
        header ("location: /employees/employment-update/$id/schedule/success/".$this->data['schedule_preset']['sched_code']);
    }
    //END OF EMPLOYMENT MODULE
}