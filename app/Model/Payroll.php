<?php
namespace Model;

use Model\Employee;
use Model\Position;
use View\Excel;

class Payroll{
    static $employees;
    static $payroll;
    static $excel;
    static $headers;

    public static function initialize() {
        self::$employees = [];
        $type = self::$payroll['emp_type'];
        $types = $type == '1' ? '124' : $type;

        for ($i=0; $i<strlen($types); $i++) {
            $employees = Employee::type(substr($types, $i, 1));
            self::$employees = array_merge(self::$employees, $employees);
        }
        self::position();
        return self::$employees;
    }

    protected static function position() {
        $employees = [];
        foreach (self::$employees as $employee) {
            $position = new Position($employee['position_id'], $employee['date_start'], $employee['etype_id'], null, null, $employee['step']);
            $employee['position'] = $position->position['position_desc'];
            $employee['salary'] = $position->position['salary'];
            $employee['sg'] = $position->position['salary_grade'];
            $employees[] = $employee;
        }
        self::$employees = $employees;
    }

    public static function generate($payroll) {
        Excel::set();
        self::$excel = Excel::$sheet;
        self::$payroll = $payroll;
        self::initialize();
        $sheets = intval(sizeof(self::$employees)/20);
        $sheets += sizeof(self::$employees)%20 > 0 ? 1 : 0;
        
        for ($i = 1; $i <= $sheets; $i++) {
            self::set_page($i, $sheets);
        }
        Excel::download("payroll.xlsx");
    }

    protected static function set_page($no, $sheets) {
        $row = ($no - 1) * 37;
        $irow = 0;
        self::$headers = ["No.", "Name", "Employee ID", "Position", "Compensation" => ["Monthly Salary", "PERA"]];
        self::set_header($no, $sheets, $row);

        Excel::set_style(['font' => ['size' => 10,'bold' => false,'name'=>'Arial']]);
        for($i = 0; $i < 20; $i++) {
            $ind = (($no - 1) * 20) + $i;

            if (self::$employees[$ind]) {
                $irow = ($row + 12) + $i;
                Excel::set_value('A'.$irow, $ind + 1, null, null, 'center');
                $name = self::$employees[$ind]['last_name'].', '.self::$employees[$ind]['first_name'].' '.substr(self::$employees[$ind]['middle_name'], 0,1).'.';
                Excel::set_value('B'.$irow, $name);
                Excel::set_value('C'.$irow, self::$employees[$ind]['employee_id']);
                
                $position = new Position(self::$employees[$ind]['position_id']);
                Excel::set_value('D'.$irow, $position->position['position_code']);
                Excel::set_value('E'.$irow, $position->position['salary'], null, 'E'.$irow.':F'.$irow, 'right');
            }
        }
        $irow += 1;
        Excel::set_value('A'.$irow,'        Total Page '.$no, ['font' => ['bold' => true]], 'A'.$irow.':D'.$irow);

        if($no == $sheets) {
            $irow += 1;
            Excel::set_value('A'.$irow,'', null, 'A'.$irow.':D'.$irow);
        }
        self::set_footer($irow);
    }

