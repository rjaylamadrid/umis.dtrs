{extends file="layout.tpl"}
{block name=content}
{if $user.is_admin}
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header card-header-icon" data-background-color="rose">
						<i class="material-icons">inbox</i>
					</div>
					<div class="card-content">
						<div class="row">
						<div class="col-sm-6">
						<h4 class="card-title">Leave Requests</h4>
					</div>  
					<div class="col-sm-6">
						<select name="req_filter" required class="form-control" >
							<option value="0">Pending</option>
							<option value="1">For Recommendation</option>
							<option value="2">Approved</option>
							<option value="3">Disapproved</option>
						</select>
					</div>
				</div>
			</div>

			<form class="user" method="POST" action="">
				<input type="hidden" name="a" value="hr_view_leave_request">
				<div class="card-content material-datatables">
					<table class="table table-striped table-no-bordered table-hover" id="employees">
						<thead>
							<tr>   
								<th hidden>ID</th>
								<th>Name</th>
								<th>Office/Agency</th>
								<th>Position</th>
								<th>Type of Leave/Reason</th>
								<th>Inclusive Dates</th>
								<th>Days</th>
								<th style="text-align: center;">Action</th>
							</tr>
						</thead>
						<tbody>
							<tr>  
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td style="text-align: center;">-</td>
								<td class="td-center" width="14%">

								<a href="#" data-toggle="modal" data-target="#leaveRequestResponse_modal<?php echo $row1['emp_id']; ?>" class="btn btn-primary btn-sm"><i class="material-icons">reply</i></a>

								<a href="#" data-toggle="modal" data-target="#leaveDelete_modal<?php echo $row1['emp_id']; ?>" class="btn btn-warning btn-sm"><i class="material-icons">delete</i></a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
		</div>
	</div>
