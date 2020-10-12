<?php
namespace View;

use TCPDF;

class PDF {
    private static $pdf;

    public static function __callStatic($name, $arguments) {
        echo "__callStatic";
        return call_user_func($name, $args);
    }

    public static function preview ($args) {
        if (!self::$pdf) self::set ();
        self::$pdf->SetPrintHeader(false);
        self::$pdf->addPage();
        self::$pdf->writeHTML($args['content'], true, false, true, false, '');
        self::$pdf->Output('example_006.pdf', 'I');
    }

    protected static function set () {
        self::$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
        self::$pdf->SetFont('dejavusanscondensed', '', 8);
    }
}