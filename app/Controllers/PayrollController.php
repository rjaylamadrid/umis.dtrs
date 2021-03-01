<?php
namespace Controllers;

use Model\Payroll;

class PayrollController extends Controller {

    public function init_payroll() {
        $employees = Payroll::initialize($this->data['payroll']['emp_type']);
        $this->view->assign(['employees' => $employees, 'init' => $this->data['payroll']['emp_type']]);
        $this->index();
    }

    public function download_payroll() {
        Payroll::download();
    }
}