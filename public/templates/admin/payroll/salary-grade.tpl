<div class="row">
    <div class="col-lg-3 mb-4">
        <div class="card">
            <div class="card-body">
                <form action='' method = 'POST' id="frmData">
                    <input type="hidden" name="action" value="show_salary">
                    <div class="form-group mb-1">
                        <label class="form-label">Title</label>
                        <select class="custom-select form-control" name="tranche" onchange="show_list('payroll')">
                            {foreach $sg->tranches as $tranche}
                                <option value="{$tranche.sg_id}" {if $tranche.sg_id == $sg->tranche.sg_id}selected{/if}>{$tranche.title}</option>
                            {/foreach}
                        </select>   
                    </div>
                    <div class="form-group mb-2">
                        <label class="form-label">Effectivity Date</label>
                        <input class="form-control" type="text" disabled value="{$sg->tranche.date|date_format:'%B %d, %Y'}">
                    </div>
                </form>
                <button class="btn btn-primary btn-block">Add Tranche</button>
            </div>
        </div>
    </div>
    <div class="col-lg-9">
        <div class="card">
            <div class="table-responsive">
                <table style=" font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-salary_grade">
                    <thead>
                        <tr>
                            <th>SG</th>
                            <th>Step 1</th>
                            <th>Step 2</th>
                            <th>Step 3</th>
                            <th>Step 4</th>
                            <th>Step 5</th>
                            <th>Step 6</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach $sg->salarygrades as $salary}
                        <tr>
                            <td>{$salary.salary_grade}</td>
                            <td>{$salary.steps[0]|number_format:2:".":","}</td>
                            <td>{if $salary.steps[1]}{$salary.steps[1]|number_format:2:".":","}{/if}</td>
                            <td>{if $salary.steps[2]}{$salary.steps[2]|number_format:2:".":","}{/if}</td>
                            <td>{if $salary.steps[3]}{$salary.steps[3]|number_format:2:".":","}{/if}</td>
                            <td>{if $salary.steps[4]}{$salary.steps[4]|number_format:2:".":","}{/if}</td>
                            <td>{if $salary.steps[5]}{$salary.steps[5]|number_format:2:".":","}{/if}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    require (['datatables'], function () {
        $("#tbl-salary_grade").DataTable();
    })
</script>