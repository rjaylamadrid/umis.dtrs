{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee.employee_id}/education{else}/update/education{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
            {foreach from = $emp item = education}
                <tr class="row-header"><td colspan="2">{$education.level}</td></tr>
                <tr><td>School</td><td><div>{$education.school_name}</div><div class="small text-muted">{$education.school_address}</div></td></tr>
                <tr><td>Basic Education/Degree</td><td><div>{$education.school_degree}</div><div class="small text-muted">{$education.highest_level}</div></td></tr>
                <tr><td>Year Graduated</td><td><div>{$education.year_graduated}</div><div class="small text-muted">{$education.period_from} - {$education.period_to}</div></td></tr>
                <tr><td>Honor</td><td>SAMPLE</td></tr>
            {/foreach}
        </table>
    </div>
{else}
<form method = "POST" action="">
    <input type="hidden" name="action" value="save_changes">
    <div class="form-group row btn-square">
        <label class="h4">Educational Background</label>
        <div class="card mb-1">
            <div class="card-content">
                {foreach from = $emp item = education}
                <div class="card-header pt-0 pb-0">
                    <h4 class="card-title">{$education.level}</h4>
                    <a href="#" onclick="" class="ml-auto" style="text-decoration:  none;"><span class="fe fe-chevron-down"></span></a>
                </div>
                <div class="card-body collapse" id="">
                    <div class="row">
                        <div class="col-sm-12 col-md-12">
                            <div class="form-group mb-1">
                                <label class="form-label mb-0">School Name</label>
                                <input type="text" class="form-control" name="SchoolName[0]" value="{$education.school_name}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group mb-1">
                                <label class="form-label mb-0">School Degree</label>
                                <input type="text" class="form-control" name="SchoolDegree[0]" value="{$education.school_degree}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group mb-1">
                                <label class="form-label mb-0">Period of Attendance</label>
                                <input type="text" class="form-control" name="InclusiveDate[0]" value="{$education.period_from} - {$education.period_to}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-4">
                            <div class="form-group mb-1">
                                <div class="label-floating">
                                    <label class="form-label mb-0">Highest Level</label>
                                    <input type="text" class="form-control" name="HighestLevel[0]" value="{$education.highest_level}">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-4">
                            <div class="form-group mb-1">
                                <div class="label-floating">
                                    <label class="form-label mb-0">Year Graduated</label>
                                    <input type="text" class="form-control" name="GraduateYear[0]" value="{$education.year_graduated}">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-4">
                            <div class="form-group mb-1">
                                <div class="label-floating">
                                    <label class="form-label mb-0">Academic Honors</label>
                                    <input type="text" class="form-control" name="Honor[0]" value="{$education.academic_honor}">
                                </div>
                            </div>
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
  {/if}