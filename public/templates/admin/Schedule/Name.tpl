{if !empty($P_Name)}
    <h3 class="modal-title" id ="f_name">{$Name}</h3><h6 style="margin-top:10px;" id = "pre_sched">{$P_Name.sched_day} ({$P_Name.sched_time})</h6>
 {else}
         <h3 class="modal-title" id ="f_name">{$Name}</h3><h6 style="margin-top:10px;" id = "pre_sched"></h6>
{/if}

