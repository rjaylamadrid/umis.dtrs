{$schedules = $employee->schedule}
{if $view !="update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}/employees/employment-update/{$employee->id}/{$tab}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    {include file="custom/schedule.tpl"}
{else}
    <div style="min-height:530px">
        {if $message}
            <div class="alert card-alert {if $message.success}alert-success{else}alert-danger{/if} alert-dismissible">
                <button type="button" class="close" data-dismiss="alert"></button>
                <i class="fe {if $message.success}fe-check{else}fe-alert-triangle{/if} mr-2" aria-hidden="true"></i>{$message.message}
            </div><br/>
        {/if}
        <form action="/employees" method="POST">
            <div class="row pl-2">
                <input type="hidden" id="action" name="action" value="update_schedule">
                <input type="hidden" name="employee_id" value="{$employee->id}">
                <select class="form-control col-md-6" name="sched_code" onchange ="javascript:get_schedule(this.value)">
                    <option selected disabled>Schedule</option>
                    {foreach from = $presets item = preset}
                        <option value = "{$preset.sched_code}" {if $schedules[0].sched_code == $preset.sched_code}selected{/if}>{$preset.sched_day} ({$preset.sched_time})</option>
                    {/foreach}
                </select>
                <div class="col-md-6">
                    <div class="form-group" style="float: right;">
                        <a href="javascript:get_schedule('create')" class="btn btn-secondary">Create New Schedule</a>
                    </div>
                </div>
            </div>
            <div id="schedule">
            {include file="custom/schedule.tpl"}
            </div>
            <div class="col-md-12 mt-5">
                <div class="form-group" style="float: right;">
                    <button name="submit" value="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </div>
        </form>
    </div>
    {include file="admin/modal/create_schedule.tpl"}
{/if}
