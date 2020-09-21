{if $view !="update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}/employees/employment-update/{$employee->id}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
            <tr class="row-header"><td colspan="2">Employment Information</td></tr>
            <tr><td>Status</td><td>Status</td></tr>
            <tr><td>Position</td><td><div>{$employee->position.position_desc}<div class="small text-muted">{$employee->info.date_start}</div></div></td></tr>
            <tr><td>Salary</td><td><div>150000<div class="small text-muted">Salary Grade 12 (Step 2)</div></div></td></tr>
            <tr><td>Department</td><td><div>College of Information Technology<div class="small text-muted">College Dean</div></div></td></tr>
        </table>
    </div>
    <div class="form-group" style="float: right;">
        <a href="" class="btn btn-success btn-md ml-2"><i class="fe fe-arrow-up-circle"></i> Promote</a>
    </div>
{else}
    <form action="" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
        <div class="form-group row btn-square">
            <div class="row">
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <label class="form-label">Employment Status</label>
                        <select class="form-control" name="emp_status1[etype_id]" required onchange="javascript:init_pos (this.value)">
                            <option selected disabled>Employment Status</option>
                            {foreach from=$emp_type item=type}
                            <option value="{$type.etype_id}">{$type.etype_desc}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Position</label>
                        <select class="form-control" name="emp_status[position_id]" id="positions">
                            <option selected disabled>Position</option>
                            {foreach from=$positions item=position}
                            <option value="{$position.no}">{$position.position_desc}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </form>
{/if}