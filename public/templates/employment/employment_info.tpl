{if $message}
    <div class="alert card-alert {if $message.success}alert-success{else}alert-danger{/if} alert-dismissible">
        <button type="button" class="close" data-dismiss="alert"></button>
        <i class="fe {if $message.success}fe-check{else}fe-alert-triangle{/if} mr-2" aria-hidden="true"></i>{$message.message}
    </div><br/>
{/if}
{if $view !="update"}
    {if $employee->info.date_end}
        <div class="alert card-alert alert-danger alert-dismissible">
            <button type="button" class="close" data-dismiss="alert"></button>
            <i class="fe fe-alert-triangle mr-2" aria-hidden="true"></i> Currently inactive employee!
        </div><br/>
    {else}
        <div class="form-group" style="float: right;">
            <a href="{$server}/employees/employment-update/{$employee->id}/employment_info" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
        </div>
    {/if}
    <div class="table-responsive">
        <table class="table card-table table-striped">
            <tr class="row-header"><td colspan="2">Employment Information</td></tr>
            <tr><td>Status</td><td>{$employee->position.emp_type}</td></tr>
            <tr><td>Position</td><td><div>{$employee->position.position_desc}<div class="small text-muted">{$employee->info.date_start} {if $employee->info.date_end} to {$employee->info.date_end} {else} to Present {/if}</div></div></td></tr>
            <tr><td>Salary</td><td><div>Php {$employee->position.salary}<div class="small text-muted">
            {if $employee->position.salary_grade}Salary Grade {$employee->position.salary_grade} - Step {$employee->position.step}{/if}</div></div></td></tr>
            <tr><td>Department</td><td><div>{$employee->employment_info.department}<div class="small text-muted">{$employee->employment_info.designation}</div></div></td></tr>
        </table>
    </div>
    <div class="form-group" style="float: right;">
        <a href="#" data-toggle="modal" data-target="#promote-employee-modal" class="btn btn-success btn-md ml-2"><i class="fe fe-plus"></i> New Employment Info</a>
    </div>
    {include file="admin/modal/promote_employee.tpl"}
{else}
    <div class="form-group form-inline">
        <label class="h4" style="display: inline-block;">Current Employment Information</label>
    </div>
    <form action="/employees" method="POST" accept-charset="UTF-8">
        <input type="hidden" name="action" value="update_employment_info">
        <input type="hidden" id="campus" value="{$employee->info.campus_id}">
        <input type="hidden" name="employee_id" value="{$employee->id}">
        <input type="hidden" name="type" value="current">
        <input type="hidden" name="admin_id" value="{$user.employee_id}">
        <div class="form-group row btn-square">
            <div class="row p-5">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Employment Status</label>
                        <select class="form-control" name="emp_status[etype_id]" required onchange="javascript:init_pos (this.value)" id="emp_type">
                            <option selected disabled>Employment Status</option>
                            {foreach from=$emp_type item=type}
                            <option value="{$type.id}" {if $type.id == $employee->info.etype_id}selected{/if}>{$type.type_desc}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="form-label">Position</label>
                        <select class="form-control" name="emp_status[position_id]" id="positions" onchange="javascript:get_salary()">
                            <option selected disabled>Position</option>
                            {foreach from=$positions item=position}
                            <option value="{$position.no}" {if $position.no == $employee->info.position_id}selected{/if}>{$position.position_desc}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Effectivity Date</label>
                        <input type="date" class="form-control" name="emp_status[date_start]" value="{$employee->info.date_start}" id="date-start" onchange="javascript:get_salary()" required>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Salary</label>
                        <input type="text" class="form-control" name="" value="Php {$employee->position.salary}" disabled id="salary">
                    </div>
                </div>
                    <div class="col-md-12">
                    <div class="form-group">
                        <label class="form-label">Department</label>
                        <select class="form-control" name="emp_status[department_id]" required>
                            <option selected disabled>Department</option>
                            {foreach from=$departments item=dept}
                            <option value="{$dept.no}" {if $dept.no == $employee->info.department_id}selected{/if}>{$dept.department_desc}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <label class="form-label">Designation</label>
                        <select class="form-control" name="emp_status[privilege]">
                            <option selected disabled>Designation</option>
                            {foreach from=$designations item=designation}
                            <option value="{$designation.priv_level}" {if $designation.priv_level == $employee->info.privilege}selected{/if}>{$designation.priv_desc}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <span style="float: right;">
                        <input type="submit" class="btn btn-primary" value="Submit">
                    </span>
                </div>
            </div>
        </div>
    </form>
{/if}