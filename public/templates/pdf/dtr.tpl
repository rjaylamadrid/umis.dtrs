<!DOCTYPE HTML>
<html lang="en">
<head>
<style>
    .content {
        font-size: 9px;
    }
    .table {
        table-layout: auto;
        border-collapse: collapse;
    }
    .border td {
        border: 1pt solid black;
    }
    .border th {
        border: 1pt solid black;
    }
    .table td, th {
        white-space: normal;
        text-align: center;
        height: 10px;
    }
    .no-border td {
        border-bottom: none;
    }
</style>
</head>
<body>
    <table>
        <tr>
            <td>{include file="pdf/dtr_template.tpl"}</td>
            <td>{include file="pdf/dtr_template.tpl"}</td>
        </tr>
    </table>   
</body>
</html>