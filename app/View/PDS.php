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

    public static function multiLine($w, $h, $txt=null, $y='0', $border='0', $align='C', $x='0') {
        $txt = $txt ? $txt : 'N/A';
        self::$pdf->multiCell($w, $h, $txt, $border, $align, $x, $y,'','',true, 0, false, false, $h, 'M');
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
                self::educational_background();
                break;
            case '2':
                self::eligibility();
                self::work_experience();
                break;
            case '3':
                self::voluntary_work();
                self::training_seminar();
                self::other_info();
                break;
            case '4':
                self::character_references();
                break;
        }  
    }

    public function personal_info() {
        self::$employee->basic_info();
        self::setText(42, 40, 0, strtoupper(self::$employee->info['last_name']));
        self::setText(42, 46, 0, strtoupper(self::$employee->info['first_name']));
        self::setText(185, 46, 0, strtoupper(self::$employee->basic_info['ext_name']));
        self::setText(42, 52.2, 0, strtoupper(self::$employee->info['middle_name']));
        self::setText(42, 61, 0, date('m/d/Y', self::$employee->basic_info['birthdate']));
        self::setText(42, 70, 0, self::$employee->basic_info['birthplace']);

        if (self::$employee->basic_info['gender'] == 'Male') self::check(43.8, 77.2);
        else self::check(72.9, 77.2);

        self::get_maritalStatus(self::$employee->basic_info['marital_status']);
        self::get_citizenship();

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

    protected function get_citizenship() {
        switch (self::$employee->basic_info['citizenship']) {
            case 'Filipino':
                self::check(139.6, 60.8);
                break;
            case 'Dual Citizenship - by birth':
                self::check(163.6, 65.2);
            case 'Dual Citizenship - by naturalization':
                self::check(179.6, 65.3);
            default:
                self::check(158.5, 60.8);
                self::setText(140, 77.2, 0, self::$employee->basic_info['dual_citizen']);
                break;
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
        self::setText(98, 173.6, 0, self::$employee->family_background['spouse']['ext_name']);
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

    protected function educational_background() {
        self::$employee->education();
        $levels = array('Elementary','Secondary','Vocational','College','Graduate Studies');
        $y = 269;
        for($i=0; $i<sizeof($levels); $i++) {
            $education = [];
            foreach(self::$employee->education as $educ) {
                if($educ['level'] == $levels[$i]) $education = $educ;
            }
            self::$pdf->setXY(41.5,$y);
            self::multiLine(49.5, 8.1, $education['school_name'],0);
            self::multiLine(45.1, 8.1, $education['school_degree'],0);
            self::multiLine(12.5, 8.1, $education['period_from'],0);
            self::multiLine(12.5, 8.1, $education['period_to'],0);
            self::multiLine(19, 8.1, $education['highest_level'],0);
            self::multiLine(14.2, 8.1, $education['year_graduated'],0);
            self::multiLine(15.3, 8.1, $education['academic_honor'],1);
            $y = $y+8.2;
        }
    }

    protected function eligibility() {
        self::$employee->eligibility();
        $y = 22;
        if(!self::$employee->eligibility) self::$employee->eligibility[0] =[];
        foreach (self::$employee->eligibility as $eligibility) {
            self::$pdf->setXY(6, $y);
            self::multiLine(62, 8.1, $eligibility['eligibility_name'], 0);
            self::multiLine(26, 8.1, $eligibility['eligibility_rating'], 0);
            self::multiLine(24, 8.1, $eligibility['eligibility_date_exam'] ? date('m/d/Y', $eligibility['eligibility_date_exam']) : '', 0);
            self::multiLine(60, 8.1, $eligibility['eligibility_place_exam'], 0);
            self::multiLine(18.3, 8.1, $eligibility['eligibility_license'], 0);
            self::multiLine(14.5, 8.1, $eligibility['eligibility_validity'] && $eligibility['eligibility_validity'] != '0000-00-00' ? date('m/d/Y', $eligibility['eligibility_validity']) : '',1);
            $y = $y+8.2;
        }
    }

    protected function work_experience() {
        self::$employee->employment();
        $y = 108.3;
        if (!self::$employee->employment) self::$employee->employment[0] = [];
        foreach (self::$employee->employment as $employment) {
            $sg = $employment['salary_grade'] ? $employment['salary_grade']."-".$employment['step'] : 'N/A';
            $appointment =  $employment['govt_service'] && $employment['govt_service'] == '1' ? 'Y' : 'N';
            self::$pdf->setXY(6, $y);

            self::multiLine(16.2, 7.1, $employment['date_from'] ? date('m/d/Y', $employment['date_from']) : '', 0);
            self::multiLine(16.2, 7.1, $employment['date_from'] ? date('m/d/Y', $employment['date_to']) : '', 0);
            self::multiLine(56, 7.1, $employment['position'], 0);
            self::multiLine(53.2, 7.1, $employment['company'], 0);
            self::multiLine(14, 7.1, $employment['salary'] ? number_format($employment['salary'],2,'.',',') : '', 0);
            self::multiLine(16, 7.1, $sg, 0);
            self::multiLine(19, 7.1, $employment['appointment'], 0);
            self::multiLine(13.5, 7.1, $appointment, 1);
            $y = $y + 7.1;
        }
    }

    protected function voluntary_work() {
        self::$employee->voluntary_work();
        $y = 23.4;
        if (!self::$employee->voluntary_work) self::$employee->voluntary_work[0] = [];
        foreach (self::$employee->voluntary_work as $work) {
            self::$pdf->setXY(6, $y);
            self::multiLine(89, 7.3, $work['organization_name'],0);
            self::multiLine(15.5, 7.3, $work['date_from'] ? date('m/d/Y', $work['date_from']) : '', 0);
            self::multiLine(15.5, 7.3, $work['date_from'] ? date('m/d/Y', $work['date_to']) : '', 0);
            self::multiLine(15, 7.3, $work['total_hours'], 0);
            self::multiLine(69, 7.3, $work['organization_position'], 1);
            $y = $y + 7.3;
        }
    }

    protected function training_seminar() {
        self::$employee->training_seminar();
        $y = 103.8;
        if (!self::$employee->training_seminar) self::$employee->training_seminar[0] = [];
        foreach(self::$employee->training_seminar as $training) {
            self::$pdf->setXY(6, $y);
            self::multiLine(89, 6.8, $training['training_title'], 0);
            self::multiLine(15.5, 6.8, $training['training_from'] ? date('m/d/Y',$training['training_from']) : '', 0);
            self::multiLine(15, 6.8, $training['training_to'] ? date('m/d/Y',$training['training_to']) : '', 0);
            self::multiLine(15.5, 6.8, $training['training_hours'], 0);
            self::multiLine(17, 6.8, $training['training_type'], 0);
            self::multiLine(52, 6.8, $training['training_sponsor'],1);
            $y = $y + 6.8;
        }
    }

    protected function other_info() {
        self::$employee->other_info();
        $infos = array(
            ['title' => 'skills', 'length' => '52.2', 'x' => '6'],
            ['title' => 'recognizations', 'length' => '100', 'x' => '58.2'], 
            ['title' => 'organizations', 'length' => '51.8', 'x' => '158.2']);
        $infos[0]['data'] = self::$employee->other_info['other_skill'] ? explode(';', self::$employee->other_info['other_skill']) : array('0'=>'');
        $infos[1]['data']  = self::$employee->other_info['other_recognition'] ? explode(';', self::$employee->other_info['other_recognition']) : array('0'=>'');
        $infos[2]['data']  = self::$employee->other_info['other_recognition'] ? explode(';', self::$employee->other_info['other_organization']) : array('0'=>'');
        
        foreach($infos as $info) {
            $y = 263;
            for($i=0; $i<sizeof($info['data']); $i++) {
                self::$pdf->setXY($info['x'], $y);
                self::multiLine($info['length'], 6.8, $info['data'][$i], 1);
                $y = $y + 6.8;
            }
        }
    }

    protected function character_references() {
        self::$employee->references();
        $y = 202.5;
        foreach(self::$employee->references as $reference) {
            self::$pdf->setXY(6, $y);
            self::multiLine(78.2, 7.5, $reference['reference_name'], 0); 
            self::multiLine(49.5, 7.5, $reference['reference_address'], 0); 
            self::multiLine(24.5, 7.5, $reference['reference_contact'], 0); 
            $y = $y+7.5;
        }
    }
}