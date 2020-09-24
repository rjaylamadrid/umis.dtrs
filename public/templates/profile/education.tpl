{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee->id}/education{else}/update/education{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
            {foreach from = $employee->education item = education}
                <tr class="row-header"><td colspan="2">{$education.level}</td></tr>
                <tr><td>School</td><td><div>{$education.school_name}</div><div class="small text-muted">{$education.school_address}</div></td></tr>
                <tr><td>Basic Education/Degree</td><td><div>{$education.school_degree}</div><div class="small text-muted">{$education.highest_level}</div></td></tr>
                <tr><td>Year Graduated</td><td><div>{$education.year_graduated}</div><div class="small text-muted">{$education.period_from} - {$education.period_to}</div></td></tr>
                <tr><td>Honor</td><td>{$education.academic_honor}</td></tr>
            {/foreach}
        </table>
    </div>
{else}
<form method = "POST" action="{$server}{if $user.is_admin}/employees/save/{$employee->id}/education{else}/save{/if}">
    <div class="form-group row btn-square">
        <label class="h4">Educational Background</label>
        <div style="float: right;">
            <a href="" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#eligibility-info"><i class="fe fe-plus"></i>Add Educational Background</a>
        </div>
        <div class="card mb-1">
            <div class="card-content">
                {foreach from = $employee->education item = education}
                    <div class="card-header pt-0 pb-0">
                        <h4 class="card-title">{$education.level}</h4>
                        <a href="#" onclick="javascript:show_collapse({$education@iteration})" class="ml-auto" style="text-decoration: none;"><span class="{$education@iteration} fe fe-chevron-down"></span></a>
                    </div>
                    <div class="card-body collapse" id="{$education@iteration}">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group mb-1">
                                    <label class="form-label mb-0">School Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[{$education.level}][school_name]" value="{$education.school_name}">
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <label class="form-label mb-0">School Degree</label>
                                    <input type="text" class="form-control" name="employeeinfo[{$education.level}][school_degree]" value="{$education.school_degree}">
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <label class="form-label mb-0">Date Started</label>
                                    <input type="date" class="form-control" name="employeeinfo[{$education.level}][period_from]" value="{$education.period_from}">
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <label class="form-label mb-0">Date Finished</label>
                                    <input type="date" class="form-control" name="employeeinfo[{$education.level}][period_to]" value="{$education.period_to}">
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <div class="label-floating">
                                        <label class="form-label mb-0">Highest Level</label>
                                        <input type="text" class="form-control" name="employeeinfo[{$education.level}][highest_level]" value="{$education.highest_level}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <div class="label-floating">
                                        <label class="form-label mb-0">Year Graduated</label>
                                        <input type="text" class="form-control" name="employeeinfo[{$education.level}][year_graduated]" value="{$education.year_graduated}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <div class="form-group mb-1">
                                    <div class="label-floating">
                                        <label class="form-label mb-0">Academic Honors</label>
                                        <input type="text" class="form-control" name="employeeinfo[{$education.level}][academic_honor]" value="{$education.academic_honor}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 mt-2" style="text-align: right;">
                                <a class="btn btn-danger" style="color:#fff"  onclick="javascript:confirm_delete({$education.no})">Delete Record</a>
                            </div>
                            <br />
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 mt-2" style="text-align: right;">
                <button type="submit" class="btn btn-primary">Save changes</button>
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
                <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->id}">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label">School Name</label>
                                <input type="text" class="form-control" name="employeeinfo[school_name]" required="">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label" for="level">Level</label>
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
                            <div class="form-group label-floating">
                                <label class="form-label">School Degree</label>
                                <input type="text" class="form-control" name="employeeinfo[school_degree]">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label">Date Started</label>
                                <input type="date" class="form-control" name="employeeinfo[period_from]" required="">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label">Date Finished</label>
                                <input type="date" class="form-control" name="employeeinfo[period_to]" required="">
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label">Academic Honors</label>
                                <input type="text" class="form-control" name="employeeinfo[academic_honor]">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label">Highest Level</label>
                                <input type="text" class="form-control" name="employeeinfo[highest_level]" required="">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label">Year Graduated</label>
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

{* <div class="modal fade margin-top-70" id="confirm-delete" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" id="eligibility-modal" role="document" style="max-width: 600px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Confirmation</h4>
            </div>
            <div class="modal-body">
                <form action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/other-info{else}/save{/if}" method="POST">
                    <div class="row align-center">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-group label-floating">
                                <p>Are you sure that you want to delete this record? {$education.no}</p>
                                {* <input type="text" class="form-control" name="employeeinfo[other_skill]" required="">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Yes</button>
                        <button class="btn btn-secondary" data-dismiss="modal">No</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div> *}
{/if}