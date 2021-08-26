<?php 

namespace Controllers;

use Database\DB;


class ScheduleController extends Controller{
   private $schedule_code;

   public function Get_All_Info(){
    return DB::fetch_all("SELECT c.no ,c.employee_id ,c.first_name ,c.middle_name,c.last_name,b.position_desc FROM tbl_employee_status a RIGHT JOIN tbl_position b ON b.no = a.position_id RIGHT JOIN tbl_employee c ON c.no = a.employee_id WHERE c.employee_id IS NOT NULL ORDER BY employee_id,last_name,first_name
    ");
   }
  public function get_sched_info(){
    return DB::fetch_all("SELECT a.no, d.sched_code, d.Status FROM tbl_employee a RIGHT JOIN tbl_employee_sched d ON d.employee_id = a.no");
  }
   

   public function Get_id(){
      if($this->data['id']){
         return DB::fetch_all("SELECT *  FROM tbl_schedule a, (SELECT * FROM tbl_employee_sched WHERE employee_id = ?  ORDER BY `date` DESC LIMIT 0,3) b WHERE a.sched_code = b.sched_code",$this->data['id']);          
      }
    }
   
   public function presets(){
     return DB::fetch_all ("SELECT * FROM tbl_schedule_preset WHERE 1 ORDER BY sched_code");
   }
   
   public function preset_schdules(){
      if($this->data['sched_code']){
         return DB::fetch_all('SELECT * FROM tbl_schedule WHERE sched_code = ?', $this->data['sched_code']);
      }
   }

   public function preset_name(){
      if($this->data['id']){
         return DB::fetch_row("SELECT * FROM tbl_employee_sched a  JOIN tbl_schedule_preset b ON a.sched_code = b.sched_code WHERE a.employee_id = ? AND a.Status = 1", $this->data['id']);          
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
         $this->schedule_code = 'SCHED000'.$sched_no;
      }elseif($numlength == 2){
         $this->schedule_code = 'SCHED00'.$sched_no;
      }elseif($numlength == 3){
         $this->schedule_code = 'SCHED0'.$sched_no;
      }elseif($numlength == 4){
         $this->schedule_code = 'SCHED'.$sched_no;
      }
   }


   public function add_work_schedules(){
      $d = $this->data['schedule'];
      print_r($d);
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
               echo '<span style="color:red">You have a pending schedule that will take effect on: '. $check_sched[0]['date'];
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


}