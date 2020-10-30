{extends file="layout.tpl"}
{block name=content}
<br /><br /><br />
<div class="page-content">
    <div class="container text-center">
        <div class="display-1 text-muted mb-5"><i class="fe fe-alert-triangle"></i> 404</div>
        <h1 class="h2 mb-3">This page is under construction.</h1>
        <p class="h4 text-muted font-weight-normal mb-7">We are sorry but this page is currently not available.</p>
        <a class="btn btn-primary" href="javascript:history.back()">
        <i class="fe fe-arrow-left mr-2"></i>Go back
        </a>
    </div>
</div>
{* {if $view}
<div class="my-3 my-md-5">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 col-lg-8">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">Leave Request Details</div>
                    </div>
                    <div class="card-body">
                        <table class="table" style="margin-top: -1.5rem;">
                            <thead>
                                <tr>
                                    <th style="width: 30%;"></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tr>
                                <td colspan="2"><h4 class="mb-0">EMPLOYEE DETAILS</h4></td>
                            </tr>
                            <tr>
                                <td>Employee Name</td>
                                <td><b>{$request.EmpName}</b></td>
                            </tr>
                            <tr>
                                <td>Department/Office</td>
                                <td>{$request.lv_office}</td>
                            </tr>
                            <tr>
                                <td>Position/Designation</td>
                                <td>{$request.lv_office}</td>
                            </tr>
                            <tr>
                                <td colspan="2"><h4 class="mb-0">LEAVE REQUEST DETAILS</h4></td>
                            </tr>
                            <tr>
                                <td>Type of leave/reason</td>
                                <td>{$request.lv_type}</td>
                            </tr>
                            <tr>
                                <td>Where Leave will be Spent</td>
                                <td>{$request.lv_where}</td>
                            </tr>
                            <tr>
                                <td>No. days</td>
                                <td>{$request.lv_no_days}</td>
                            </tr>
                            <tr>
                                <td>Inclusive Dates</td>
                                <td>{$request.lv_date_fr} - {$request.lv_date_to}</td>
                            </tr>
                            <tr>
                                <td>Commutation</td>
                                <td>{$request.lv_commutation}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">Action</div>
                    </div>
                    <form class="card-body" action="" method="POST" onsubmit="return confirm('Please click OK to confirm.')">
                        <div class="form-group">
                            <div class="form-label">Response</div>
                            <div class="custom-controls-stacked">
                                <label class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" name="example-radios" value="option1" checked="">
                                    <div class="custom-control-label">No action</div>
                                </label>
                                <label class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" name="example-radios" value="option1">
                                    <div class="custom-control-label">Recommend</div>
                                </label>
                                <label class="custom-control custom-radio">
                                    <input type="radio" class="custom-control-input" name="example-radios" value="option1">
                                    <div class="custom-control-label">Disapproved</div>
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Remarks</label>
                            <textarea class="form-control" name="example-textarea-input" rows="6" placeholder="Enter remarks here..."></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Submit</button>
                    </form>
                </div>
                <a href="{$server}/request" class="btn btn-secondary btn-block">Back to Leave Request list</a>
            </div>
        </div>
    </div>
</div>
{else}
<div class="my-3 my-md-5">
    <div class="container">
    <div class="card">
        <div class="card-body">
            <form class="form-group form-inline" style="vertical-align: middle;" method="POST" action="" id="formFilter">
                <label style="display: inline-block;">Request Status Filter </label>
                <select name="request_stat_filter" class="form-control custom-select" onchange="load_request(this.value)">
                    <option value="" {if $status == 0 && $response == 0}selected{/if}>For Checking</option>
                    <option value="for-recommendation" {if $status == 0 && $response == 1}selected{/if}>For Recommendation</option>
                    <option value="approved" {if $status == 1 && $response == 1}selected{/if}>Approved</option>
                    <option value="disapproved" {if $status == 2 && $response == 1}selected{/if}>Disapproved</option>
                </select>
                <div style="float: right;"> <button name="print_all_request" class="btn btn-primary"> <i class="fe fe-printer"></i> Print All</button></div>
            </form>
        </div>
        <hr style="margin: 0px 0px;">

        <div class="table-responsive">
            <table class="table table-hover table-outline " style="width: 100%;" id="requests" class=" content: '\e90c';">
                <thead>
                    <tr>
                        <th class="text-center w-1 no-sort"><i class="icon-people"></i></th>
                        <th class="no-sort">Employee</th>
                        <th class="no-sort">Leave Type</th>
                        <th class="no-sort">Inclusive Dates</th>
                        <th class="text-center no-sort">Date of Filing</th>
                        <th class="text-center no-sort">Action</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $requests as $request}
                    <tr>
                        <td class="text-center">
                            <div class="avatar d-block" style="background-image: url('assets/img/employees/avatar/{$request.employee_picture}')">
                                <span class="avatar-status bg-green"></span>
                            </div>
                        </td>
                        <td>
                            <input type="hidden" name="emp_id" value="{$request.employee_id}">
                            <div>{$request.EmpName}</div>
                        </td>
                        <td>
                            <div>{$request.lv_type}</div>
                        </td>
                        <td>
                            <div>{$request.lv_date_fr} - {$request.lv_date_to}</div>
                        </td>
                        <td class="text-center">
                            <div>{$request.lv_dateof_filing}</div>
                        </td>
                        <td class="text-center">
                            <a href="/request/details/{$request.leave_id}" class="btn btn-secondary btn-pill openModal"><i class="fe fe-info"></i> View Details</a>
                        </td>
                        <td>
                            {if $request.lv_status != 0}
                            <form class="user" action="queries/process_request.php" method="POST">
                                <input type="hidden" name="leave_id" value="{$request.leave_id}">
                                <input type="hidden" name="status" value="{$request.status}">
                                <input type="hidden" name="response" value="{$request.response}">
                                <div class="selectgroup selectgroup-pills">
                                    <label class="selectgroup-item">
                                        <button type="submit" name="print_request" value="{$request.leave_id}" class="selectgroup-input" checked="false"></button>
                                        <span class="selectgroup-button selectgroup-button-icon"><i class="fe fe-printer"></i></span>
                                    </label>
                                    <label class="selectgroup-item">
                                        {if $request.response != 3}<button type="submit" name="delete_request" value="{$request.leave_id}" class="selectgroup-input" checked="false"></button>{/if}
                                        <span class="selectgroup-button selectgroup-button-icon"><i class="fe fe-trash" ></i></span>
                                    </label>
                                </div>
                            </form>
                            {/if}
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
            <script>
                require (['datatables'], function () {
                    $("#requests").DataTable();
                });
            </script>
        </div>
    </div>
</div>
<script>
    function load_request (status) {
        document.location = "{$server}/request/"+status;
    }
</script>
{/if} *}
{/block}