{extends file="layout.tpl"}
{block name=content}
<div id="cover-spin" style="display: none;"></div>
<div class="my-3 my-md-5">
    <div class="container">
        <div class="dimmer active" id="loading_spinner" style="display: none;">
            <div class="loader"></div>
            <div class="dimmer-content"></div>
        </div>
        {if !$posted}
        <div class="card">
            <div id="sync" class="card-body">
                <input type="hidden" id="month" value="{$period.month}">
                <input type="hidden" id="year" value="{$period.year}">
                <div class="text-center">
                    <p>Attendance not yet posted or uploaded. <b>PERIOD: {$period.month}-{$period.year}</b></p>
                    <button onclick="sync_now()" class="btn btn-outline-primary">Update Attendance Now</button>
                    <div id="sync-result">
                    </div>
                </div>
            </div>
        </div>
        {/if}
        <div class="row row-cards" id="attendance-content">
            <input type="hidden" id="month" value="{$period.month}">
            <input type="hidden" id="year" value="{$period.year}">
            <input type="hidden" id="period" value="{$period.period}">
            <input type="hidden" id="emp_type" value="{$period.emp_type}">
            <input type="hidden" id="emp_active" value="">
            <div class="col-md-6 col-lg-3">
      	        <div class="card">
                    <div class="card-status bg-green"></div>
      	        	<div class="card-header">
                        <h3 class="card-title"><b>LIST</b> of Employees</h3>
                    </div>
      	        	<div id="employee-list" class="selectgroup selectgroup-vertical w-100 o-auto" style="max-height: 60rem;">
                        <label class="selectgroup-item">
                            <input type="radio" name="employee_id" value="0" class="selectgroup-input" checked="" onclick="init_dtr (0);">
                            <span class="selectgroup-button" style="text-align: left;">Blank DTR</span>
                        </label>
                        {foreach $employees as $employee}
      	        	  	<label class="selectgroup-item">
      	        	  	    <input type="radio" name="employee_id" value="{$employee.employee_id}" class="selectgroup-input" onclick="init_dtr (this.value);">
      	        	  	    <span class="selectgroup-button" style="text-align: left;"><b>{$employee.last_name|upper}, {$employee.first_name|upper}</b></span>
                        </label>
                        {/foreach}
      	        	</div>
      	    	</div>
   	    	</div>
            <div class="col-md-6 col-lg-9">
                <div class="card">
                    <div class="card-body">
                        <div class="form-group form-inline">
                            <label style="display: inline-block;">Filter employee:&nbsp;</label>
                            <select id="emp_type" class="form-control custom-select" onchange="load_employees (this.value);">
                                <option value="">All employees</option>
                                <option value="0">All regular/casual</option>
                                {* <?php 
                                    $emp_type = exec_query("SELECT * FROM tbl_employee_type",$master);
                                    foreach ($emp_type as $value) {
                                    $selected = $req['emp_type']==$value['etype_id']?'Selected':'';
                                    echo "<option value='".$value['etype_id']."'".$selected.">".$value['etype_desc']."</option>";
                                    }
                                ?> *}
                            </select>
                            <div style="float: right;">
                                <div class="item-action dropdown form-control">
                                    <a href="javascript:void(0)" data-toggle="dropdown" class="icon" aria-expanded="false">
                                        <i class="fe fe-settings"></i> Options
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-181px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                                        <a href="javascript:new_period()" class="dropdown-item">
                                            <i class="dropdown-icon fe fe-calendar"></i> New period 
                                        </a>
                                        <a href="javascript:void(0)" class="dropdown-item">
                                            <i class="dropdown-icon fe fe-refresh-cw"></i> Update attendance 
                                        </a>
                                        <a href="javascript:add_event()" class="dropdown-item">
                                            <i class="dropdown-icon fe fe-bookmark"></i> Add event 
                                        </a>
                                        <a href="#" data-toggle="modal" data-target="#event-modal" class="dropdown-item">
                                            <i class="dropdown-icon fe fe-bookmark"></i> Events 
                                        </a>
                                        <div class="dropdown-divider"></div>
                                        <a id="generate_pdf" href="" target="_blank" class="dropdown-item">
                                            <i class="dropdown-icon fe fe-printer"></i> Print all DTR
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card" id="dtr" style="top: -20px;">
                </div>
   	        </div>
   	    </div>
        
   	</div>
