<div id ="selectalert" class="container col-lg-10 mt-2 text-center alert alert-danger fade show" style="display: none;" >
  <strong>Select a preset schedules!!</strong> 
  </div>
<select id="Preset_Select" class="form-control col-md-6 m-3" name="sched_code" onchange ="javascript:get_preset_schedules(this.value)">
<option selected disabled><strong>Select Preset Schedule</strong></option>
{foreach from=$preset item=Select}
    <option id = "{$Select.sched_code}" value ="{$Select.sched_code}">{$Select.sched_day} ({$Select.sched_time})</option>
{/foreach} 
 </select>
