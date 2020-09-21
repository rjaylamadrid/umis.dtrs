<div class="table-responsive">
    <table class="table card-table table-striped">
        <tr class="row-header"><td colspan="5">Schedule</td>
        {foreach from = $schedules item = schedule}
            <tr>
                <td>{$schedule.weekday}</td>
                <td><div>{$schedule.am_in|date_format:"%l:%M %p"}<div class="small text-muted">AM IN</div></div></td>
                <td><div>{$schedule.am_out|date_format:"%l:%M %p"}<div class="small text-muted">AM OUT</div></div></td>
                <td><div>{$schedule.pm_in|date_format:"%l:%M %p"}<div class="small text-muted">PM IN</div></div></td>
                <td><div>{$schedule.pm_out|date_format:"%l:%M %p"}<div class="small text-muted">PM OUT</div></div></td>
            </tr>
        {/foreach}
    </table>
</div>