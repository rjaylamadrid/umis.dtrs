<?php
namespace View;

use View\PDF;
use Model\EmployeeProfile;

class PDS extends PDF{
    static $pdf;
    static $employee;
    static $check;

    public function __construct($id, $template){
        self::$employee = new EmployeeProfile($id);
        self::$pdf = self::newPDF();
        self::export($template);

        for ($i=1; $i<=4; $i++) {
            self::getPage($i);
        }
        self::$pdf->Output(self::$employee->info['last_name'].'_pds.pdf', 'I');
    }

    public function check($x, $y) {
        self::$pdf->SetFont('zapfdingbats','', 7);
        self::setText($x, $y, 0, '3');

        self::$pdf->SetFont('helvetica','B', 7);
    }

    public static function setText($x, $y, $h=0, $text) {
        self::$pdf->setXY($x, $y);
        $text = $text ? $text : 'N/A';
        self::$pdf->Write($h, $text);
    }

    public function getPage($page) {
        self::$pdf->AddPage('P', array(216, 330));
        $template = self::$pdf->importPage($page);
        self::$pdf->useTemplate($template);
        self::$pdf->SetFont('helvetica','B', 7);

        switch ($page){
            case '1':
                self::personal_info();
                self::family_background();
                break;
            case '2':
                self::eligibility();
                self::work_experience();
                break;
            case '3':
                self::voluntary_work();
                self::training_seminar();
                break;
        }  
    }

    public function personal_info() {
        self::$employee->basic_info();
        self::setText(42, 40, 0, strtoupper(self::$employee->info['last_name']));
        self::setText(42, 46, 0, strtoupper(self::$employee->info['first_name']));
        self::setText(185, 46, 0, strtoupper(self::$employee->basic_info['ext_name']));
        self::setText(42, 52.2, 0, strtoupper(self::$employee->info['middle_name']));
        self::setText(42, 61, 0, date_create(self::$employee->basic_info['birthdate'])->format('m/d/Y'));
        self::setText(42, 70, 0, self::$employee->basic_info['birthplace']);

        if (self::$employee->basic_info['gender'] == 'Male') self::check(43.8, 77.2);
        else self::check(72.9, 77.2);

        self::get_maritalStatus(self::$employee->basic_info['marital_status']);

        self::setText(42, 98, 0, self::$employee->basic_info['height']);
        self::setText(42, 105, 0, self::$employee->basic_info['weight']);
        self::setText(42, 112, 0, self::$employee->basic_info['blood_type']);
        self::setText(42, 119, 0, self::$employee->basic_info['gsis_no']);
        self::setText(42, 126, 0, self::$employee->basic_info['pagibig_no']);
        self::setText(42, 133.5, 0, self::$employee->basic_info['philhealth_no']);
        self::setText(42, 140.5, 0, self::$employee->basic_info['sss_no']);
        self::setText(42, 147.7, 0, self::$employee->basic_info['tin_no']);
        self::setText(42, 155, 0, self::$employee->basic_info['employee_id']);
        
        self::get_Address();
        self::setText(122, 141, 0, self::$employee->basic_info['telephone_no']);
        self::setText(122, 148, 0, self::$employee->basic_info['cellphone_no']);
        self::setText(122, 155, 0, self::$employee->basic_info['email_address']);
    }

    protected function get_maritalStatus($stat) {
        $m_status = array(
            ['status'=>'Single', 'x' => 43.8, 'y' => 83.2],
            ['status'=>'Married', 'x' => 72.9, 'y' => 83.4],
            ['status'=>'Widowed', 'x' => 43.8, 'y' => 87.5],
            ['status'=>'Separated', 'x' => 72.9, 'y' => 87.7]);
        
        foreach ($m_status as $status) {
            if ($status['status'] == $stat) self::check($status['x'], $status['y']);
        }
    }

