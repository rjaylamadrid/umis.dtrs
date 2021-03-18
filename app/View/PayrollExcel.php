<?php
namespace View;

use View\Excel;

class PayrollExcel {
    public $payroll;
    public $merge = ['E' => 'F', 'K' => 'L', 'P' => 'O', 'V' => 'W'];
    public $employees;
    public $excel;
    public $headers;
    public $columns;
    public $rows;
    public $lastColumn;
    public $title;

    public function __construct($title, $employees, $headers) {
        $this->title = $title;
        $this->employees = $employees;
        $this->headers = $headers;
        $this->generate();
    }

    protected function generate() {
        Excel::set();
        $this->excel = Excel::$sheet;
        
        $sheets = intval(sizeof($this->employees)/20);
        $sheets += sizeof($this->employees)%20 > 0 ? 1 : 0;
        
        for ($i = 1; $i <= $sheets; $i++) {
            $this->set_page($i, $sheets);
        }
        Excel::download($this->title);
    }

    

    protected function set_page($no, $sheets) {
        $row = ($no - 1) * 37;
        $irow = 0;
        $this->set_header($no, $sheets, $row);

        Excel::set_style(['font' => ['size' => 10,'bold' => false,'name'=>'Arial']]);
        for($i = 0; $i < 20; $i++) {
            $ind = (($no - 1) * 20) + $i;

            if ($this->employees[$ind]) {
                $irow = ($row + 12) + $i;
                Excel::set_value('A'.$irow, $ind + 1, null, null, 'center');
                $name = $this->employees[$ind]['last_name'].', '.$this->employees[$ind]['first_name'].' '.substr($this->employees[$ind]['middle_name'], 0,1).'.';
                Excel::set_value('B'.$irow, $name);
                Excel::set_value('C'.$irow, $this->employees[$ind]['employee_id']);
                Excel::set_value('D'.$irow, $this->employees[$ind]['position']);
                Excel::set_value('E'.$irow, $this->employees[$ind]['salary'], null, 'E'.$irow.':F'.$irow, 'right');
            }
        }
        Excel::set_border('A'.($row+12).':'.$this->lastColumn.$irow, 'inside', 'thin');
        Excel::set_border('A'.($row+12).':'.$this->lastColumn.$irow, 'outline', 'medium');
        $irow = $this->get_total($row+12, $irow+1, $no==$sheets, $no);
        $this->set_footer($irow);
    }

    protected function set_header($no, $sheets, $row) { 

        Excel::set_style(['font' => ['size' => 11,'bold' => false,'name'=>'Times']]);
        $this->excel->getDefaultColumnDimension()->setWidth(12);
        $this->excel->getDefaultRowDimension()->setRowHeight(12);
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

        $this->get_header($this->headers, $row+8, $row+11);
        Excel::set_border('A'.($row+8).':'.$this->lastColumn.($row+11), 'inside', 'thin');
        Excel::set_border('A'.($row+8).':'.$this->lastColumn.($row+11), 'outline', 'medium');
    }
    
    public function get_header($headers, $row, $endrow) {
        foreach($headers as $key => $value) {
            if (is_array($value)) {
                $this->get_header($value, $row+1, $endrow);
                $start= $this->get_key($value);
                $end = $this->get_key($value, 'end');
                Excel::set_value($start.$row, $key, null, $start.$row.":".$end.$row, 'center');
            } else {
                $this->columns[] = $key;
                $this->lastColumn = array_key_exists($key, $this->merge) ? $this->merge[$key] : $key;
                Excel::set_value($key.$row, $value, null, $key.$row.":".$this->lastColumn.$endrow, 'center', 'center', true);
            }
        }
    }

    protected function get_key($arr, $position = "start") {
        while (is_array($arr)) {
            if($position != "start") {
                end($arr);
            }
            $key = key($arr);
            $arr = $arr[$key];
        }
        return $key;
    }

    protected function get_total($start, $row, $last = false, $no) {
        if ($last && $no=='1') {
            Excel::set_value('A'.$row,'        Total', ['font' => ['bold' => true]], 'A'.$row.':D'.$row);
            $this->set_total($this->columns, $start, $row);
        } else{
            $irow = $last ? $row+1 : $row;
            Excel::set_value('A'.$row,'        Total Page '.$no, ['font' => ['bold' => true]], 'A'.$row.':D'.$row);
            $this->rows[] = $row;
            $this->set_total($this->columns, $start, $row);
            if($last) {
                Excel::set_value('A'.($row+1),'        Total', ['font' => ['bold' => true]], 'A'.($row+1).':D'.($row+1));
                $this->set_total($this->columns, $start, $row+1, $this->rows);
            }
        }
        return $irow;
    }

    protected function set_total ($columns, $start, $row, $rows = null) {
        foreach($columns as $column) {
            if($rows) {
                $formula = "=";
                foreach($rows as $ind => $val) {
                    $formula = $ind != 0 ? $formula."+" : $formula;
                    $formula = $formula.$column.$val;
                }
            } else {
                $formula = "=SUM(".$column.$start.":".$column.($row-1).")";
            }
            $exempt = range('A', 'D');
            if (!in_array($column, $exempt)) {
                $key2 = array_key_exists($column, $this->merge) ? $this->merge[$column] : $column;
                Excel::set_value($column.$row, $formula,['font' => ['bold' => true]], $column.$row.":".$key2.$row, 'right');
            }
        }
        Excel::set_border('A'.$row.':'.$this->lastColumn.$row, 'inside', 'thin');
        Excel::set_border('A'.$row.':'.$this->lastColumn.$row, 'outline', 'medium');
    }

    protected function set_footer($row) {
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
        Excel::set_border('X'.($row+2).':Y'.($row+2), 'bottom', 'thin');
        Excel::set_value('V'.($row+3), 'Date:', null, 'V'.($row+3).':W'.($row+3), 'right');
        Excel::set_border('X'.($row+3).':Y'.($row+3), 'bottom', 'thin');
        Excel::set_value('V'.($row+4), 'JEV No:', null, 'V'.($row+4).':W'.($row+4), 'right');
        Excel::set_border('X'.($row+4).':Y'.($row+4), 'bottom', 'thin');
        Excel::set_value('V'.($row+5), 'Date:', null, 'V'.($row+5).':W'.($row+5), 'right');

        Excel::set_border('A'.($row+1).':D'.($row+5), 'outline', 'medium');
        Excel::set_border('B'.($row+1).':J'.($row+5), 'outline', 'medium');
        Excel::set_border('K'.($row+1).':O'.($row+5), 'outline', 'medium');
        Excel::set_border('P'.($row+1).':U'.($row+5), 'outline', 'medium');
        Excel::set_border('V'.($row+1).':Z'.($row+5), 'outline', 'medium');
    }
}