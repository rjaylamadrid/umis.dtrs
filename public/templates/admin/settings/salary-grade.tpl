<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <form action='' method = 'POST' id="frmData">
                    <input type="hidden" name="action" value="show_salary">
                    <div class="form-group form-inline m-0">
                        <select class="custom-select" name="tranche" onchange="show_list()">
                            {foreach $tranches as $tranche}
                                <option value="{$tranche.sg_id}" {if $tranche.sg_id == $active.sg_id}selected{/if}>{$tranche.title}</option>
                            {/foreach}
                        </select>   
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="row row-cards row-deck">
    <div class="col-12">
        <div class="card">
            <div class="table-responsive">
                <table style=" font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-positions">
                    <thead>
                        <tr>
                            <th>SG</th>
                            <th>Step 1</th>
                            <th>Step 2</th>
                            <th>Step 3</th>
                            <th>Step 4</th>
                            <th>Step 5</th>
                            <th>Step 6</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach $salaries as $salary}
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