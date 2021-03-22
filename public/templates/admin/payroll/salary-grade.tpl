<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body py-1">
                <form action='' method = 'POST' id="frmData">
                    <input type="hidden" name="action" value="show_salary">
                    <div class="d-flex">
                        <div class="form-group col-md-4 mb-0">
                            <label class="form-label mb-1">Title</label>
                            <select class="custom-select form-control" name="tranche" onchange="show_list('payroll')">
                                {foreach $sg->tranches as $tranche}
                                    <option value="{$tranche.sg_id}" {if $tranche.sg_id == $sg->tranche.sg_id}selected{/if}>{$tranche.title}</option>
                                {/foreach}
                            </select>   
                        </div>
                        <div class="col-md-8 d-flex mt-6">
                            <label class="form-label">Effectivity Date:</label>
                            <p class="pl-2"> {$sg->tranche.date|date_format:'%B %d, %Y'} </p>
                        </div>
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