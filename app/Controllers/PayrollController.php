<?php
namespace Controllers;

use Model\Payroll;
use Model\SalaryGrade;
use View\PayrollExcel;
use Model\Employee;

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
        $data['action'] = "changed";
        $this->view->display('admin/payroll/salary-grade', $data);
    }

    protected function download_payroll() {
        $payroll = $this->data['payroll'];
        $employees = Payroll::employees($payroll['emp_type']);
        $headers = Payroll::get_headers($payroll['emp_type']);
        $excel = new PayrollExcel("Regular Employees.xlsx", $employees, $headers);
    }
    
    protected function formula () {
        $payroll = $this->data['payroll'];
        $etype = $this->data ? $this->data['etype_id'] : $this->emp_type;
        $data['payroll'] = Payroll::get_payroll_factors($etype);
        if($this->data) {
            $data['vw_formula'] = true;
            $this->view->display('admin/payroll/formula', $data);
        } else {
            return $data;
        }
    }

    protected function generate_report() {
        return [];
    }

    protected function loan() {
        $data['employees'] = Employee::employee_status('true', 1);

        return $data;
    }

    protected function add_payroll_factor() {
        print_r($this->data);
        $data['payroll'] = Payroll::get_payroll_factors($this->data['etype_id']);
        $data['vw_formula'] = true;
        $this->view->display('admin/payroll/formula', $data);
    }

    protected function show_payroll_factor() {
        $this->view->display('admin/modal/add_payroll_factor');
    }
}   