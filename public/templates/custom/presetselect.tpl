<select id="Preset_Select" class="form-control col-md-11 m-3" name="sched_code" onchange ="javascript:get_preset(this.value)">
{foreach from=$preset item=Select}
    {if $Select.sched_code == $code}
        <option selected disabled id = "{$Select.sched_code}" value ="{$Select.sched_code}">{$Select.sched_day} ({$Select.sched_time})</option>
    {else}
        <option id = "{$Select.sched_code}" value ="{$Select.sched_code}">{$Select.sched_day} ({$Select.sched_time})</option>
    {/if}
{/foreach} 
</select>