    protected static function set_header($no, $sheets, $row) { 
        
        Excel::set_style(['font' => ['size' => 11,'bold' => false,'name'=>'Times']]);
        self::$excel->getDefaultColumnDimension()->setWidth(12);
        self::$excel->getDefaultRowDimension()->setRowHeight(12);
        $columns = ['A' => '4', 'B' => '29', 'C' => '9', 'D' => '8', 'E' => '4', 'F' => '8', 'K' => '4', 'L' => '8', 'P' => '4', 'Q' => '8', 'V' => '4', 'W' => '10'];
        $rows = [$row+1 => '23', $row+2 => '20', $row+3 => '9', $row+4 => '14', $row+5 => '14', $row+7 => '6'];
        Excel::column_width($columns);
        Excel::row_height($rows);
        
        Excel::set_value('A'.($row+1), 'P   A   Y   R   O   L   L', ['font' => ['size' => 18,'bold' => true]], 'A'.($row+1).':C'.($row+1));
        Excel::set_value('A'.($row+2), '  For the period ', ['font' => ['size' => 16,'bold' => true]], 'A'.($row+2).':D'.($row+2));
        Excel::set_value('B'.($row+4), 'Entity Name : CENTRAL BICOL STATE UNIVERSITY OF AGRICULTURE-SIPOCOT', ['font' => ['bold' => true]], 'B'.($row+4).':I'.($row+4));
        Excel::set_value('B'.($row+5), 'Fund Cluster : _______________________________', ['font' => ['bold' => true]], 'B'.($row+5).':G'.($row+5));
        Excel::set_value('Q'.($row+4), 'Payroll No. : _______________________', ['font' => ['bold' => true]], 'Q'.($row+4).':S'.($row+4));
        Excel::set_value('Q'.($row+5), 'Sheet '.$no.' of  '.$sheets.' Sheets', ['font' => ['bold' => true]], 'Q'.($row+5).':S'.($row+5));
        Excel::set_value('B'.($row+6), 'We acknowledge receipt of cash shown opposite our name as full compensation for services rendered for the period covered.', null, 'B'.($row+6).':N'.($row+6));
        Excel::set_style(['font' => ['size' => 10,'bold' => false,'name'=>'Arial']]);

        for ($i=0; $i < sizeof(self::$headers); $i++) {
            if (is_array(self::$headers[$i])) {
               
                    Excel::set_value(self::getColumn($i).'8', key_arrays(self::$headers[$i])[0]);
            }
            Excel::set_value(self::getColumn($i).'8', self::$headers[$i]);
        }
    }

    protected static function getColumn($index) {
        $columns = range("A", "Z");
        return $columns[$index];
    }

    protected static function set_footer($row) {
        Excel::set_value('A'.($row+1), 'A', ['font' => ['size' => 12,'bold' => true]], null, 'center');
        Excel::set_value('B'.($row+1), 'CERTIFIED :Services have been rendered as stated :', null, 'B'.($row+1).':D'.($row+2));
        Excel::set_value('E'.($row+1), 'B', ['font' => ['size' => 12,'bold' => true]], null, 'center');
        Excel::set_value('F'.($row+1), 'CERTIFIED : Supporting documents complete and proper and cash available in the amount of :  ________________', null, 'F'.($row+1).':J'.($row+2), 'left', 'center', true);
        Excel::set_value('K'.($row+1), 'C', ['font' => ['size' => 12,'bold' => true]], null, 'center');
        Excel::set_value('L'.($row+1), 'APPROVED FOR PAYMENT:', null, 'L'.($row+1).':O'.($row+2));
        Excel::set_value('P'.($row+1), 'D', ['font' => ['size' => 12,'bold' => true]], null, 'center');
        Excel::set_value('Q'.($row+1), 'CERTIFIED : Each employee whose name appears above have been paid the amount opposite their name.', null, 'Q'.($row+1).':U'.($row+2), 'left', 'center', true);
        Excel::set_value('V'.($row+1), 'E', ['font' => ['size' => 12,'bold' => true]], null, 'center');
        Excel::set_value('V'.($row+2), 'ORS/BURS No:', null, 'V'.($row+2).':W'.($row+2), 'right');
        Excel::set_border('Z'.($row+2).':Y'.($row+2), 'bottom', 'thin');
        Excel::set_value('V'.($row+3), 'Date:', null, 'V'.($row+3).':W'.($row+3), 'right');
        Excel::set_border('Z'.($row+3).':Y'.($row+3), 'bottom', 'thin');
        Excel::set_value('V'.($row+4), 'JEV No:', null, 'V'.($row+4).':W'.($row+4), 'right');
        Excel::set_border('Z'.($row+4).':Y'.($row+4), 'bottom', 'thin');
        Excel::set_value('V'.($row+5), 'Date:', null, 'V'.($row+5).':W'.($row+5), 'right');

        Excel::set_border('A'.($row+1).':D'.($row+5), 'outline', 'medium');
        Excel::set_border('B'.($row+1).':J'.($row+5), 'outline', 'medium');
        Excel::set_border('K'.($row+1).':O'.($row+5), 'outline', 'medium');
        Excel::set_border('P'.($row+1).':U'.($row+5), 'outline', 'medium');
        Excel::set_border('V'.($row+1).':Z'.($row+5), 'outline', 'medium');
    }
}