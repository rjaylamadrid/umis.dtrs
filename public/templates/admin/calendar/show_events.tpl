{if $events}
<thead>
    <tr><td style="text-align: center;font-weight: bold" colspan="2">{date_format($event_date, 'F d, Y')}</td></tr>
</thead>

<tbody>
    {foreach from=$events item=event}
        <tr><td class="border-right-0"><div>{$event.event_name}</div><div class="small text-muted">{$event.event_start} - {$event.event_end}</div></td>
        <td class="border-left-0"><a class="float-right"><i class="fe fe-edit-3"></i></a></td></tr>
        <tr><td colspan="2" class="border-0"><a data-toggle="modal" data-target="#add-event-modal" class="float-right"><i class="fe fe-plus">Add Event</i></a></td></tr>
    {/foreach}
</tbody>
{else}
<thead>
    <tr><td style="text-align: center;font-weight: bold" colspan="2">{date_format($event_date, 'F d, Y')}</td></tr>
</thead>
<tbody>
        <tr><td>No events found.</td></tr>
        <tr><td colspan="2" class="border-0"><a data-toggle="modal" data-target="#add-event-modal" class="float-right"><i class="fe fe-plus">Add Event</i></a></td></tr>
</tbody>
{/if}

<div class="modal fade margin-top-70" id="add-event-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
  <div class="modal-dialog" id="raw-data" role="document">
    <div class="modal-content">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Add new event {date_format($event_date,'F d, Y')}</h3>
        </div>
        <div class="card-body">
          <form action="/calendar" method="post" id="frm-event">
          	<input type="hidden" name="action" value="add_event">
            <div class="form-group">
              <label>Title</label>
              <input type="text" class="form-control" name="Event[EventName]" placeholder="Title Name" required>
            </div>
            <div class="row">
              <div class="form-group col-md-6 pl-0">
                <label>Date</label>
                <input type="date" class="form-control" name="Event[EventDate]" value="" required readonly>
              </div>
              <div class="form-group col-md-6 pl-0">
                <label>DTR code</label>
                <select class="form-control" name="Event[dtc_no]" required>
                  <option value="" selected disabled>Code</option>
                  <?php
                    $dtc = exec_query("SELECT * FROM tbl_daily_time_code", $master);
                    foreach($dtc as $value){
                      echo "<option value='".$value['dtc_no']."'>".$value['dtc_code']."</option>";
                    }
                  ?>
                </select>
              </div>
            </div>
            <div class="row">
              <div class="form-group col-md-6 pl-0">
                <label>Time Start</label>
                <input type="text" class="form-control" placeholder="00:00" name="Event[EventTimeStart]" required autocomplete="off" maxlength="8">
              </div>
              <div class="form-group col-md-6 pr-0">
                <label>Time End</label>
                <input type="text" class="form-control" placeholder="00:00" name="Event[EventTimeEnd]" required autocomplete="off" maxlength="8">
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
</div>