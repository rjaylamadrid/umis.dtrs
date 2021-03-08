<div class="card">
    <div class="card-body">
        <div class="float-right">
            <a href="#" class="btn btn-primary">
                <span class="mr-3"><i class="fe fe-download"></i></span>Download
            </a>
        </div>
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