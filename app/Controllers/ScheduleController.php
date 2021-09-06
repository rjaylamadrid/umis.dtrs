<?php 

namespace Controllers;

use Database\DB;


class ScheduleController extends Controller{
  
   public function Get_id(){
      if($this->data['id']){
         return DB::fetch_all("SELECT *  FROM tbl_schedule a, (SELECT * FROM tbl_employee_sched WHERE employee_id = ?  ORDER BY `date` DESC LIMIT 0,3) b WHERE a.sched_code = b.sched_code ORDER BY weekday",$this->data['id']);          
      }
    }
    public function insert_into_preset(){
      $scheds = DB::fetch_row ("SELECT COUNT(*)AS COUNT FROM tbl_schedule_preset");
      $code = "SCHED".str_pad($scheds['COUNT']+1,4,'0',STR_PAD_LEFT);
      $p_name = $this->data['p_name'];
      $p_time = $this->data['p_time'];
      DB::insert("INSERT INTO tbl_schedule_preset SET sched_code = ?, sched_day = ?, sched_time = ?", [$code,$p_name,$p_time]);
    }


    public function create_sched(){
    
      $d_Code = DB::fetch_row("SELECT sched_code FROM tbl_schedule_preset ORDER BY sched_code DESC LIMIT 1");
      $code1 = $d_Code['sched_code'];
      DB::insert("INSERT INTO tbl_schedule SET sched_code = ?, weekday = ?, am_in = ?,am_out = ?,pm_in = ?,pm_out = ?", [$code1,$this->data['day'],$this->data['amin'],$this->data['amout'],$this->data['pmin'],$this->data['pmout']]);
      echo 'lester';
      
    }
   
   

   public static function  Auto_update_schedule(){
      $effectivity_status = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE status = 0 ORDER BY date");
      $nowDate = date('Y-m-d');
      foreach($effectivity_status as $es){
         if($es['date'] == $nowDate){
             DB::update("UPDATE tbl_employee_sched SET status = 2 WHERE employee_id = ? AND status = 1", $es['employee_id']);
             DB::update("UPDATE tbl_employee_sched SET status = 1 WHERE employee_id = ? AND status = 0", $es['employee_id']);
         }
      }
   }

   
   public function insert_schedule(){
      //0 Pending Schedule
      //1 Active Schedule
      //2 Archive Schedule
      $schedule_status_1 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND status = 1 ORDER BY date DESC",$this->data['eff_id']);
      if(!empty($schedule_status_1)){
          if($this->data['eff_date'] == date('Y-m-d')){
            DB::update("UPDATE tbl_employee_sched SET status = 2 WHERE employee_id = ? AND status = 1", $this->data['eff_id']);
            DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,status = 1", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
            echo 'Schedule Saved Successfully and effective from now on!';
            exit;
          }elseif($this->data['eff_date']!== date('Y-m-d')){
            $check_sched = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND status = 0 ORDER BY date DESC",$this->data['eff_id']);
            if(empty($check_sched)){
               DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,status = 0", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
               echo 'Saved Sucessfully , Effectivity date is on: <span style="color:red">'.$this->data['eff_date'];
               echo '</span>';
            }else{
               echo '<span style="color:red">You have a pending schedule that will take effect on: '. $check_sched[0]['date'] .' and cannot be save!';
               echo '</span>';
            }
            
          }
         
       }else{
         if($this->data['eff_date']!== date('Y-m-d')){
            $check_sched_0 = DB:: fetch_all("SELECT * FROM tbl_employee_sched WHERE employee_id = ? AND status = 0 ORDER BY date DESC",$this->data['eff_id']);
              if(!empty($check_sched_0)){
               echo '<span style="color:red">You have a pending schedule that will take effect on: '. $check_sched_0[0]['date'];
               echo '</span>';
              }else{
                 if($this->data['eff_date'] < date('Y-m-d')){
                  $insert_1 = DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,status = 1", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]); 
                  if($insert_1){
                     echo 'Schedule Saved Successfully!';   
                  }
                     
                  }elseif($this->data['eff_date'] > date('Y-m-d')){
                     $insert_0 = DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,status = 0", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
                     if($insert_0){
                        echo '<span style="color:red">The effectivity of this schedule is on: '. $this->data['eff_date'];
                        echo '</span>';
                    }
                  }
                    
                 
                }
               
             
            
              
            }elseif($this->data['eff_date']== date('Y-m-d')){
               DB::insert("INSERT INTO tbl_employee_sched SET sched_code = ?, employee_id = ?, date = ? ,status = 1", [$this->data['eff_schedcode'],$this->data['eff_id'] ,$this->data['eff_date']]);
               echo 'Schedule Saved Successfully and effective from now on!';
            }
      }
   }


   public function Activate_status_pending(){
      $nowdateActivate = date('Y-m-d');
     
      DB::fetch_all("UPDATE tbl_employee_sched SET status = 2 WHERE employee_id = ? AND status = 1", $this->data['Activate_Id']);
      DB::fetch_all("UPDATE tbl_employee_sched a SET a.date = '$nowdateActivate', a.status = 1 WHERE a.employee_id = ? AND a.status = 0", $this->data['Activate_Id']);
   }



   public function presets(){
      return DB::fetch_all ("SELECT * FROM tbl_schedule_preset WHERE 1 ORDER BY sched_code");
    }
   
    function selectschedule(){
      return DB::fetch_all("SELECT * FROM tbl_schedule WHERE sched_code=?",$this->data['sched_code']);
    }

   function MinDate(){
   return DB::fetch_row("SELECT date FROM tbl_employee_sched WHERE employee_id = ? AND status = 1 ORDER BY date",$this->data['id']);
   
   }
}