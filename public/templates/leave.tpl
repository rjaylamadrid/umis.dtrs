{extends file="layout.tpl"}
{block name=content}

<div class="flex-fill">

	<div class="my-3 my-md-5">
		<div class="container">

			<div class="row row-cards row-deck">
				<div class="col-12">
					{* <div class="card row">
						<div class="form-group form-inline row">
							<label class="form-label col-12">Select Month/Year</label>

							<select class="form-control ml-5 col-3">
								<option disabled>Select Month</option>
							</select>
							<select class="col-xl-1 col-lg-1 col-md-1 col-sm-2 form-control form-control-user ml-2">
								<option disabled>Select Year</option>
							</select>
							<a href="?a=leave-request">
								<input type="submit" name="allLeaveSummary" class="btn btn-square btn-secondary col-12 ml-5 mr-5"  style="width: 45%; vertical-align: middle; align-self: center;" value="View Summary of my Leave Record" title="Shows User's Leave Record">
							</a>
						</div>
					</div> *}
                    <pre>
                    {print_r($employee)}
                    </pre>
					<div class="card">
						<div class="table table-responsive">
							<table style="font-size: 13px;" class="table table-bordered table-hover card-table table-vcenter text-wrap datatable dataTable no-footer ">
								<thead class="thead-dark">
									<tr>
										<th style="text-align: left;" colspan="4"><b><u>NAME:</u> <br>{$user.first_name}, {$user.middle_name} {$user.last_name}</b></th>
										<th style="text-align: left;" colspan="6"><b><u>OFFICE:</u> <br>{$employee->info.department_id}</b></th>
										<th style="text-align: left;" colspan="2"><b><u>FIRST DAY OF SERVICE:</u> asdasd<br></b></th>
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
										<td><b></b></td>
										<td></td>
										<td>-</td>
										<td>-</td>
										<td></td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
										<td></td>
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

							{* <form action="?a=postCredit&id=<?php //echo $row1['EmployeeID'].'&month='.$month.'&year='.$year;?>" method="POST">
								<input type="hidden" name="OfficialNewSLBalance" value="<?php //echo $OfficialNewSLBalance; ?>">
								<div class="row shadow-lg">
									<div class="col-4"></div>
									<?php// $confirm = 'onclick = "return confirm('.'\''.'Attention!\nThere is no data for this month, if you think this was a mistake, please contact/report bug to the System Administrator/Maintenance.\n\n\nClick OK to continue printing...'.'\''.')"' ?>
									<a href="?a=printCredit&id=<?php //echo $row1['EmployeeID'].'&month='.$month.'&year='.$year;?>" class="btn btn-pill btn-primary  col-md-2 m-3" <?php //echo $nodata = $noData == 1 ? $confirm : '' ?> >Print</a>
									
							</form> *}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade margin-top-70" id="profile-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
		<div class="modal-dialog" id="profile" role="document" style="max-width: 600px;">
		</div>
	</div>
{/block}