{if $init}
<div class="card">
    <div class="card-body">
        <div class="text-right">
            <a class="btn btn-primary" href="inc/<?php echo 'trial_excel2.php?cam_id='.$user['CampusID'].'&month='.$payroll['month'].'&year='.$payroll['year'].'&emp_type='.$payroll['emp_type'].'&payroll='.$payroll['range'];?>">Download Payroll</a>
        </div>
        <div class="table-responsive">
            <table id="tbl-employees" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Employee Name</th>
                        <th>Position</th>
                        <th>Salary Grade</th>
                        <th>Step</th>
                        <th>Salary</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from = $employees item = 'employee'}
                        <tr>
                            <td>{$employee.employee_no}</td>
                            <td>{$employee.first_name} {$employee.last_name}</td>
                            <td>{$employee.position}</td>
                            <td>{$employee.sg}</td>
                            <td>{$employee.step}</td>
                            <td>Php {$employee.salary}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    require (['datatables'], function () {
        $("#tbl-employees").DataTable();
    })
</script>
{/if}