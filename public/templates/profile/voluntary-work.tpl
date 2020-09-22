{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.type}/employees/update/{$employee->id}/voluntary-work{else}/update/voluntary-work{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
        {if $employee->voluntary_work}
            {foreach from = $employee->voluntary_work item = voluntary_work}
                <tr class="row-header">
                    <td colspan="2">{$voluntary_work@iteration}</td>
                </tr>
                <tr>
                    <td>Name & Address of Organization</td>
                    <td>{$voluntary_work.organization_name}</td>
                </tr>
                <tr>
                    <td>Inclusive Dates</td>
                    <td>
                        <div>{$voluntary_work.date_from} to {$voluntary_work.date_to}</div>
                        <div class="small text-muted">Hours: {$voluntary_work.total_hours}</div>
                    </td>
                </tr>
                <tr>
                    <td>Position</td>
                    <td>
                        <div>{$voluntary_work.organization_position}</div>
                    </td>
                </tr>
            {/foreach}
        {else}
            <tr class="row-header">
                <td colspan="2">No Record(s) found</td>
            </tr>
        {/if}
        </table>
    </div>
{else}
    <div class="form-group form-inline">
        <label class="h4" style="display: inline-block;">Voluntary Work or Involvement in Civic</label>
        <div style="float: right;">
            <a href="" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#voluntary-work-info"><i class="fe fe-plus"></i>Add voluntary work</a>
        </div>
    </div>
    <div class="row">
        <div class="table-responsive">
            <table class="eligibility table table-bordered" id="voluntary_work_table" style="width: 100%">
                <thead>
                    <tr>
                        <th style="width: 40%" rowspan="2">Name & Address of Organization</th>
                        <th colspan="2">Inclusive Dates</th>
                        <th style="width: 10%" rowspan="2">Hours</th>
                        <th style="width: 20%" rowspan="2">Position / Nature of Work</th>
                        <th style="width: 5%;" rowspan="2"></th>
                    </tr>
                    <tr>
                        <th style="width: 10%;">From</th>
                        <th style="width: 10%;">To</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from = $employee->voluntary_work item = voluntary_work}
                        <tr>
                            <td>{$voluntary_work.organization_name}</td>
                            <td>{$voluntary_work.date_from}</td>
                            <td>{$voluntary_work.date_to}</td>
                            <td>{$voluntary_work.total_hours}</td>
                            <td>{$voluntary_work.organization_position}</td>
                            <td style="vertical-align: middle; text-align: center;">
                                <form action="" method="POST"><input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="voluntary_no" value="1">
                                    <button type="submit" class="btn btn-outline-danger btn-sm"><i class="fe fe-trash"></i></button>
                                </form>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade margin-top-70" id="voluntary-work-info" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="voluntary-work-modal" role="document" style="max-width: 600px;">
            <form method="POST" action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/voluntary-work{else}/save{/if}">  
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add new voluntary work</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->id}">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Name & Address of Organization</label>
                                    <input type="text" class="form-control" name="employeeinfo[organization_name]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Inclusive Date (FROM)</label>
                                    <input type="date" class="form-control" name="employeeinfo[date_from]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Inclusive Date (TO)</label>
                                    <input type="date" class="form-control" name="employeeinfo[date_to]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Number of hours</label>
                                    <input type="text" class="form-control" name="employeeinfo[total_hours]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Position/Nature of Work</label>
                                    <input type="text" class="form-control" name="employeeinfo[organization_position]">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
{/if}