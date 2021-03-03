<form action="/payroll" method="POST" class="card">
    <div class="card-body">
        <input type="hidden" name="action" value="download_payroll">
        <div class="row">
            <div class="col-md-4">
                <div>
                    <h3 class="card-title mb-3">Payroll Details</h3>
                    <div class="form-group">
                        <label class="form-label">Payroll Type</label>
                        <select name="payroll[type]" class="form-control custom-select">
                            <option value="1" selected="">Regular Payroll</option>
                            <option value="2">Differential</option>
                            <option value="3">Special Payroll</option> 
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Employee Type</label>
                        <select name="payroll[emp_type]" class="form-control custom-select">
                            <option value="1">Regular Employees</option>
                            <option value="2">Casual Employees</option>
                            <option value="3">Job-Order Employees</option>
                            <option value="4">COS Instructor Employees</option>
                            <option value="5">Project-Based Employees</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Set Period</label>
                        <div class="row">
                            <div class="col-md-6">
                                <select name="payroll[month]" class="form-control custom-select">
                                <option value="" selected="" disabled="">Month</option>
                                    {include file="custom/select_month.tpl"}
                                </select>
                            </div>
                            <div class="col-md-6">
                                <input name="payroll[year]" type="number" class="form-control" placeholder="Year" value="{date('Y')}">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <select name="payroll[range]" class="form-control custom-select">
                            <option value="0">1-15</option>
                            <option value="1">16-31</option>
                            <option value="2">1-31</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Download Payroll</button>
                </div>
            </div>
            <div class="col-md-8">
                <h3 class="card-title mb-3">History</h3>
                <div class="table-responsive">
                    <table style=" font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-history">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Payroll No</th>
                                <th>Employee</th>
                                <th>Period</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</form>
<script>
    require (['datatables'], function () {
        $("#tbl-history").DataTable();
    })
</script>