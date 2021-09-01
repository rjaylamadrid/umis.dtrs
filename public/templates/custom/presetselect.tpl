<select id="Preset_Select" class="form-control col-md-11 m-3" name="sched_code" onchange ="javascript:get_preset(this.value)">
<option selected disabled><strong>Select Preset Schedule</strong></option>
{foreach from=$preset item=Select}
    <option id = "{$Select.sched_code}" value ="{$Select.sched_code}">{$Select.sched_day} ({$Select.sched_time})</option>
{/foreach} 
</select>