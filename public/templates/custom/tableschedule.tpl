<div class="container" id= "blur">
    <div class="card">
    <table class="table card-table" >
<div class="text-center" >
<div class="spinner-border" role="status" style="width: 5rem; height: 5rem; position:absolute; left:42%;top:25%;" hidden>
<span class="visually-hidden"></span>
</div>
</div>
    
   
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
           
                {foreach from=$update_sched item=Schedule}
                    {if $Schedule.status == 1}
                    <tr style="color:rgb(0, 0, 0)">
                    <td class="font-weight-bold" style="font-size: 20px;">{$Schedule.weekday}</td>
                    <td style="text-align: center;"><div><strong>{$Schedule.am_in|date_format:"%l:%M %p"}</strong><div class="small text-muted">AM IN</div></div></td>
                    <td style="text-align: center;"><div><strong>{$Schedule.am_out|date_format:"%l:%M %p"}</strong><div class="small text-muted">AM OUT</div></div></td>
                    <td style="text-align: center;"><div><strong>{$Schedule.pm_in|date_format:"%l:%M %p"}</strong><div class="small text-muted">PM IN</div></div></td>
                    <td style="text-align: center;"><div><strong>{$Schedule.pm_out|date_format:"%l:%M %p"}</strong><div class="small text-muted">PM OUT</div></div></td>
                    </tr> 
                    {/if}
                {/foreach}
                </div>
                </tbody>
     </table>
    </div>
    </div>