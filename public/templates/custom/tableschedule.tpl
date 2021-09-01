<div class="container">
    <div class="card">
    <table class="table card-table" >
                <tbody>   
                {foreach from=$selectschedule item=Schedule}
                <tr>
                <td class="font-weight-bold" style="font-size: 20px;">{$Schedule.weekday}</td>
                <td style="text-align: center;"><div><strong>{$Schedule.am_in|date_format:"%l:%M %p"}</strong><div class="small text-muted">AM IN</div></div></td>
                <td style="text-align: center;"><div><strong>{$Schedule.am_out|date_format:"%l:%M %p"}</strong><div class="small text-muted">AM OUT</div></div></td>
                <td style="text-align: center;"><div><strong>{$Schedule.pm_in|date_format:"%l:%M %p"}</strong><div class="small text-muted">PM IN</div></div></td>
                <td style="text-align: center;"><div><strong>{$Schedule.pm_out|date_format:"%l:%M %p"}</strong><div class="small text-muted">PM OUT</div></div></td>
                </tr> 
                 {/foreach}
                </div>
                </tbody>
     </table>
    </div>
    </div>