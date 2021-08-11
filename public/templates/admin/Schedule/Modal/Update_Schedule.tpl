
<div class="table-responsive" id ="Update">
<div class="container">
<div class="card">
<table class="table card-table" >
            <tbody>   
                
            {foreach from=$Employee_Sched item=em_sched}
                
                {if $em_sched.Status == 1}
                    <tr>
                    <td class="font-weight-bold" style="font-size: 20px;">{$em_sched.weekday}</td>
                    <td style="text-align: center;"><div><strong>{$em_sched.am_in|date_format:"%l:%M %p"}</strong><div class="small text-muted">AM IN</div></div></td>
                    <td style="text-align: center;"><div><strong>{$em_sched.am_out|date_format:"%l:%M %p"}</strong><div class="small text-muted">AM OUT</div></div></td>
                    <td style="text-align: center;"><div><strong>{$em_sched.pm_in|date_format:"%l:%M %p"}</strong><div class="small text-muted">PM IN</div></div></td>
                    <td style="text-align: center;"><div><strong>{$em_sched.pm_out|date_format:"%l:%M %p"}</strong><div class="small text-muted">PM OUT</div></div></td>
                   </tr> 
                {/if}
             {/foreach}


            {foreach from=$schedules item=Schedule}
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
</div>

