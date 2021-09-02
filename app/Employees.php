<?php
use Model\Position;
use Model\Employee;
use Model\EmployeeStats;
use Model\EmployeeProfile;
use Controllers\EmployeesController;
use Model\Schedule;
use View\PDS;

class Employees extends EmployeesController {
    private $stats;
    public $employee;
   
    

    public function index () {
        $this->position = new Position();
        $this->position->emp_types();
        $status  = $this->data['inactive'] ? 0 : 1;
        $this->stats = EmployeeStats::campus ($this->user['campus_id'])->get_stats ();
        $employees = Employee::campus($this->user['campus_id'])->position()->type($this->data['status'], $status);
        $this->get_filters();
        
        // print_r("<pre>");
        // print_r($this->get_campus_det());
        // print_r("</pre>");
        $this->view->display ('admin/employees', ["stats" => $this->stats, "employees" => $employees,'emp_type' => $this->position->emp_types,'departments' => $this->departments(), 'designations' => $this->designations(), "status" => $status, "result" => $this->result, "type" => $this->data['status'], "campus" => $this->get_campus_det(), "filters" => $this->filters ,"SchedStat" => $this->get_sched_info() ]);  
    }

    public function profile ($id = null, $tab = 'basic-info', $view='view', $message=NULL) {
        $this->employee = new EmployeeProfile ($id);
        try {
            $this->employee->{str_replace ("-", "_", $tab)}();
        } catch (\Throwable $th) {
            $tab = 'basic-info';
            $this->employee->basic_info ();
        }
        $this->view->display ('profile', ["employee" => $this->employee, "tab" => $tab, "view" => $view, "message" => $message]);
    }

    public function do_action () {
        try {
            $this->{$this->data['action']} ();
        } catch (\Throwable $th) {
            $this->index();
        }
    }

    public function update ($id, $view = 'basic-info') {
        $this->profile ($id,$view,'update');
    }

    public function employment_update ($id, $tab = 'employment_info', $result = NULL, $sched = NULL) {
        $this->employment ($id,$tab,'update', $result, $sched);
    }

    public function save ($id, $tab='basic-info') {
        $result = $this->update_profile($id,$_POST['employeeinfo'],$_FILES['profile_picture'],$tab,$_POST['admin_id']);
        if ($result == 'success') $message = ['success' => 'success', 'message' => 'Employee\'s profile was successfully updated!'];
        $this->profile ($id,$tab,'view',$message);
    }

    public function add_profile_info ($id, $tab = 'basic-info') {
        $empAdd = $this->add_profile($id,$_POST['employeeinfo'],$tab,$_POST['admin_id']);
        header ("location: /employees/update/$id/$tab");
    }

    public function registration () {
        $this->position = new Position();
        $this->position->emp_types(); 
        $presets = Schedule::presets()->all ();
        $this->view->display ('admin/employee_registration', ['emp_type' => $this->position->emp_types, 'schedules' => $presets , 'departments' => $this->departments(), 'designations' => $this->designations(), 'id' => $this->new_id ('1'), 'no' => $this->employee_no(), 'message' => $this->message]);
    }

    public function employment ($id, $tab = 'employment_info', $view = 'view', $message = NULL, $sched = NULL) {
        if ($sched != NULL) {
            
            if ($message) $message = ['success' => '1', 'message' => 'Work schedule has been successfully saved!'];
        } else {
            
            if ($message) $message = ['success' => '1', 'message' => 'Employment information has been successfully updated!'];
        }
        $this->employee = new EmployeeProfile ($id);
        $position = new Position();
        $position->emp_types();
        $position->positions($this->employee->info['etype_id']);
        try {
            $this->employee->{str_replace ("-", "_", $tab)}();
        } catch (\Throwable $th) {
            $this->employee->info ();
        }
       $presets = Schedule::presets()->all();
      
        $this->view->display ('admin/employee_employment', ['positions' => $position->positions, 'emp_type' => $position->emp_types, 'employee' => $this->employee, 'tab' => $tab, 'view' => $view, 'presets' => $presets , 'departments' => $this->departments(), 'designations' => $this->designations(), 'message' => $message, 'sched' => $sched]);
    }

    public function export ($id) {
        $pds = new PDS($id, '../public/assets/pdf/PDS.pdf');
    }
}