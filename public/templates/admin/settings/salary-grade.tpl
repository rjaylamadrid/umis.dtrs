<style type="text/css">
    #salary-grade th {
        text-align: center;
    }

    .sgrade td {
        text-align: right;
    }
</style>

<div class="row" id="salary">
    <div class="col-lg-12">
        <label class="form-label" style="float: right;">* Click on table row to update salary grade</label>
        <div class="table-responsive">
            <table id="salary-grade" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer">
                <thead>
                    <tr>
                        <th>SG</th>
                        <th>Step 1</th>
                        <th>Step 2</th>
                        <th>Step 3</th>
                        <th>Step 4</th>
                        <th>Step 5</th>
                        <th>Step 6</th>
                        <th>Step 7</th>
                        <th>Step 8</th>
                    </tr>
                </thead>
                <tbody>
                {foreach $var as $salary}
                    <tr class="sgrade" onclick="edit_salary({$salary.no})">
                        <td>{$salary.no}</td>
                        {foreach $salary.step_increment as $step}
                        <td>{$step}</td>
                        {/foreach}
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>

    </div>
</div>