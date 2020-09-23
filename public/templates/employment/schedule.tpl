{$schedules = $employee->schedule}
{if $view !="update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}/employees/employment-update/{$employee->id}/{$tab}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    {include file="custom/schedule.tpl"}
{else}
    <div style="min-height:530px">
        <form action="" method="POST">
            <div class="row pl-2">
                <input type="hidden" id="action" name="action" value="update">
                <select class="form-control col-md-6" name="sched_code" onchange ="javascript:get_schedule(this.value)">
                    <option selected disabled>Schedule</option>
                    {foreach from = $presets item = preset}
                        <option value = "{$preset.sched_code}" {if $employee->info.sched_code == $preset.sched_code}selected{/if}>{$preset.sched_day} ({$preset.sched_time})</option>
                    {/foreach}
                </select>
                <div class="col-md-6">
                    <div class="form-group" style="float: right;">
                        <a href="javascript:get_schedule('create')" class="btn btn-secondary">Create new schedule</a>
                    </div>
                </div>
            </div>
            <div id="schedule">
            {include file="custom/schedule.tpl"}
            </div>
            <div class="col-md-12 mt-5">
                <div class="form-group" style="float: right;">
                    <a href="javascript:get_schedule('create')" class="btn btn-primary">Save Changes</a>
                </div>
            </div>
        </form>
    </div>
    {include file="admin/modal/create_schedule.tpl"}
{/if}
