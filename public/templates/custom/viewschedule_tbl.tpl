<div class="container">
<div class="card">
<table class="table card-table">
  
            <tbody>  
       {foreach from=$Sched item=sched}
     
        {if $sched.Status == 1}
            <tr>
            <td class="font-weight-bold" style="font-size: 20px; align-text:left">{$sched.weekday}</td>
            <td style="text-align: center;"><div><strong>{$sched.am_in|date_format:"%l:%M %p"}</strong><div class="small text-muted">AM IN</div></div></td>
            <td style="text-align: center;"><div><strong>{$sched.am_out|date_format:"%l:%M %p"}</strong><div class="small text-muted">AM OUT</div></div></td>
            <td style="text-align: center;"><div><strong>{$sched.pm_in|date_format:"%l:%M %p"}</strong><div class="small text-muted">PM IN</div></div></td>
            <td style="text-align: center;"><div><strong>{$sched.pm_out|date_format:"%l:%M %p"}</strong><div class="small text-muted">PM OUT</div></div></td>
           </tr> 
        {/if}
       {/foreach}
            </tbody>
 </table>
 </div>
 </div>    

