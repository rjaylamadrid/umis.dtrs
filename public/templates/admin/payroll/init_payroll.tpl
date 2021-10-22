{if $init}
<div class="card">
    <div>
                    <div class="form-group mb-1">
                        <label class="form-label">Payroll Type</label>
                        <select name="payroll[type]" class="form-control custom-select" id="payroll_type">
                            <option value="1" selected="">Regular Payroll</option>
                            <option value="2">Differential</option>
                            <option value="3">Special Payroll</option> 
                        </select>
                    </div>
                    <div class="form-group mb-2">
                        <label class="form-label">Employee Status</label>
                        <select name="payroll[emp_type]" class="form-control custom-select" id="emp_type">
                            <option value="1">Regular Employees</option>
                            <option value="2">Casual Employees</option>
                            <option value="3">Job-Order Employees</option>
                            <option value="4">COS Instructor Employees</option>
                            <option value="5">Project-Based Employees</option>
                        </select>
                    </div>
                </div>
    <div class="card-body">
        <div class="text-right">
            <form action="" method="POST">
                <input type="hidden" name="action" value="download_payroll">
                <button class="btn btn-primary">Download Payroll</button>
            </form>
        </div>
        <div class="table-responsive">
            <table id="tbl-employees" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer">
                <thead>
                    <tr>
                        <th>ID </th>
                        <th>Employee Name </th>
                        <th>Position</th>
                        <th>SG</th>
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
                            <td>{$employee.salary}</td>
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

<form action="" method="POST">
    <div class="row">
        <div class="col-md-6">
            <div class= "card">
                <div class = "card-body">
                    <div class="form-group mb-1">
                        <label class="form-label">Payroll Type</label>
                        <select name="payroll[type]" class="form-control custom-select" id="payroll_type">
                            <option value="1" selected="">Regular Payroll</option>
                            <option value="2">Differential</option>
                            <option value="3">Special Payroll</option> 
                        </select>
                    </div>
                    <div class="form-group mb-2">
                        <label class="form-label">Employee Status</label>
                        <select name="payroll[emp_type]" class="form-control custom-select" id="emp_type">
                            <option value="1">Regular Employees</option>
                            <option value="2">Casual Employees</option>
                            <option value="3">Job-Order Employees</option>
                            <option value="4">COS Instructor Employees</option>
                            <option value="5">Project-Based Employees</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <div class="col-md-12">
                        <div class="input-group">
                            <span class="input-group-prepend">
                            <span class="input-group-text">From</span>
                            </span>
                            <input type="date" name="payroll[date_from]" class="form-control text-right" id="date_from">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="input-group">
                            <span class="input-group-prepend">
                            <span class="input-group-text">To</span>
                            </span>
                            <input type="date" name="payroll[date_to]" class="form-control text-right" id="date_to">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="float-right">
                            <button type="submit" class="btn btn-primary">
                                {if $tab == 'payroll'}Download{else}Initialize{/if}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>