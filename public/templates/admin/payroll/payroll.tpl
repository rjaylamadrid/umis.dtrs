<div class="row">
    <div class="col-lg-3 mb-4">
        <div class="card">
            <div class="card-body">
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
    <div class="col-lg-9" id="settings_tab">
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table style="font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-history">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Payroll No</th>
                                <th>Employee</th>
                                <th>Period</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    require (['datatables'], function () {
        $("#tbl-history").DataTable();
    })
</script>