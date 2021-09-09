<div class="modal-content">
	<div class="card" style="margin-bottom: 0px;">
		<div class="card-header">
			<h3 class="card-title">Modify Log Data</h3>
		</div>
		<style>
			.update-log  td {
				vertical-align: middle;
			}
		</style>
		<form action="" method="POST" id="formLog">
			<input type="hidden" name="action" value="save_log">
			<input type="hidden" name="period" value="{$period}">
			<input type="hidden" name="no" value="{$attn.id}">
			<input type="hidden" name="employee_id" value="{$employee_id}" id="id">
			<input type="hidden" name="date" value="{$date}">
			<div class="card-body">
				<div class="table-responsive">
				    <table class="table mb-0 update-log">
				        <tbody>
				        	<tr>
				        		<td>AM IN</td>
				                <td>
									<input list="attnd1" type="text" name="attnd[]" class="attnd form-control" placeholder="00:00" autocomplete="off" maxlength="8" {if $attn.am_in && $attn.am_in != ':'}value="{$attn.am_in}"{/if}>
									<datalist id="attnd1">
										{foreach $rawdata as $raw}
											<option value="{$raw.log_time|date_format:'%I:%M %p'}">
										{/foreach}
										{foreach $codes as $code}
										<option value="{$code.dtr_code}">
										{/foreach}
									</datalist>
								</td>
				                <td>AM OUT</td>
				                <td>
									<input list="attnd2" type="text" name="attnd[]" class="attnd form-control" placeholder="00:00" autocomplete="off" maxlength="8" {if $attn.am_out && $attn.am_out != ':'}value="{$attn.am_out}"{/if}>
									<datalist id="attnd2">
										{foreach $rawdata as $raw}
											<option value="{$raw.log_time|date_format:'%I:%M %p'}">
										{/foreach}
										{foreach $codes as $code}
										<option value="{$code.dtr_code}">
										{/foreach}
									</datalist>
								</td>
				            </tr>
				            <tr>
				        		<td>PM IN</td>
				                <td>
									<input list="attnd3" type="text" name="attnd[]" class="attnd form-control" placeholder="00:00" autocomplete="off" maxlength="8" {if $attn.pm_in && $attn.pm_in != ':'}value="{$attn.pm_in}"{/if}>
									<datalist id="attnd3">
										{foreach $rawdata as $raw}
											<option value="{$raw.log_time|date_format:'%I:%M %p'}">
										{/foreach}
										{foreach $codes as $code}
										<option value="{$code.dtr_code}">
										{/foreach}
									</datalist>
								</td>
				                <td>PM OUT</td>
				                <td>
									<input list="attnd4" type="text" name="attnd[]" class="attnd form-control" placeholder="00:00" autocomplete="off" maxlength="8"  {if $attn.pm_out && $attn.pm_out != ':'}value="{$attn.pm_out}"{/if}>
									<datalist id="attnd4">
										{foreach $rawdata as $raw}
											<option value="{$raw.log_time|date_format:'%I:%M %p'}">
										{/foreach}
										{foreach $codes as $code}
										<option value="{$code.dtr_code}">
										{/foreach}
									</datalist>
								</td>
				            </tr>
				            <tr>
				        		<td>OT IN</td>
				                <td>
									<input list="attnd5" type="text" name="attnd[]" class="attnd form-control" placeholder="00:00" autocomplete="off" maxlength="8"  {if $attn.ot_in && $attn.ot_in != ':'}value="{$attn.ot_in}"{/if}>
									<datalist id="attnd5">
										{foreach $rawdata as $raw}
											<option value="{$raw.log_time|date_format:'%I:%M %p'}">
										{/foreach}
									</datalist>
								</td>
				                <td>OT OUT</td>
				                <td>
									<input list="attnd6" type="text" name="attnd[]" class="attnd form-control" placeholder="00:00" autocomplete="off" maxlength="8"  {if $attn.ot_out && $attn.ot_out != ':'}value="{$attn.ot_out}"{/if}>
									<datalist id="attnd6">
										{foreach $rawdata as $raw}
											<option value="{$raw.log_time|date_format:'%I:%M %p'}">
										{/foreach}
									</datalist>
								</td>
				            </tr>
				        </tbody>
				    </table>
				    <hr class="mt-0">
				    <div class="form-group">
				    	<select class="form-control custom-select">
                            <option selected>Raw Log Data</option>
                            {if $rawdata}
                            {assign var=type value=['', 'IN', 'OUT', 'OT-IN', 'OT-OUT']}
                            {foreach $rawdata as $raw}
                            <option value="" disabled>{$raw.log_time} - [{$type[$raw.log_type]}] - {$raw.campus} Campus</option>
                            {/foreach}
                            {/if}
		                </select>
                  	</div>
					<input type = "hidden" name = "curr_status" value = "{$attn.status}">
					{$stat = [1,3,12,34,32,14]}
					{if $attn.status|in_array:$stat}
						{$v_stat = [3,34,32]}
						<div class="form-group">
							<label class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" name="ot-paid" id="ot_paid" value="checked" {if $attn.status|in_array:$v_stat} checked = "True" {/if}> <span class="custom-control-label">Validate OVERTIME as payable</span>
							</label>
						</div>
					{/if}
					{$stat = [2,4,12,34,32,14]}
					{if $attn.status|in_array:$stat}
						{$v_stat = [4,34,14]}
						<div class="form-group">
							<label class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" name="otd-paid" id="otd_paid" value="checked" {if $attn.status|in_array:$v_stat} checked = "True" {/if}> <span class="custom-control-label">Validate DAY as payable</span>
							</label>
						</div>
					{/if}
				</div>
			</div>
			<div class="card-footer text-right">
			    <div class="d-flex">
			        <a href="javascript:void(0)" class="btn btn-link" data-dismiss="modal">Cancel</a>
			        <a href="javascript:modify_log()" class="btn btn-primary ml-auto">Update Log</a>
			    </div>
			</div>
		</form>
	</div>
</div>