</div>

{include file="admin/modal/attendance_period.tpl"}

<div class="modal fade margin-top-70" id="raw-data-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
  <div class="modal-dialog" id="raw-data" role="document">

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
                    <form action="" method="post" id="event">
                        <div class="form-group">
                            <label>Title</label>
                            <input type="text" class="form-control" name="Event[EventName]" placeholder="Title Name" required>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6 pl-0">
                                <label>Date</label>
                                <input type="date" class="form-control" name="Event[EventDate]" min ="<?php echo $date_start;?>" max ="<?php echo $date_end;?>" value="<?php echo $date_start;?>" required>
                            </div>
                            <div class="form-group col-md-6 pl-0">
                                <label>DTR code</label>
                                <select class="form-control" name="Event[dtc_no]" required>
                                <option value="" selected disabled>Code</option>
                                {* <?php
                                    $dtc = exec_query("SELECT * FROM tbl_daily_time_code", $master);
                                    foreach($dtc as $value){
                                    echo "<option value='".$value['dtc_no']."'>".$value['dtc_code']."</option>";
                                    }
                                ?> *}
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
                                <input type="button" class="btn btn-primary" onclick="javascript:save_event('<?php echo $_SESSION['user']['CampusID'];?>')" value ="Submit">
                                <a href="#" class="btn btn-secondary" data-dismiss="modal">Cancel</a>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade margin-top-70" id="event-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" role="document" style="max-width: 800px">
        <div class="modal-content">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Events</h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive dtr">
                        <table class="order-table table table-bordered text-gray-900" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                <th>Event Name</th>
                                <th>Date</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                {* <?php
                                $events = exec_query("SELECT * FROM tbl_event WHERE campus_id = '".$_SESSION['user']['CampusID']."' AND (EventDate between '".$date_start."' AND '".$date_end."') ORDER BY EventDate ASC",$master);
                                foreach($events as $value){
                                    echo "<tr><td>".$value['EventName']."</td><td>".$value['EventDate']."</td><td>".$value['EventTimeStart']."</td><td>".$value['EventTimeEnd']."</td><td></td></tr>";
                                }
                                ?> *}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade margin-top-70" id="update-log-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" id="update-log" role="document" style="max-width: 600px;">

    </div>
</div>

<script type="text/javascript">
    {if !$period}
    require(['bootstrap', 'jquery'], function () {
        $(document).ready(function () {
        $("#generate-dtr-modal").modal('show');
        });
    });
    {/if}

    function new_period () {
        $("#generate-dtr-modal").modal('show');
    }

    function view_raw_data (id, date) {
        var period = document.getElementById("month").value + '-' + document.getElementById("year").value;
	    $.ajax({
            url:"/attendance",
            type:'POST',
	    	data: {
                'action': 'raw_data', 'id':id, 'period':period, 'date':date
            },
	    	success:function(data) {
	        	$("#raw-data").html(data);
	        	$("#raw-data-modal").modal('show');
	    	}
		});
    }

    function update_log (id, emp_id, date) {
        var month = document.getElementById("month").value
        var year = document.getElementById("year").value;
        $.ajax({
            url:"/attendance",
            type:"POST",
            data:{
                'action': 'update_log', 'id':id, 'emp_id':emp_id, 'month':month, 'year': year, 'date':date
            },
            success:function(data){
                $("#update-log").html(data);
                $("#update-log-modal").modal('show');
            }
        });
    }

    function sync_now () {
        
    }
</script>
{/block}