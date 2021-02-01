{extends file="layout.tpl"}
{block name=content}
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
                <h4 class="m-0"><a href="?a=leave-request"></a></h4>
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
                <h4 class="m-0"><a href=""></a></h4>
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
                <h4 class="m-0"><a href=""></a></h4>
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
                <h4 class="m-0"><a href=""></a></h4>
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
										<th style="text-align: left;" colspan="6"><b><u>OFFICE:</u> <br>{$office[0].department_desc} {$credits}</b></th>
										<th style="text-align: left;" colspan="2"><b><u>FIRST DAY OF SERVICE:</u> <br>{$office[0].date_start|date_format:"F d, Y"}</b></th>
									</tr>
									<tr  style="text-align: center;">
										<td style=" width: 12%;" rowspan="2">PERIOD</td>
										<td style=" width: 10%;" rowspan="2">PARTICULARS</td>
										<td colspan="4">VACATION LEAVE</td>
										<td colspan="4">SICK LEAVE</td>
										<td style="word-wrap: break-word; width: 15%;" rowspan="2">DATE AND ACTION TAKEN FOR APPLICATION LEAVE</td>
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
									<tr align="center">	
										<td><b>{$credits.date_credited|date_format:"F d, Y"}</b></td>
										<td></td>
										<td>{$credits.vacation}</td>
										<td>-</td>
										<td>{$credits.vacation}</td>
										<td>-</td>
										<td>{$credits.sick}</td>
										<td>-</td>
										<td>{$credits.sick}</td>
										<td>-</td>
										<td>-</td>
									</tr>

									
									
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
										<td colspan="1" align="center"><b></b></td>
										<td colspan="1" align="center"><b></b></td>
										<td colspan="2" align="center"><b>OVERALL SL CREDITS<br></b></td>
										<td colspan="1" align="center"><b></b></td>
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
<div class="flex-fill">
  <div class="my-3 my-md-5">
    <div class="container">
      

      <div class="row">
        <div class="col-md-12">
          <div class="card">
            <div class="card-header card-header-icon" data-background-color="green">
              <h4 class="card-title">Leave Request Record</h4>
              <div class="card-options">
                <a href="" class="btn btn-primary" title="New Leave Request" rel="tooltip">Submit New</a>
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
					{foreach $records as $record}
                	<tr>
						<td>{$record.leave_id}</td>
						<td>{$record.lv_dateof_filing|date_format:"F d, Y"}</td>
						<td>{if $record.lv_status == '0'} Pending {else if $record.lv_status == '1'} For Approval {else if $record.lv_status == '2'} Approved {else} Disapproved {/if}</td>
						<td>{$record.lv_type}<div class="small text-muted">{$record.lv_type_others}</div></td>
						<td>{$record.lv_date_fr|date_format:"M. d, Y"} {if $record.lv_no_days > 1} - {$record.lv_date_to|date_format:"M. d, Y"} {/if}<div class="small text-muted">{$record.lv_no_days} {if $record.lv_no_days > 1}days{else}day{/if}</div></td>
						<td>{if $record.lv_status == '0'}<a href="" rel="tooltip" class="btn btn-outline-danger btn-sm" title="Delete Request"><i class="fe fe-trash"></i></a>{/if}</td>
                  	</tr>
					{/foreach}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
{/block}