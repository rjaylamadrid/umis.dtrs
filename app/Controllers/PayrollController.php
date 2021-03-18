<?php
namespace Controllers;

use Model\Payroll;
use Model\SalaryGrade;
use View\PayrollExcel;

class PayrollController extends Controller {
    public $emp_type = '1';
    public $payroll_type;

    // public function init_payroll() {
    //     $employees = Payroll::initialize($this->data['payroll']['emp_type']);
    //     $this->view->assign(['employees' => $employees, 'init' => $this->data['payroll']['emp_type']]);
    //     $this->index();
    // }

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

    protected function init_payroll() {
        $payroll = $this->data['payroll'];
        $employees = Payroll::employees($payroll['emp_type']);
        $headers = Payroll::get_headers($payroll['emp_type']);
        $excel = new PayrollExcel("Regular Employees.xlsx", $employees, $headers);
    }
    
    protected function formula () {
        $payroll = $this->data['payroll'];
        $headers = Payroll::get_headers($this->emp_type);
        $data['compensation'] = $headers['COMPENSATION'];
        return $data;
    }
}