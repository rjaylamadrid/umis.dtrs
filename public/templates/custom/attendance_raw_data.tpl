<div class="modal-content">
	<div class="card">
		<div class="card-header">
			<h3 class="card-title">Raw Data</h3>
			<div class="card-options">
				<a href="#" class="btn btn-secondary btn-sm ml-2" data-dismiss="modal">Close</a>
			</div>
		</div>
		<div class="card-body">
			<div class="table-responsive">
			    <table class="table card-table table-striped">
			        <thead>
			            <tr>
			                <th>No</th>
			                <th>Time</th>
			                <th>Type</th>
			                <th>Campus</th>
			            </tr>
			        </thead>
			        <tbody>
                    {if $rawdata}
                        {assign var=type value=['', 'IN', 'OUT', 'OT-IN', 'OT-OUT']}
                        {assign var=no value=1}
                        {foreach $rawdata as $raw}
                        <tr>
                            <td>{$no}</td>
                            <td>{$raw.log_time}</td>
                            <td class="text-nowrap">{$type[$raw.log_type]}</td>
                            <td class="w-1">{$raw.cam_name}</td>
                        </tr>
                        {$no = $no + 1}
                        {/foreach}
				    {else}
				    	<tr><td colspan="4">No raw data available</td></tr>
				    {/if}
			    </table>
			</div>
		</div>
	</div>
</div>