    protected function get_Address() {
        self::$pdf->setXY(121,83);
        self::$pdf->Cell(40, 0, self::$employee->basic_info['resadd_house_block_no'], 0, 0, 'C', 0, 1);
        self::$pdf->Cell(49, 0, self::$employee->basic_info['resadd_street'], 0, 1, 'C', 0, 1);
        self::$pdf->setXY(121,90);
        self::$pdf->Cell(40, 0, self::$employee->basic_info['resadd_sub_village'], 0, 0, 'C', 0, 1);
        self::$pdf->Cell(49, 0, self::$employee->basic_info['resadd_brgy'], 0, 1, 'C', 0, 1);
        self::$pdf->setXY(121,97.5);
        self::$pdf->Cell(40, 0, self::$employee->basic_info['resadd_mun_city'], 0, 0, 'C', 0, 1);
        self::$pdf->Cell(49, 0, self::$employee->basic_info['resadd_province'], 0, 1, 'C', 0, 1);
        self::setText(122, 105, 0, self::$employee->basic_info['resadd_zip_code']);

        self::$pdf->setXY(121,110.7);
        self::$pdf->Cell(40, 0, self::$employee->basic_info['peradd_house_block_no'], 0, 0, 'C', 0, 1);
        self::$pdf->Cell(49, 0, self::$employee->basic_info['peradd_street'], 0, 1, 'C', 0, 1);
        self::$pdf->setXY(121,118);
        self::$pdf->Cell(40, 0, self::$employee->basic_info['peradd_sub_village'], 0, 0, 'C', 0, 1);
        self::$pdf->Cell(49, 0, self::$employee->basic_info['peradd_brgy'], 0, 1, 'C', 0, 1);
        self::$pdf->setXY(121,125.4);
        self::$pdf->Cell(40, 0, self::$employee->basic_info['peradd_mun_city'], 0, 0, 'C', 0, 1);
        self::$pdf->Cell(49, 0, self::$employee->basic_info['peradd_province'], 0, 1, 'C', 0, 1);
        self::setText(122, 133.7, 0, self::$employee->basic_info['peradd_zip_code']);
    }

    protected function family_background() {
        self::$employee->family_background();
        self::setText(42, 166.7, 0, self::$employee->family_background['spouse']['last_name']);
        self::setText(42, 172.7, 0, self::$employee->family_background['spouse']['first_name']);
        self::setText(98, 173.4, 0, self::$employee->family_background['spouse']['ext_name']);
        self::setText(42, 178.7, 0, self::$employee->family_background['spouse']['middle_name']);
        self::setText(42, 185, 0, self::$employee->family_background['spouse']['occupation']);
        self::setText(42, 191, 0, self::$employee->family_background['spouse']['employer']);
        self::setText(42, 197, 0, self::$employee->family_background['spouse']['business_address']);
        self::setText(42, 203.3, 0, self::$employee->family_background['spouse']['telephone_no']);

        $y = 172.7;
        if (self::$employee->family_background['children'] ) {
            foreach(self::$employee->family_background['children'] as $children) {
                self::setText(122, $y, 0, $children['name']);
                self::setText(181, $y, 0, date_create($children['birthdate'])->format('m/d/Y'));
                $y = $y + 6.1;
            }
        } else {
            self::setText(122, $y, 0, 'N/A');
            self::setText(181, $y, 0, 'N/A');
        }

        self::setText(42, 209.2, 0, self::$employee->family_background['father']['last_name']);
        self::setText(42, 215.2, 0, self::$employee->family_background['father']['first_name']);
        self::setText(98, 216.3, 0, self::$employee->family_background['father']['ext_name']);
        self::setText(42, 221.5, 0, self::$employee->family_background['father']['middle_name']);
        self::setText(42, 233.7, 0, self::$employee->family_background['mother']['last_name']);
        self::setText(42, 239.8, 0, self::$employee->family_background['mother']['first_name']);
        self::setText(42, 245.9, 0, self::$employee->family_background['mother']['middle_name']);
    }

