<style>
	#tbl-calendar tr td{
		padding-left: 0px;
		padding-right: 0px;
		width:30px;
		text-align: center;
	}
	#tbl-event tbody tr td:first-child{
		padding-top: 2px;
		padding-bottom: 2px;
	}
</style>
<div id="cover-spin" style="display: none;">
  <div class="page-content" style="margin-top: 28rem;">
      <div class="container text-center">
          <h1 class="h2 mb-3">Saving data...</h1>
          <p class="h4 text-muted font-weight-normal mb-7">Please wait, this might take a few minutes.</p>
      </div>
  </div>
</div>
<div class="row">
	<div class="col-md-7">
		<div class="table-responsive">
		  <table class="table table-calendar table-bordered " id="tbl-calendar">
				<thead>
					<tr><td colspan="7" style="text-align: center; font-weight: bold">Calendar of Events {if $date != ''} ({date_format($date,'F Y')}) {/if}</td></tr>
					<tr>
						{foreach $days as $day}
							<td>{$day|substr:0:3}</td>
						{/foreach}
					</tr>
				</thead>
				<tbody>
					<tr>
						{for $i=0 to $count-1}
							<td></td>
						{/for}
						{$count=$count+1}
						{for $i=1 to $lastday}
							{if $count == 1} <tr><td class="date " id="{$i}">{$i}</td>
							{else if $count == 7 || $count == 14 || $count == 21 || $count == 28 || $count == 35}  <td class="date " onclick="javascript:get_events ({$i},{date_format($date,'m')},{date_format($date,'Y')})" id="{$i}">{$i}</td></tr>
							{else} <td class="date " onclick="javascript:get_events ({$i},{date_format($date,'m')},{date_format($date,'Y')})" id="{$i}">{$i}</td> {/if}
							{$count=$count+1}
						{/for}
				</tbody>
			</table>
		</div>
	</div>

	<div class="col-md-5">
  <div id="cover-spin" style="display: none; position:absolute;" class="spinner1"></div>
		<div class="table-responsive">
		  <table class="table table-bordered" id="tbl-event">
      </table>
      </div>
    </div>
  </div>

<div class="modal fade margin-top-70" id="add-event-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
  <div class="modal-dialog" id="raw-data" role="document">
    <div class="modal-content">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Add new event</h3>
        </div>
        <div class="card-body">
          <form action="/calendar" method="post" id="frm-event">
          	<input type="hidden" name="action" value="add_event">
            <input type="hidden" name="Event[campus_id]" value="4">
            <div class="form-group">
              <label>Title</label>
              <input type="text" class="form-control" name="Event[event_name]" placeholder="Title Name" required>
            </div>
            <div class="row">
              <div class="form-group col-md-6 pl-0">
                <label>Date</label>
                <input type="date" class="form-control" id="event_date" name="Event[event_date]" value="" required readonly>
              </div>
              <div class="form-group col-md-6 pl-0">
                <label>DTR code</label>
                <select class="form-control" name="Event[dtr_code_id]" required>
                  <option value="" selected disabled>Code</option>
                  {foreach from=$dtr_code item=dtc key=key}
                    <option value="{$dtc@iteration}">{$dtc} ({$key})</option>
                  {/foreach}
                </select>
              </div>
            </div>
            <div class="row">
              <div class="form-group col-md-6 pl-0">
                <label>Time Start</label>
                <input type="time" class="form-control" name="Event[event_start]" required autocomplete="off" maxlength="8">
              </div>
              <div class="form-group col-md-6 pr-0">
                <label>Time End</label>
                <input type="time" class="form-control" name="Event[event_end]" required autocomplete="off" maxlength="8">
              </div>
            </div>
            <div class="form-group">
              <span style="float: right;">
                <input type="submit" name="submit" class="btn btn-primary" value ="Submit" onclick="$('#cover-spin').show(0)">
                <a href="#" class="btn btn-secondary" data-dismiss="modal" id="close">Cancel</a>
              </span>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

{* <div class="modal fade margin-top-70" id="edit-event-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
  <div class="modal-dialog" id="raw-data" role="document">
    <div class="modal-content">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Edit Event {print_r($events)}</h3>
        </div>
        <div class="card-body">
          <form action="/calendar" method="post" id="frm-event">
          	<input type="hidden" name="action" value="add_event">
            <input type="hidden" name="Event[campus_id]" value="4">
            <div class="form-group">
              <label>Title</label>
              <input type="text" class="form-control" name="Event[event_name]" placeholder="Title Name" required>
            </div>
            <div class="row">
              <div class="form-group col-md-6 pl-0">
                <label>Date</label>
                <input type="date" class="form-control" id="event_date_edit" name="Event[event_date]" value="" required readonly>
              </div>
              <div class="form-group col-md-6 pl-0">
                <label>DTR code</label>
                <select class="form-control" name="Event[dtr_code_id]" required>
                  <option value="" selected disabled>Code</option>
                  {foreach from=$dtr_code item=dtc key=key}
                    <option value="{$dtc@iteration}">{$dtc} ({$key})</option>
                  {/foreach}
                </select>
              </div>
            </div>
            <div class="row">
              <div class="form-group col-md-6 pl-0">
                <label>Time Start</label>
                <input type="time" class="form-control" name="Event[event_start]" required autocomplete="off" maxlength="8">
              </div>
              <div class="form-group col-md-6 pr-0">
                <label>Time End</label>
                <input type="time" class="form-control" name="Event[event_end]" required autocomplete="off" maxlength="8">
              </div>
            </div>
            <div class="form-group">
              <span style="float: right;">
                <input type="submit" name="submit" class="btn btn-primary" value ="Submit">
                <a href="#" class="btn btn-secondary" data-dismiss="modal" id="close">Cancel</a>
              </span>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div> *}