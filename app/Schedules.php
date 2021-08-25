<?php 
use Controllers\ScheduleController;

class Schedules extends ScheduleController{
    
    public function index(){
        $pres = $this->presets();
        $this->view->display('admin/Schedule/schedules', ['infos' => $this->Get_All_Info(),'Presets' => $pres , 'Status' => $this->get_sched_info()]);
    }

    public function do_action () {
        call_user_func_array ([$this, $this->data['action']], $this->data);
    }

    public function showSchedule(){
        $Sched = $this->Get_id();
        $this->view->display('admin/Schedule/Modal/View_Sched', ['Sched' => $Sched]);
    }

   public function showPresets(){
     $pre = $this->presets();
     $emp_sched = $this->Get_id();
       $this->view->display('admin/Schedule/Modal/Update_Schedule', ['schedules' => $this->preset_schdules(), 'Employee_Sched'=> $emp_sched]);
         
   }

   public function sched_time_date(){
       $Sched_time_date = $this->preset_name();
       $this->view->display('admin/Schedule/Name', ['P_Name' => $Sched_time_date, 'Name' => $this->data['Fname']]);
   }

    public function show_pre(){
        $pre = $this->presets();
        $this->view->display('admin/Schedule/SelectOption', ['preset' => $pre]);
    }

    public function saveChanges(){
        $this->insert_schedule();
    }
}