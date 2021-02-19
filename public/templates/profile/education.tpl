{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee->id}/education{else}/update/education{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    {if $message}
        <div class="alert card-alert {if $message.success}alert-success{else}alert-danger{/if} alert-dismissible">
            <button type="button" class="close" data-dismiss="alert"></button>
            <i class="fe {if $message.success}fe-check{else}fe-alert-triangle{/if} mr-2" aria-hidden="true"></i>{$message.message}
        </div>
        <br />
    {/if}
    <div class="table-responsive">
        <table class="table card-table table-striped">
            {if $employee->education}
                {foreach from = $employee->education item = education}
                    <tr class="row-header"><td colspan="2">{$education.level}</td></tr>
                    <tr><td>School</td><td><div>{$education.school_name}</div><div class="small text-muted">{$education.school_address}</div></td></tr>
                    <tr><td>Basic Education/Degree</td><td><div>{$education.school_degree}</div><div class="small text-muted">{$education.highest_level}</div></td></tr>
                    <tr><td>Year Graduated</td><td><div>{$education.year_graduated}</div><div class="small text-muted">{if $education.period_from}{$education.period_from}{else}N/A{/if}{if $education.period_to} - {$education.period_to}{else}N/A{/if}</div></td></tr>
                    <tr><td>Scholarships/Academic Honors Received</td><td>{if $education.academic_honor}{$education.academic_honor}{else}N/A{/if}</td></tr>
                {/foreach}
            {else}
                <tr class="row-header">
                    <td colspan="2">No Record(s) Found</td>
                </tr>
            {/if}
        </table>
    </div>
{else}
<form method = "POST" action="{$server}{if $user.is_admin}/employees/save/{$employee->id}/education{else}/save{/if}">
    <input type="hidden" name="admin_id" value="{$user.employee_id}">
    <div class="form-group row btn-square">
        <label class="h4">Educational Background</label>
        <div style="float: right;">
            <a href="" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#eligibility-info"><i class="fe fe-plus"></i>Add Educational Background</a>
        </div>
        <div class="card mb-1">
            <div class="card-content">
                {foreach from = $employee->education item = education}
                <input type="hidden" name="employeeinfo[{$education@iteration}][no]" value="{$education.no}">
                <input type="hidden" name="employeeinfo[{$education@iteration}][employee_id]" value="{$employee->id}">
                <input type="hidden" name="employeeinfo[{$education@iteration}][level]" value="{$education.level}">
                <input type="hidden" name="employeeinfo[{$education@iteration}][school_address]" value="{$education.school_address}">
                    <div class="card-header pt-0 pb-0">
                        <h4 class="card-title">{$education.level}</h4>
                        <a href="#" onclick="javascript:show_collapse({$education@iteration})" class="ml-auto" style="text-decoration: none;"><span class="{$education@iteration} fe fe-chevron-down"></span></a>
                    </div>
                    <div class="card-body collapse" id="{$education@iteration}">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group mb-1">
                                    <label class="form-label mb-0">School Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[{$education@iteration}][school_name]" value="{$education.school_name}" required>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <label class="form-label mb-0">School Degree</label>
                                    <input type="text" class="form-control" name="employeeinfo[{$education@iteration}][school_degree]" value="{$education.school_degree}">
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-8">
                                <label class="form-label mb-0">Period of Attendance</label>
                                <div class="row">
                                    <div class="col-sm-6 col-md-6">
                                        <div class="form-group mb-1">
                                            <label class="form-label mb-0">From</label>
                                            <input type="text" class="form-control" name="employeeinfo[{$education@iteration}][period_from]" value="{$education.period_from}" required>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 col-md-6">
                                        <div class="form-group mb-1">
                                            <label class="form-label mb-0">To</label>
                                            <input type="text" class="form-control" name="employeeinfo[{$education@iteration}][period_to]" value="{$education.period_to}" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <div class="label-floating">
                                        <label class="form-label mb-0">Highest Level</label>
                                        <input type="text" class="form-control" name="employeeinfo[{$education@iteration}][highest_level]" value="{$education.highest_level}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <div class="label-floating">
                                        <label class="form-label mb-0">Year Graduated</label>
                                        <input type="text" class="form-control" name="employeeinfo[{$education@iteration}][year_graduated]" value="{$education.year_graduated}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <div class="label-floating">
                                        <label class="form-label mb-0">Scholarships/Academic Honors Received</label>
                                        <input type="text" class="form-control" name="employeeinfo[{$education@iteration}][academic_honor]" value="{$education.academic_honor}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 mt-2" style="text-align: right;">
                                <a class="btn btn-danger" style="color:#fff"  onclick="javascript:confirm_delete({$education.no},{$employee->id},'{$tab}')">Delete Record</a>
                            </div>
                            <br />
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 mt-2" style="text-align: right;">
                {if $employee->education}
                    <button type="submit" class="btn btn-primary">Save changes</button>
                {/if}
            </div>
        </div>
    </div>
</form>

<div class="modal fade margin-top-70" id="eligibility-info" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" id="eligibility-modal" role="document" style="max-width: 600px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Add new educational background</h4>
            </div>
            <div class="modal-body">
                <form action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/education{else}/save{/if}" method="POST">
                <input type="hidden" name="admin_id" value="{$user.employee_id}">
                <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->id}">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-group label-floating mb-0">
                                <label class="form-label mb-0">School Name</label>
                                <input type="text" class="form-control" name="employeeinfo[school_name]" required="">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group label-floating mb-0">
                                <label class="form-label mb-0" for="level">Level</label>
                                <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="employeeinfo[level]">
                                    <option value="" disabled></option>
                                    <option value="Elementary">Elementary</option>
                                    <option value="Secondary">Secondary</option>
                                    <option value="Vocational">Vocational</option>
                                    <option value="College">College</option>
                                    <option value="Graduate Studies">Graduate Studies</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <br>
                            <div class="form-group label-floating mb-0">
                                <label class="form-label mb-0">School Degree</label>
                                <input type="text" class="form-control" name="employeeinfo[school_degree]">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label mb-0">Period of Attendance</label>
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="form-group label-floating mb-0">
                                        <label class="form-label mb-0">From</label>
                                        <input type="text" class="form-control" name="employeeinfo[period_from]" required="">
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="form-group label-floating mb-0">
                                        <label class="form-label mb-0">To</label>
                                        <input type="text" class="form-control" name="employeeinfo[period_to]" required="">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-6">
                            <div class="form-group label-floating mb-0">
                                <label class="form-label mb-0">Scholarships/Academic Honors Received</label>
                                <input type="text" class="form-control" name="employeeinfo[academic_honor]">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group label-floating mb-0">
                                <label class="form-label mb-0">Highest Level</label>
                                <input type="text" class="form-control" name="employeeinfo[highest_level]" required="">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group label-floating mb-0">
                                <label class="form-label mb-0">Year Graduated</label>
                                <input type="text" class="form-control" name="employeeinfo[year_graduated]" required="">
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