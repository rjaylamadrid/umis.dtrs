<?php 

namespace Controllers;

use Database\DB;


class ScheduleController extends Controller{
   private $alerts;

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

   
   public function insert_schedule(){
      
      $check_schedule_0 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 0 ORDER BY date DESC",$this->data['eff_id']);
      $schedule_status_1 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 1 ORDER BY date DESC",$this->data['eff_id']);
      
      if(!empty($schedule_status_1)){ 
        DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 0", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
        $check_date_0 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND Status = 0 ORDER BY date DESC",$this->data['eff_id']);
       
         if($check_date_0[0]['date'] == date('Y-m-d')){
            DB::update("UPDATE tbl_employee_sched SET Status = 3 WHERE employee_id = ? AND Status = 1", $this->data['eff_id']);
            DB::update("UPDATE tbl_employee_sched SET Status = 1 WHERE employee_id = ? AND Status = 0", $this->data['eff_id']);
            echo 'This schedule effective from now on!';
            exit;
         } 

       }else{
        DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,Status = 1", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
          echo 'Schedule Saved Successfully';
      }

      
     

   }


}