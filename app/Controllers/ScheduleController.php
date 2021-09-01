<?php 

namespace Controllers;

use Database\DB;


class ScheduleController extends Controller{
  
   public function Get_id(){
      if($this->data['id']){
         return DB::fetch_all("SELECT *  FROM tbl_schedule a, (SELECT * FROM tbl_employee_sched WHERE employee_id = ?  ORDER BY `date` DESC LIMIT 0,3) b WHERE a.sched_code = b.sched_code",$this->data['id']);          
      }
    }
   
   public function get_Sched_code(){
      $sched_code = DB::fetch_row("SELECT sched_code FROM `db_master`.`tbl_schedule_preset` ORDER BY sched_code desc limit 1");
      $s_code = $sched_code['sched_code'];
      preg_match('!\d+!',$s_code, $matches);
      $number = (int)$matches[0];
      $sched_no = $number + 1;
      $numlength = mb_strlen($sched_no);
      if($numlength == 1){
         return $this->schedule_code = 'SCHED000'.$sched_no;
      }elseif($numlength == 2){
         return $this->schedule_code = 'SCHED00'.$sched_no;
      }elseif($numlength == 3){
         return $this->schedule_code = 'SCHED0'.$sched_no;
      }elseif($numlength == 4){
         return $this->schedule_code = 'SCHED'.$sched_no;
      }
   }

   public static function  Auto_update_schedule(){
      $effectivity_status = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE Status = 0 ORDER BY date");
      $nowDate = date('Y-m-d');
      foreach($effectivity_status as $es){
         if($es['date'] == $nowDate){
             DB::update("UPDATE tbl_employee_sched SET Status = 2 WHERE employee_id = ? AND Status = 1", $es['employee_id']);
             DB::update("UPDATE tbl_employee_sched SET Status = 1 WHERE employee_id = ? AND Status = 0", $es['employee_id']);
         }
      }
   }

   
   public function insert_schedule(){
      //0 Pending Schedule
      //1 Active Schedule
      //2 Archive Schedule
      $schedule_status_1 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 1 ORDER BY date DESC",$this->data['eff_id']);
      if(!empty($schedule_status_1)){
          if($this->data['eff_date'] == date('Y-m-d')){
            DB::update("UPDATE tbl_employee_sched SET Status = 2 WHERE employee_id = ? AND Status = 1", $this->data['eff_id']);
            DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 1", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
            echo 'Schedule Saved Successfully and effective from now on!';
            exit;
          }elseif($this->data['eff_date']!== date('Y-m-d')){
            $check_sched = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 0 ORDER BY date DESC",$this->data['eff_id']);
            if(empty($check_sched)){
               DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 0", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
               echo 'Saved Sucessfully , Effectivity date is on: <span style="color:red">'.$this->data['eff_date'];
               echo '</span>';
            }else{
               echo '<span style="color:red">You have a pending schedule that will take effect on: '. $check_sched[0]['date'] .' and cannot be save!';
               echo '</span>';
            }
            
          }
         
       }else{
         if($this->data['eff_date']!== date('Y-m-d')){
            $check_sched_0 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 0 ORDER BY date DESC",$this->data['eff_id']);
              if(!empty($check_sched_0)){
               echo '<span style="color:red">You have a pending schedule that will take effect on: '. $check_sched_0[0]['date'];
               echo '</span>';
              }else{
               $insert_0 = DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 0", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
               if($insert_0){
                   echo '<span style="color:red">The effectivity of this schedule is on: '. $this->data['eff_date'];
                  echo '</span>';
               }
              }
            
              
            }elseif($this->data['eff_date']== date('Y-m-d')){
               DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 1", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
               echo 'Schedule Saved Successfully and effective from now on!';
            }
      }
   }


   public function Activate_status_pending(){
      $nowdateActivate = date('Y-m-d');
     
      DB::fetch_all("UPDATE tbl_employee_sched SET Status = 2 WHERE employee_id = ? AND Status = 1", $this->data['Activate_Id']);
      DB::fetch_all("UPDATE tbl_employee_sched a SET a.date = '$nowdateActivate', a.Status = 1 WHERE a.employee_id = ? AND a.Status = 0", $this->data['Activate_Id']);
   }



   public function presets(){
      return DB::fetch_all ("SELECT * FROM tbl_schedule_preset WHERE 1 ORDER BY sched_code");
    }
   
    function selectschedule(){
      return DB::fetch_all("SELECT * FROM tbl_schedule WHERE sched_code=?",$this->data['sched_code']);
    }

}