    protected function eligibility() {
        self::$employee->eligibility();
        $y = 24;
        if(self::$employee->eligibility){
            foreach (self::$employee->eligibility as $eligibility) {
                self::$pdf->setXY(6, $y);
                self::$pdf->Cell(62, 0, $eligibility['eligibility_name'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(26, 0, $eligibility['eligibility_rating'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(24, 0, date_create($eligibility['eligibility_date_exam'])->format('m/d/Y'), 0, 0, 'C', 0, 1);
                self::$pdf->Cell(60, 0, $eligibility['eligibility_place_exam'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(18, 0, $eligibility['eligibility_license'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(15, 5.7, date_create($eligibility['eligibility_validity'])->format('m/d/Y'),0, 0, 'C', 0, 1);
                $y = $y+8.2;
            }
        }else{
            self::$pdf->setXY(6, $y);
            self::$pdf->Cell(62, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(26, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(24, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(60, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(18, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(15, 5.7, 'N/A',0, 0, 'C', 0, 1);
        }
    }

    protected function work_experience() {
        self::$employee->employment();
        $y = 109.8;
        if (self::$employee->employment) {
            foreach (self::$employee->employment as $employment) {
                $sg = $employment['salary_grade'] ? $employment['salary_grade']."-".$employment['step'] : 'N/A';
                self::$pdf->setXY(6, $y);
                self::$pdf->Cell(16, 0, date_create($employment['date_from'])->format('m/d/Y'), 0, 0, 'C', 0, 1);
                self::$pdf->Cell(16.2, 0, date_create($employment['date_to'])->format('m/d/Y'), 0, 0, 'C', 0, 1);
                self::$pdf->Cell(56, 0, $employment['position'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(53.5, 0, $employment['company'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(14, 0, $employment['salary'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(16, 0, $sg, 0, 0, 'C', 0, 1);
                self::$pdf->Cell(19, 0, $employment['appointment'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(13.5, 0, $employment['govt_service'] == '1' ? 'Y' : 'N', 0, 0, 'C', 0, 1);
                $y = $y + 7.2;
            }
        } else {
            self::$pdf->setXY(6, $y);
            self::$pdf->Cell(16, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(16.2, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(56, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(53.5, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(14, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(16, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(19, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(13.5, 0, 'N/A', 0, 0, 'C', 0, 1);
        }
    }

    protected function voluntary_work() {
        self::$employee->voluntary_work();
        $y = 25;
        if (self::$employee->voluntary_work) {
            foreach (self::$employee->voluntary_work as $work) {
                self::$pdf->setXY(6, $y);
                self::$pdf->Cell(89, 0, $work['organization_name'],0, 0, 'C', 0, 1);
                self::$pdf->SetFont('helvetica','', 7);
                self::$pdf->Cell(16, 0, date_create($work['date_from'])->format('m/d/Y'), 0, 0, 'C', 0, 1);
                self::$pdf->Cell(15, 0, date_create($work['date_to'])->format('m/d/Y'), 0, 0, 'C', 0, 1);
                self::$pdf->SetFont('helvetica','', 9);
                self::$pdf->Cell(15, 0, $work['total_hours'], 0, 0, 'C', 0, 1);
                self::$pdf->Cell(69, 0, $work['organization_position'], 0, 0, 'C', 0, 1);
                $y = $y + 8;
            }
        } else {
            self::$pdf->setXY(6, $y);
            self::$pdf->Cell(89, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(15.5, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(15, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(15.5, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(69, 0, 'N/A', 0, 0, 'C', 0, 1);
        }
    }

    protected function training_seminar() {
        $y = 105.3;
        self::$pdf->setXY(6, $y);
            self::$pdf->Cell(89, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(15.5, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(15, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(15.5, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(17, 0, 'N/A', 0, 0, 'C', 0, 1);
            self::$pdf->Cell(52, 0, 'N/A', 0, 0, 'C', 0, 1);
    }
}
