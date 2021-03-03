<?php
namespace Controllers;

use Model\Payroll;
use Model\SalaryGrade;

class PayrollController extends Controller {

    public function init_payroll() {
        $employees = Payroll::initialize($this->data['payroll']['emp_type']);
        $this->view->assign(['employees' => $employees, 'init' => $this->data['payroll']['emp_type']]);
        $this->index();
    }

    protected function salary_grade ($sg_id = NULL) {
        $this->salary_grade = new SalaryGrade($sg_id);
        $this->salary_grade->salary_tranches();
        $data['sg'] = $this->salary_grade;
        return $data;
    } 

    protected function show_salary () {
        $data = $this->salary_grade($this->data['tranche']);
        $this->view->display('admin/payroll/salary-grade', $data);
    }

    public function download_payroll() {
        Payroll::generate($this->data['payroll']);
    }
    
    protected function formula () {
        $data[] = "hello world";
        return $data;
    }
}