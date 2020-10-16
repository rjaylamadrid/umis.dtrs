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
<div class="row">
	<div class="col-md-7">
		<div class="table-responsive">
		  <table class="table table-bordered" id="tbl-calendar">
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
							{if $count == 1} <tr><td class="first {$i}" id="{$i}">{$i}</td>
							{else if $count == 7 || $count == 14 || $count == 21 || $count == 28 || $count == 35}  <td onclick="javascript:get_events ({$i})" id="{$i}"><a href="#">{$i}</a></td></tr>
							{else} <td onclick="javascript:get_events ({$i})" id="{$i}"><a href="#">{$i}</a></td> {/if}
							{$count=$count+1}
						{/for}
					{* <?php
						$count = array_search(date_format($date,'l'), $days);
						for($i=0;$i<$count;$i++){
							echo "<td></td>";
						}
						$count++;
						for($i=1;$i<=$lastday;$i++){
							if($count == 1){
								echo '<tr><td class="first '.$i.'" onclick="show_calendar(\''.$i.'\')" id="'.$i.'">'.$i.'</td>';
							}elseif ($count == 7) {
								echo '<td onclick="show_calendar(\''.$i.'\')" id="'.$i.'">'.$i.'</td></tr>';
								$count=0;
							}else{
								echo '<td onclick="show_calendar(\''.$i.'\')" id="'.$i.'">'.$i.'</td>';
							}
							$count++;
						}
					?> *}
				</tbody>
			</table>
		</div>
	</div>
	<div class="col-md-5">
		<div class="table-responsive">
		  <table class="table table-bordered" id="tbl-event">
				<thead>
					<tr><td style="text-align: center;font-weight: bold" colspan="2">{date_format($date, 'F d, Y')}</td></tr>
				</thead>
				<tbody>
					{if $date != ''}
						<tr><td class="border-right-0"><div>Event Name</div><div class="small text-muted">9:00 - 5:00</div></td>
						<td class="border-left-0"><a class="float-right"><i class="fe fe-edit-3"></i></a></td></tr>
						<tr><td colspan="2" class="border-0"><a data-toggle="modal" data-target="#add-event-modal" class="float-right"><i class="fe fe-plus">Add Event</i></a></td></tr>
					{else}
						<tr><td>No events found.</td></tr>
					{/if}
				</tbody>	
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
          <form action="" method="post" id="frm-event">
          	<input type="hidden" name="action" value="add">
            <div class="form-group">
              <label>Title</label>
              <input type="text" class="form-control" name="Event[EventName]" placeholder="Title Name" required>
            </div>
            <div class="row">
              <div class="form-group col-md-6 pl-0">
                <label>Date</label>
                <input type="date" class="form-control" name="Event[EventDate]" value="<?php echo $now;?>" required readonly>
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
	{* <div class="col-md-5">
		<?php if($frm['id']){?>
		<div class="table-responsive">
		  <table class="table table-bordered" id="tbl-event">
				<thead>
					<tr><td style="text-align: center;font-weight: bold" colspan="2"><?php echo $now;?></td></tr>
				</thead>
				<tbody>
					<?php
            $events = exec_query("SELECT * FROM tbl_event WHERE campus_id = '".$_SESSION['admin']['CampusID']."' AND EventDate = '".$now."'",$master);
            if($events){
            	foreach($events as $value){
            		echo '<tr><td class="border-right-0"><div>'.$value['EventName'].'</div><div class="small text-muted">'.$value['EventTimeStart'].'-'.$value['EventTimeEnd'].'</div></td><td class="border-left-0"><a class="float-right" onclick="javascript:edit_event(\''.$value['no'].'\')"><i class="fe fe-edit-3"></i></a></td></tr>';
	            }
            }else{
            	echo '<tr><td>No events found.</td></tr>';
            }
          ?>
          <tr><td colspan="2" class="border-0"><a data-toggle="modal" data-target="#add-event-modal" class="float-right"><i class="fe fe-plus"></i></a></td></tr>
				</tbody>	
			</table>
		</div>
	<?php } ?>
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
          <form action="" method="post" id="frm-event">
          	<input type="hidden" name="action" value="add">
            <div class="form-group">
              <label>Title</label>
              <input type="text" class="form-control" name="Event[EventName]" placeholder="Title Name" required>
            </div>
            <div class="row">
              <div class="form-group col-md-6 pl-0">
                <label>Date</label>
                <input type="date" class="form-control" name="Event[EventDate]" value="<?php echo $now;?>" required readonly>
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
</div> *}