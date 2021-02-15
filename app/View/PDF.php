<?php
namespace View;

use TCPDI;

class PDF {
    private static $pdf;

    public static function __callStatic($name, $arguments) {
        echo "__callStatic";
        return call_user_func($name, $args);
    }

    public static function newPDF() {
        self::set ();
        return self::$pdf;
    }

    public static function preview ($args) {
        if (!self::$pdf) self::set ();
        self::setHeaderFooter();
        foreach ($args as $arg) {
            self::$pdf->addPage();
            self::$pdf->writeHTML($arg['content'], true, false, true, false, '');
        }
        self::$pdf->Output('example_006.pdf', 'I');
    }

    public static function set () {
        self::$pdf = new TCPDI(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
        self::$pdf->SetFont('dejavusanscondensed', '', 8);
    }

    public function export ($template) {
        self::setHeaderFooter();
        self::$pdf->setSourceFile($template);
    }

    public static function setHeaderFooter($header = false, $footer = false) {
        self::$pdf->SetPrintHeader($header);
        self::$pdf->SetPrintFooter($footer);
    }

    public static function setText($x, $y, $h=0, $text) {
        self::$pdf->setXY($x, $y);
        $text = $text ? $text : 'N/A';
        self::$pdf->Write($h, $text);
    }

    public function check($x, $y) {
        self::$pdf->SetFont('zapfdingbats','', 7);
        self::setText($x, $y, 0, '3');

        self::$pdf->SetFont('helvetica','', 9);
    }
}