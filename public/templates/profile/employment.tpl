{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee->id}/employment{else}/update/employment{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
        {foreach from=$employee->employment item=employment}
            <tr class="row-header">
                <td colspan="2">{$employment@iteration}</td>
            </tr>
            <tr>
                <td>Position/Title</td>
                <td>
                    <div>{$employment.position}</div>
                    <div class="small text-muted">{$employment.date_from} - {if $employment.date_to}{$employment.date_to}{else}PRESENT{/if}</div>
                </td>
            </tr>
            <tr>
                <td>Company</td>
                <td>{$employment.company}</td>
            </tr>
            <tr>
                <td>Salary</td>
                <td>{$employment.salary|number_format:2}
                    <div class="small text-muted">Monthly Salary</div>
                </td>
            </tr>
            <tr>
                <td>Appointment</td>
                <td>
                    <div>{$employment.appointment}</div>
                    <div class="small text-muted">Government Service: {if $employment.govt_service == "1"}YES{else}NO{/if}</div>
                </td>
            </tr>
        {/foreach}
        </table>
    </div>
{else}
    <div class="form-group form-inline">
    <label class="h4" style="display: inline-block;">Work Experience</label>
        <div style="float: right;">
            <a href="" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#employment-info"><i class="fe fe-plus"></i>Add Work Experience</a>
        </div>
    </div>
    <div class="row">
        <div class="card">
            <div class="table-responsive">
                <table class="table table-hover table-outline table-vcenter text-nowrap card-table" id="eligibility_table">
                    <thead>
                        <tr>
                        <th>Position Title</th>
                        <th>Company</th>
                        <th>Salary</th>
                        <th>Appointment</th>
                        <th style="width: 5%;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$employee->employment item=employment}
                            <tr>
                                <td>
                                    <div>{$employment.position}</div>
                                    <div class="small text-muted">Date: {$employment.date_from} - {if $employment.date_to}{$employment.date_to}{else}PRESENT{/if}</div>
                                </td>
                                <td>
                                    <div>{$employment.company}</div>
                                </td>
                                <td>
                                    <div>{$employment.salary|number_format:2}</div>
                                    <div class="small text-muted">Salary Grade: SAMPLE</div>
                                </td>
                                <td>
                                    <div>{$employment.appointment}</div>
                                    <div class="small text-muted">Gov't Service: {if $employment.govt_service == "1"}YES{else}NO{/if}</div>
                                </td>
                                <td style="vertical-align: middle; text-align: center;">
                                    <form action="" method="POST">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="employment_no" value="1">
                                        <button type="submit" class="btn btn-outline-danger btn-sm">
                                            <i class="fe fe-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="modal fade margin-top-70" id="employment-info" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="eligibility-modal" role="document" style="max-width: 600px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add Work Experience</h4>
                </div>
                <div class="modal-body">
                    <form action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/employment{else}/save{/if}" method="POST">
                        <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->id}">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Position/Title</label>
                                    <input type="text" class="form-control" name="employeeinfo[position]" required="">
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Company Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[company]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Start</label>
                                    <input type="date" class="form-control" name="employeeinfo[date_from]" required="">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">End (*if necessary)</label>
                                    <input type="date" class="form-control" name="employeeinfo[date_to]">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Salary</label>
                                    <input type="text" class="form-control" name="employeeinfo[salary]">
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">SG</label>
                                    <input type="number" max="30" class="form-control" name="employeeinfo[salary_grade]">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Appointment</label>
                                    <select class="form-control" name="employeeinfo[appointment]">
                                        <option value="Regular">Regular</option>
                                        <option value="Casual">Casual</option>
                                        <option value="Temporary">Temporary</option>
                                        <option value="Contractual">Contractual</option>
                                        <option value="Project-based">Project-based</option>
                                        <option value="Job Order">Job Order</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Gov't</label>
                                    <select class="form-control" name="employeeinfo[govt_service]">
                                        <option value="1">Yes</option>
                                        <option value="0">No</option>
                                    </select>
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