</div>
{else}
{* LEAVE RECORD CARD *}
	<div class="my-3 my-md-5">
		<div class="container">

		<div class="row credit-stats">
        <div class="col-sm-6 col-lg-3">
          <div class="card p-3">
            <div class="d-flex align-items-center">
              <span class="stamp stamp-md bg-blue mr-3">
                <i class="fe fe-file"></i>
              </span>
              <div>
                <h4 class="m-0"><a href="#">{$records|@count}</a></h4>
                <small class="text-muted">Leave Application</small>
              </div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-lg-3">
          <div class="card p-3">
            <div class="d-flex align-items-center">
              <span class="stamp stamp-md bg-green mr-3">
                <i class="fe fe-home"></i>
              </span>
              <div>
                <h4 class="m-0">{$balance[$balance|@count - 1]['vacation']|round:2}</h4>
                <small class="text-muted">Updated Vacation Leave Credits</small>
              </div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-lg-3">
          <div class="card p-3">
            <div class="d-flex align-items-center">
              <span class="stamp stamp-md bg-red mr-3">
                <i class="fe fe-heart"></i>
              </span>
              <div>
                <h4 class="m-0">{$balance[$balance|@count - 1]['sick']|round:2}</h4>
                <small class="text-muted">Updated Sick Leave Credits</small>
              </div>
            </div>
          </div>
        </div>
        <div class="col-sm-6 col-lg-3">
          <div class="card p-3">
            <div class="d-flex align-items-center">
              <span class="stamp stamp-md bg-yellow mr-3">
                <i class="fe fe-star"></i>
              </span>
              <div>
                <h4 class="m-0">{$balance[$balance|@count - 1]['vacation']|round:2 + $balance[$balance|@count - 1]['sick']|round:2}</h4>
                <small class="text-muted">Total Leave Credits</small>
              </div>
            </div>
          </div>
        </div>
      </div>
			<div class="row row-cards row-deck">
				<div class="col-12">
					<div class="card">
						<div class="table table-responsive">
							<table style="font-size: 13px;" class="table table-bordered table-hover card-table table-vcenter text-wrap datatable dataTable no-footer ">
								<thead class="thead-dark">
									<tr>
										<th style="text-align: left;" colspan="4"><b><u>NAME:</u> <br>{$user.last_name}, {$user.first_name} {$user.middle_name} </b></th>
										<th style="text-align: left;" colspan="6"><b><u>OFFICE:</u> <br>{$office[0].department_desc}</b></th>
										<th style="text-align: left;" colspan="2"><b><u>FIRST DAY OF SERVICE:</u> <br>{$office[0].date_start|date_format:"F d, Y"}</b></th>
									</tr>
									<tr  style="text-align: center;">
										<td style=" width: 12%;" rowspan="2">PERIOD</td>
										<td style=" width: 10%;" rowspan="2">PARTICULARS</td>
										<td colspan="4">VACATION LEAVE</td>
										<td colspan="4">SICK LEAVE</td>
										<td style="word-wrap: break-word; width: 15%;" rowspan="2">DATE AND ACTION TAKEN ON APPLICATION FOR LEAVE</td>
									</tr>
									<tr align="center">
										<td  style=" width: 5%;">Earned</td>
										<td  style=" width: 5%;">Abs/Und. W/P</td>
										<td  style=" width: 5%;">Balance</td>
										<td  style=" width: 5%;">Abs/Und. WOP</td>
										<td  style=" width: 5%;">Earned</td>
										<td  style=" width: 5%;">Abs/Und. W/P</td>
										<td  style=" width: 5%;">Balance</td>
										<td  style=" width: 5%;">Abs/Und. WOP</td>
									</tr>
								</thead>
								<tbody>
										{for $i=0 to sizeof($changes)-1}
											<tr align="center">
												<td onclick="javascript:show_collapse({$i}, '.')">
												<span class="head{$i} fe fe-chevron-down"></span>
												<b>{$balance[$i]['date']|date_format:"F d, Y"}</b></td>
												<td>Leave Credits</td>
												<td>{$balance[$i]['vacation']|round:3}</td>
												<td>-</td>
												<td>{$balance[$i]['vacation']|round:3}</td>
												<td>-</td>
												<td>{$balance[$i]['sick']|round:3}</td>
												<td>-</td>
												<td>{$balance[$i]['sick']|round:3}</td>
												<td>-</td>
												<td>-</td>
											</tr>
											<div class="card-body collapse">
											{for $j=0 to sizeof($changes[$i])}
												<tr align="center" class="collapse {$i}">
													<td><b>{$changes[$i][$j].period|date_format:"F d, Y"}</b></td>
													<td>{$changes[$i][$j].particulars}</td>
													<td>{if $changes[$i][$j].v_earned}{$changes[$i][$j].v_earned|round:3}{else}-{/if}</td>
													<td>{if $changes[$i][$j].v_awp}{$changes[$i][$j].v_awp|round:3}{else}-{/if}</td>
													<td>{if $changes[$i][$j].v_bal}{$changes[$i][$j].v_bal|round:3}{else}-{/if}</td>
													<td>{if $changes[$i][$j].v_awop}{$changes[$i][$j].v_awop|round:3}{else}-{/if}</td>
													<td>{if $changes[$i][$j].s_earned}{$changes[$i][$j].s_earned|round:3}{else}-{/if}</td>
													<td>{if $changes[$i][$j].s_awp}{$changes[$i][$j].s_awp|round:3}{else}-{/if}</td>
													<td>{if $changes[$i][$j].s_bal}{$changes[$i][$j].s_bal|round:3}{else}-{/if}</td>
													<td>{if $changes[$i][$j].s_awop}{$changes[$i][$j].s_awop|round:3}{else}-{/if}</td>
													<td>{if $changes[$i][$j].action}{$changes[$i][$j].action}{else}-{/if}</td>
												</tr>
											{/for}
											</div>
										{/for}
									<tr>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="2" align="center"><b>TOTAL VL CREDITS EARNED</b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="2" align="center"><b>TOTAL SL CREDITS EARNED</b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="1" align="center"><b></b></td>
									</tr>
									<tr>

										<td colspan="1" align="center"><b></b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="2" align="center"><b>OVERALL VL CREDITS<br></b></td>
										<td colspan="1" align="center"><b>{$balance[$balance|@count - 1]['vacation']|round:2}</b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="2" align="center"><b>OVERALL SL CREDITS<br></b></td>
										<td colspan="1" align="center"><b>{$balance[$balance|@count - 1]['sick']|round:2}</b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="1" align="center"><b></b></td>
										
									</tr>
								</tbody>
								<tfoot>

								</tfoot>
							</table>
							<br>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
{* LEAVE REQUESTS *}
<div class="flex-fill">
  <div class="my-3 my-md-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="card">
            <div class="card-header card-header-icon" data-background-color="green">
              <h4 class="card-title">Leave Request Record</h4>
              <div class="card-options">
                <a href="" class="btn btn-primary" data-toggle="modal" data-target="#leave-request-form" title="New Leave Request" rel="tooltip">Submit New</a>
				{* <a href="" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#leave-form"><i class="fe fe-plus"></i>Add Work Experience</a> *}
              </div>
            </div>
            
            <div class="table-responsive">
				<table class="table card-table table-vcenter text-nowrap datatable" id="requests">
					<thead class="text-warning">
						<tr>
							<th>No</th>
							<th>Date Filed</th>
							<th>Status</th>
							<th>Type of Leave</th>
							<th>Inclusive Dates</th>
							<th>Action</th>
						</tr>
					</thead>
				<tbody>
					{if $records}
					{foreach $records as $record}
                	<tr>
						<td>{$record.leave_id}</td>
						<td>{$record.lv_dateof_filing|date_format:"F d, Y"}</td>
						<td>{if $record.lv_status == '0'} Pending {else if $record.lv_status == '1'} For Approval {else if $record.lv_status == '2'} Approved {else} Disapproved {/if}<div class="small text-muted">Commutation: {$record.lv_commutation}</div></td>
						<td>{foreach $leave_types as $types} {if $types.id == $record.lv_type} {$types.leave_desc} <div class="small text-muted"> {$record.lv_type_others} </div> {/if} {/foreach} </td>
						<td>{if $record.lv_date_fr|date_format:"M" == "May"} {$record.lv_date_fr|date_format:"M d, Y"} {else} {$record.lv_date_fr|date_format:"M. d, Y"} {/if} {if $record.lv_no_days > 1} - {if $record.lv_date_to|date_format:"M" == "May"} {$record.lv_date_to|date_format:"M d, Y"} {else} {$record.lv_date_to|date_format:"M. d, Y"} {/if} {/if}<div class="small text-muted">{$record.lv_no_days} {if $record.lv_no_days > 1}days{else}day{/if}</div></td>
						<td>{if $record.lv_status == '0'}<a href onclick="javascript:return delete_leave({$record.leave_id})" rel="tooltip" class="btn btn-outline-danger btn-sm" title="Delete Leave"><i class="fe fe-trash"></i></a>{/if}</td>
                  	</tr>
					{/foreach}
					{else}
					<tr>
						<td>-</td>
						<td>-</td>
						<td>-</td>
						<td>-</td>
						<td>-</td>
						<td>-</td>
					</tr>
					{/if}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
{/if}
{* LEAVE REQUEST FORM *}
{include file="custom/leave_request_form.tpl"}

{/block}