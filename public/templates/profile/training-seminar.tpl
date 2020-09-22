{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.type}/employees/update/{$employee->id}/training-seminar{else}/update/training-seminar{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
        {if $employee->training_seminar}
            {foreach from = $employee->training_seminar item = training_seminar}
                <tr class="row-header">
                    <td colspan="2">{$training_seminar@iteration}</td>
                </tr>
                <tr>
                    <td>Title of Training</td>
                    <td>{$training_seminar.training_title}</td>
                </tr>
                <tr>
                    <td>Sponsored by</td>
                    <td>{$training_seminar.training_sponsor}</td>
                </tr>
                <tr>
                    <td>No of hours</td>
                    <td>
                        <div>{$training_seminar.training_hours}<div class="small text-muted">{$training_seminar.training_from} - {$training_seminar.training_to}</div>
                    </td>
                </tr>
                <tr>
                    <td>Type of LD</td>
                    <td>{$training_seminar.training_type}</td>
                </tr>
            {/foreach}
        {else}
            <tr class="row-header">
                <td colspan="2">No Record(s) found.</td>
            </tr>
        {/if}
        </table>
    </div>
{else}

    <style type="text/css">
        .eligibility thead th
        {
            padding: 2px 5px;
            font-size: 11px;
            text-align: center;
            vertical-align: middle;
        }
    
        .eligibility tr td
        {
            padding: 2px 5px;
            font-size: 14px;
            text-align: center;
            vertical-align: middle;
        }
  </style>

    <div class="form-group form-inline">
        <label class="h4" style="display: inline-block;">Learning and Development</label>
        <div style="float: right;">
            <a href="" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#learning-development-info"><i class="fe fe-plus"></i>Add Learning & Development</a>
        </div>
    </div>
    <div class="row">
        <div class="table-responsive">
            <table class="table table-bordered" id="training_table">
                <thead>
                    <tr>
                        <th rowspan="2">Title of Learning and Development</th>
                        <th colspan="2">Inclusive Dates</th>
                        <th rowspan="2">Hours</th>
                        <th rowspan="2">Type of LD</th>
                        <th rowspan="2">Conducted / Sponsored By</th>
                        <th rowspan="2" style="width: 5%;"></th>
                    </tr>
                    <tr>
                        <th>From</th>
                        <th>To</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from = $employee->training_seminar item = training_seminar}
                        <tr>
                            <td>{$training_seminar.training_title}</td>
                            <td>{$training_seminar.training_from}</td>
                            <td>{$training_seminar.training_to}</td>
                            <td>{$training_seminar.training_hours}</td>
                            <td>{$training_seminar.training_type}</td>
                            <td>{$training_seminar.training_sponsor}</td>
                            <td style="vertical-align: middle; text-align: center;">
                                <form action="" method="POST">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="training_no" value="1">
                                    <button type="submit" class="btn btn-outline-danger btn-sm"><i class="fe fe-trash"></i></button>
                                </form>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
  
    <div class="modal fade margin-top-70" id="learning-development-info" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="learning-development-modal" role="document" style="max-width: 600px;">
            <form method="POST" action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/training-seminar{else}/save{/if}">
                <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->id}">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add Learning & Development Attended</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Title of Learning and Development Interventions</label>
                                    <input type="text" class="form-control" name="employeeinfo[training_title]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Inclusive Date (FROM)</label>
                                    <input type="date" class="form-control" name="employeeinfo[training_from]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Inclusive Date (TO)</label>
                                    <input type="date" class="form-control" name="employeeinfo[training_to]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Number of Hours</label>
                                    <input type="text" class="form-control" name="employeeinfo[training_hours]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Type of LD</label>
                                    <input type="text" class="form-control" name="employeeinfo[training_type]">
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Conducted/Sponsored by</label>
                                    <input type="text" class="form-control" name="employeeinfo[training_sponsor]">
                                </div>
                            </div>
                        </div>
                        <p><i>Type of LD (Managerial/Supervisory/Technical/etc.)</i></p>
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