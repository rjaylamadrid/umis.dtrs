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
		<form action="" method="POST" id="frmLog">
			<input type="hidden" name="action" value="save">
			<input type="hidden" name="period" value="{$period}">
			<input type="hidden" name="no" value="{$logid}">
			<div class="card-body">
				<div class="table-responsive">
				    <table class="table mb-0 update-log">
				        <tbody>
				        	<tr>
				        		<td>AM IN</td>
				                <td>
									<select name="am_in">
										<option></option>
									</select>
								</td>
				                <td>AM OUT</td>
				                <td>{$attn.am_out}</td>
				            </tr>
				            <tr>
				        		<td>PM IN</td>
				                <td>{$attn.pm_in}</td>
				                <td>PM OUT</td>
				                <td>{$attn.pm_out}</td>
				            </tr>
				            <tr>
				        		<td>OT IN</td>
				                <td>{$attn.ot_in}</td>
				                <td>OT OUT</td>
				                <td>{$attn.ot_out}</td>
				            </tr>
				        </tbody>
				    </table>
				    <hr class="mt-0">
				    <div class="form-group">
				    	<select name="dtr[year]" class="form-control custom-select">
                            <option selected>Raw Log Data</option>
                            {if $rawdata}
                            {assign var=type value=['', 'IN', 'OUT', 'OT-IN', 'OT-OUT']}
                            {foreach $rawdata as $raw}
                            <option value="" disabled>{$raw.log_time} - [{$type[$raw.log_type]}] - {$raw.cam_name} Campus</option>
                            {/foreach}
                            {/if}
		                </select>
                  </div>
				</div>
			</div>
			<div class="card-footer text-right">
			    <div class="d-flex">
			        <a href="javascript:void(0)" class="btn btn-link" data-dismiss="modal">Cancel</a>
			        <a href="javascript:modify_log(\''.$emp_id.'\', \''.$date.'\')" class="btn btn-primary ml-auto">Update Log</a>
			    </div>
			</div>
		</form>

		<script type="text/javascript">
			require(['input-mask']);

			function modify_log (id, period) {
				var form = $('#frmLog').serialize()+"&id="+id+"&date="+period;
	            $.ajax({
			    	url:"query.php?type=dtr&action=save",
			    	data: form,
			    	cache:false,
			    	success:function(data){
			        	$("#update-log-modal").modal('hide');
			        	init_dtr('<?php echo $emp_id; ?>');
			    	}
				});
       		}
		</script>
	</div>
</div>