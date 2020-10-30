<style>
.dtr-data th, td {
    text-align: center;
}
</style>
<div class="table-responsive dtr">
    <table class="order-table table table-bordered text-gray-900 dtr-data" id="dataTable" width="100%" cellspacing="0">
        <thead>
            <tr>
            <th rowspan="2">DAY</th>
            <th colspan="2">MORNING</th>
            <th colspan="2">AFTERNOON</th>
            <th colspan="2">OVERTIME</th>
            <th colspan="3">TOTAL</th>
            {if $user.is_admin}<th></th>{/if}
            </tr>
            <tr>
            <td>IN</td>
            <td>OUT</td>
            <td>IN</td>
            <td>OUT</td>
            <td>IN</td>
            <td>OUT</td>
            <td>Hours</td>
            <td>Tardy</td>
            <td>Remarks</td>
            {if $user.is_admin}<td>
                <div class="item-action dropdown">
                    <a href="javascript:void(0)" data-toggle="dropdown" class="icon" aria-expanded="false">
                        <i class="fe fe-settings"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-181px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                        <a href="javascript:set_presets('{$period.emp_type}', '{$employee_id}')" class="dropdown-item">
                            <i class="dropdown-icon fe fe-upload"></i> Set Default Logs
                        </a>
                    </div>
                </div>
            </td>{/if}
            </tr>
        </thead>
        <tbody>
            {$attendance.ut = 0}
            {$attendance.total = 0}
            {if $attendance}
            {foreach $daterange as $date}
                {if $month != $date|date_format:"%m"}
                    <tr>
                        <td colspan="11" style="background-color: #00c4ff1a"><b>{$date|date_format:"%B %Y"|upper}</b></td>
                    </tr>
                    {$month = $date|date_format:"%m"}
                {/if}
                {if $attendance['attn'][$date|date_format: "%Y-%m-%d"]}
                    {$attn = $attendance['attn'][$date|date_format: "%Y-%m-%d"]}
                    <tr class="" {if $attn.auth == "false"} style="background-color: #ff00001a" {/if}>
                        <td><b>{$attn.date|date_format:"%d"}</b></td>
                        <td>{$attn.am_in}</td>
                        <td>{$attn.am_out}</td>
                        <td>{$attn.pm_in}</td>
                        <td>{$attn.pm_out}</td>
                        <td>{$attn.ot_in}</td>
                        <td>{$attn.ot_out}</td>
                        <td>{$attn.total_hours}</td>
                        <td>{$attn.late + $attn.undertime}</td>
                        {$attendance.ut = $attendance.ut + ($attn.late + $attn.undertime)}
                        {$attendance.total = $attendance.total + $attn.total_hours}
                        <td></td>
                        {if $user.is_admin}
                        <td><a href="javascript:view_raw_data('{$employee_id}', '{$attn.date|date_format:"%Y-%m-%d"}');" class="icon" title="View Raw Data"><i class="fe fe-eye"></i></a><a href="javascript:update_log('{$attn.id}', '{$employee_id}', '{$attn.date|date_format:"%Y-%m-%d"}');" class="icon" title="Edit Log"><i class="fe fe-edit"></i></a></td>
                        {/if}
                    </tr>
                {else}
                    {if $date|date_format:"w" == 0 || $date|date_format:"w" == 6}
                        <tr>
                            <td><b>{$date|date_format:"%d"}</b></td>
                            <td colspan="9" style="text-align: center; letter-spacing: 60px;">{$date|date_format:"%A"|upper}</td>
                            {if $user.is_admin}
                            <td><a href="javascript:view_raw_data('{$employee_id}', '{$date|date_format:"%Y-%m-%d"}');" class="icon" title="View Raw Data"><i class="fe fe-eye"></i></a><a href="javascript:update_log('0', '{$employee_id}', '{$date|date_format:"%Y-%m-%d"}');" class="icon" title="Edit Log"><i class="fe fe-edit"></i></a></td>
                            {/if}    
                        </tr>
                            {else}
                        <tr>
                            <td><b>{$date|date_format:"%d"}</b></td>
                            <td> : </td>
                            <td> : </td>
                            <td> : </td>
                            <td> : </td>
                            <td>   </td>
                            <td>   </td>
                            <td> 0.00  </td>
                            <td> 0  </td>
                            <td></td>
                            {if $user.is_admin}
                            <td><a href="javascript:view_raw_data('{$employee_id}', '{$date|date_format:"%Y-%m-%d"}');" class="icon" title="View Raw Data"><i class="fe fe-eye"></i></a><a href="javascript:update_log('0', '{$employee_id}', '{$date|date_format:"%Y-%m-%d"}');" class="icon" title="Edit Log"><i class="fe fe-edit"></i></a></td>
                            {/if}
                        </tr>
                    {/if}
                {/if}
            {/foreach}
            {/if}
      </tbody>
    </table>
  </div>
  <div class="card-footer" style="display: inline-block;">
    <form target="_blank" action="/attendance/print" method="POST">
        <input type="hidden" name="employee_id" value="{$period.id}">
        <input type="hidden" name="period" value={$period.period}>
        <input type="hidden" name="date_from" value={$period.date_from}>
        <input type="hidden" name="date_to" value={$period.date_to}>
        {if $user.is_admin}
            {if $period.period == '4'}
            <label class="custom-switch p-0">
                <input type="checkbox" name="per_month" checked class="custom-switch-input">
                <span class="custom-switch-indicator"></span>
                <span class="custom-switch-description">Print DTR per month</span>
            </label>
            {else}
                <input type ="hidden" name="per_month" value="on">
            {/if}
            <div class="text-right">
                <button type="submit" class="btn btn-primary">Print DTR</button>
            </div>
        {/if}
    </form>
    <p>{$attendance.total} Total rendered hours (in hours) {$attendance.ut} Tardy (in minutes)</p>
  </div>