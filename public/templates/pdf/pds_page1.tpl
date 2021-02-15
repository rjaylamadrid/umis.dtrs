<!DOCTYPE HTML>
<html lang="en">
<head>
<style>
    .div1 {
        top: 500;
        background-color: #ccc;
        width: 100%;
        height: 100%;
    }
    .content {
        font-size: 9px;
        font-weight: bold;
    }
</style>
</head>
<body>
    <div class="div1">
        <table class="table1 content">
            <tr>
                <td>{$employee->info.last_name}</td>
            </tr>
            <tr>
                <td>{$employee->info.first_name}</td>
            </tr>
        </table> 
    </div>  
</body>
</html>