<?php 

namespace Controllers;

use Database\DB;


class ScheduleController extends Controller{
   public static $alerts;

   public function Get_All_Info(){
    return DB::fetch_all("SELECT c.no ,c.employee_id ,c.first_name ,c.middle_name,c.last_name,b.position_desc FROM tbl_employee_status a RIGHT JOIN tbl_position b ON b.no = a.position_id RIGHT JOIN tbl_employee c ON c.no = a.employee_id WHERE c.employee_id IS NOT NULL ORDER BY employee_id,last_name,first_name
    ");
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

   public static function  Auto_update_schedule(){
      $effectivity_status = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE Status = 0 ORDER BY date");
      $nowDate = date('Y-m-d');
      foreach($effectivity_status as $es){
         if($es['date'] == $nowDate){
             DB::update("UPDATE tbl_employee_sched SET Status = 3 WHERE employee_id = ? AND Status = 1", $es['employee_id']);
             DB::update("UPDATE tbl_employee_sched SET Status = 1 WHERE employee_id = ? AND Status = 0", $es['employee_id']);
         }
      }
   }

  

   public function saveChanges(){
      // 0 inactive
      // 1 active
      // 3 archive
      $status0 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 0 ORDER BY date DESC",$this->data['id']);
      $status1 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 1 ORDER BY date DESC",$this->data['id']);
     
      $idf = strtotime('next monday');
      $effectivedate = date('Y-m-d',$idf);
      $empdate = $status0[0]['date'];
     
      if(empty($status1)){
         if($this->data['id'] && $this->data['sched']){

            $sched_date = date('Y-m-d');
            DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ?, Status = 1", [$this->data['sched'],$this->data['id'], $sched_date]);
            echo 'Schedule save successfully!!';
          
         }
      }
      if(!empty($status1)){
         if($this->data['id'] && $this->data['sched']){
            if(!empty($status0)){
               echo 'This employee has a pending schedule to be effective on: '.$empdate.' and cannot be save!';
              
            }else{
                  DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 0", [$this->data['sched'],$this->data['id'] , $effectivedate]);
                  echo 'Schedule successfully saved but this schedule effectivity date is on : '. $effectivedate; 
                  
                  
            }
         }
      }

      
   }

    public function update_effectivity(){
      $update_eff = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 1 ORDER BY date DESC",$this->data['eff_id']);
      $id = $update_eff[0]['employee_id'];
      if(!empty($update_eff)){
         // DB::update("UPDATE tbl_employee_sched SET Status = 1 WHERE employee_id = ? AND Status = 1", $id);
         DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 0", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
         $this->Auto_update_schedule();
      }else{
         DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 0", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
         $this->Auto_update_schedule();
         // DB::update("UPDATE tbl_employee_sched SET Status = 1 WHERE employee_id = ? AND Status = 1", $id);
      }
    }

     

}