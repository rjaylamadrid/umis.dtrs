<?php 
use Controllers\ScheduleController;

class Schedules extends ScheduleController{


    public function do_action () {
        call_user_func_array ([$this, $this->data['action']], $this->data);
    }

    public function showSchedule(){
        $Sched = $this->Get_id();
        $this->view->display('templates/custom/viewschedule_tbl', ['Sched' => $Sched]);
    }

    public function SelectOptionPresetAndtableSchedule(){
        $this->view->display('templates/custom/presetselect', ['preset' => $this->presets()]);
    }

    public function tableschedule(){
        $this->view->display('templates/custom/tableschedule', ['selectschedule' => $this->selectschedule()]);
    }
}