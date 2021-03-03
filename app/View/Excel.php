<?php
namespace View;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Worksheet\PageSetup;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Style\Border;

class Excel {
    static $spreadsheet;
    static $sheet;

    public static function __callStatic($name, $arguments) {
        echo "__callStatic";
        return call_user_func($name, $args);
    }

    public static function set_style($style) {
        self::$spreadsheet->getDefaultStyle()->applyFromArray($style);
    }

    public static function column_width($columns) {
        foreach($columns as $key => $width) {
            self::$sheet->getColumnDimension($key)->setWidth($width);
        }
    }

    public static function row_height($rows) {
        foreach($rows as $key => $height) {
            self::$sheet->getRowDimension($key)->setRowHeight($height);
        }
    }

    public static function set_border($cell , $position, $type) {
        $types = ['thin' => Border::BORDER_THIN, 'medium' => Border::BORDER_MEDIUM, 'thick' => Border::BORDER_THICK];
        
        $style = ['borders' => 
                    [$position => 
                        ['borderStyle' => $types[$type]]
                    ]];
        self::$sheet->getStyle($cell)->applyFromArray($style);
    }

    public static function set_value($cell, $value, $style = null, $mergeCells = null, $horizontal = 'left', $vertical = 'center', $wrap = false) {
        self::$sheet->setCellValue($cell, $value);
        $horizontals = ['left' => Alignment::HORIZONTAL_LEFT, 'center' => Alignment::HORIZONTAL_CENTER, 'right' => Alignment::HORIZONTAL_RIGHT];
        $verticals = ['top' => Alignment::VERTICAL_TOP, 'center' => Alignment::VERTICAL_CENTER, 'bottom' => Alignment::VERTICAL_BOTTOM];
        
        $style['alignment'] = ['horizontal' => $horizontals[$horizontal], 'vertical' => $verticals[$vertical], 'wrapText' => $wrap];

        self::$sheet->getStyle($cell)->applyFromArray($style);
        if ($mergeCells) {
            self::$sheet->mergeCells($mergeCells);
        }
    }

    public static function set() {
        self::$spreadsheet = new Spreadsheet();
        self::$sheet = self::$spreadsheet->getActiveSheet();

        self::$sheet->getPageSetup()
            ->setOrientation(PageSetup::ORIENTATION_LANDSCAPE)
            ->setPaperSize(PageSetup::PAPERSIZE_LEGAL)
            ->setFitToPage(false)->setScale(110);

        self::$sheet->getPageMargins()
            ->setLeft(0.25)
            ->setRight(1)
            ->setTop(0.5)
            ->setBottom(0.5);
    }

    public static function download($title) {
        $writer = IOFactory::createWriter(self::$spreadsheet, 'Xlsx');
        $writer->save('reports/'.$title);

        header('Content-Type: application/vnd.openxmlformats-officedocument.spreedsheetml.sheet');
        header('Content-Disposition: attachment; filename= "'.$title.'"');
        header('Cache-Control: max-age=0');

        $writer->save('php://output');
    }
}
