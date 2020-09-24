{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee->id}/references{else}/update/references{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
        {if $employee->references}
            {foreach from=$employee->references item=references}
                <tr class="row-header">
                    <td colspan="2">{$references@iteration}</td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td>{$references.reference_name}<div class="small text-muted">{$references.reference_position}</div>
                    </td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td>
                        <div>{$references.reference_address}</div>
                        <div class="small text-muted">CONTACT NO: {$references.reference_contact}</div>
                    </td>
                </tr>
            {/foreach}
        {else}
            <tr class="row-header">
                <td colspan="2">no Record(s) found.</td>
            </tr>
        {/if}
        </table>
    </div>
{else}
    <div class="form-group form-inline">
        <label class="h4" style="display: inline-block;">Character References</label>
        <div style="float: right;">
            <a href="" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#eligibility-info"><i class="fe fe-plus"></i>Add Reference</a>
        </div>
    </div>
    <div class="row">
        <div class="card">
            <div class="table-responsive">
                <table class="table table-hover table-outline table-vcenter text-nowrap card-table" id="eligibility_table">
                    <thead>
                        <tr>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Tel. No.</th>
                        <th style="width: 5%;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$employee->references item=references}
                            <tr>
                                <td><div>{$references.reference_name}</div></td>
                                <td><div>{$references.reference_address}</div></td>
                                <td><div>{$references.reference_contact}</div></td>
                                    <td style="vertical-align: middle; text-align: center;">
                                        <form action="" method="POST"><input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="reference_no" value="1">
                                            <button type="submit" class="btn btn-outline-danger btn-sm"><i class="fe fe-trash"></i></button>
                                        </form>
                                    </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="modal fade margin-top-70" id="eligibility-info" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="eligibility-modal" role="document" style="max-width: 600px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add new character reference</h4>
                </div>
                <div class="modal-body">
                    <form action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/references{else}/save{/if}" method="POST">
                        <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->id}">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[reference_name]" required="">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Address</label>
                                    <input type="text" class="form-control" name="employeeinfo[reference_address]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Tel. No.</label>
                                    <input type="text" class="form-control" name="employeeinfo[reference_contact]" required="">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/if}