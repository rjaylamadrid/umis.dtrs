{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
    <div class="card">
        <div class="card-body">
            <form class="form-group form-inline" style="vertical-align: middle;" method="POST" action="" id="formFilter">
                <label style="display: inline-block;">Request Status Filter </label>
                <select name="request_stat_filter" class="form-control custom-select" onchange="this.form.submit()">
                    <option value="?a=forms&status=0&response=0" {if $status == 0 && $response == 0}selected{/if}>For Checking</option>
                    <option value="?a=forms&status=0&response=1" {if $status == 0 && $response == 1}selected{/if}>For Recommendation</option>
                    <option value="?a=forms&status=1&response=1" {if $status == 1 && $response == 1}selected{/if}>Approved</option>
                    <option value="?a=forms&status=2&response=1" {if $status == 2 && $response == 1}selected{/if}>Disapproved</option>
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
                            <div class="small text-muted">
                                TODO: Position here
                            </div>
                        </td>
                        <td>
                            <div>{$request.lv_type}</div>
                            <div class="small text-muted">{if $request.lv_where == "Within the Philippines"}{$request.lv_where}{else}{$request.lv_where} - {$request.lv_where_specific}{/if}</div>
                        </td>
                        <td>
                            <div>{$request.lv_date_fr} - {$request.lv_date_to}</div>
                            <div class="small text-muted">{$request.lv_no_days} day/s - Commutation ({$request.lv_commutation})</div>
                        </td>
                        <td class="text-center">
                            <div>{$request.lv_dateof_filing}</div>
                        </td>
                        <td class="text-center">
                            <button data-toggle="modal" data-fetch="{$request.leave_id}" data-target="#openModal" class="btn btn-secondary btn-pill openModal"
                            {if $request.lv_status == 1 && $request.response == 2}
                                disabled> <i class="fe fe-check"></i> Approved
                            {elseif $request.lv_status == 0 && $request.response == 2}
                                disabled> <i class="fe fe-arrow"></i> For Approval
                            {elseif $request.lv_status == 2}
                                disabled><i class="fe fe-x"></i> Disapproved
                            {elseif $request.response == 3}
                                disabled><i class="fe fe-trash"></i> Cancelled
                            {else}
                                ><i class="fe fe-info"></i> View Details
                            {/if}
                            </button>
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
{/block}