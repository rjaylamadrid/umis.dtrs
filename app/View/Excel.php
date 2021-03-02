<?php
namespace View;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Worksheet\PageSetup;

class Excel {
    static $spreadsheet;
    static $sheet;

    public static function __callStatic($name, $arguments) {
        echo "__callStatic";
        return call_user_func($name, $args);
    }

    public static function set($orientation = 'LANDSCAPE', $size = "LEGAL") {
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
