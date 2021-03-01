<?php
namespace View;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
// use Xlsx;

class Excel {
    static $spreadsheet;
    static $excel;
    static $writer;

    public static function __callStatic($name, $arguments) {
        echo "__callStatic";
        return call_user_func($name, $args);
    }

    protected static function set() {
        self::$spreadsheet = new Spreadsheet();
        self::$excel = self::$spreadsheet->getActiveSheet();
    }

    public static function generate($title) {
        self::set();
        self::$excel->setCellValue('A1', 'Hello World !');

        // $objWriter = IOFactory::createWriter(self::$spreadsheet, 'Xlsx');
        $objWriter = new Xlsx(self::$spreadsheet);
        $objWriter->save($title);
    }
}
