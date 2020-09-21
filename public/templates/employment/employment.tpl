{if $view !="update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.type}/employees/update/{$employee->id}{else}/update{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
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
        <a href="" class="btn btn-primary btn-md ml-2"><i class="fe fe-arrow-up-circle"></i> Promote</a>
    </div>
{else}
{/if}