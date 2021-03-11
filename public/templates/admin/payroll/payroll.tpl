<div class="card">
    <div class="card-body">
        <h3 class="card-title mb-3">New Payroll</h3>
        <form action="" method="POST">
            <input type="hidden" name="payroll[payroll_type]" value="1">
            <input type="hidden" name="payroll[emp_type]" value="1">
            <input type="hidden" name="action" value="download_payroll">
            <div class="row">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-prepend">
                        <span class="input-group-text">From</span>
                        </span>
                        <input type="date" name="payroll[date_from]" class="form-control text-right" id="date_from">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-prepend">
                        <span class="input-group-text">To</span>
                        </span>
                        <input type="date" name="payroll[date_to]" class="form-control text-right" id="date_to">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="float-right">
                        <button type="submit" class="btn btn-primary">
                            <span class="mr-2"><i class="fe fe-download"></i></span>Download
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="card">
    <div class="card-body">
        <input type="hidden" name="action" value="download_payroll">
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
<script>
    require (['datatables'], function () {
        $("#tbl-history").DataTable();
    })
</script>