{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee.employee_id}/training-seminar{else}/update/training-seminar{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
            <tr class="row-header"><td colspan="2">1.</td></tr>
            <tr><td>Title of Training</td><td>SAMPLE</td></tr>
            <tr><td>Sponsored by</td><td>SAMPLE</td></tr>
            <tr><td>No of hours</td><td><div>SAMPLE hour(s)<div class="small text-muted">SAMPLE</div></td></tr>
            <tr><td>Type of LD</td><td>SAMPLE</td></tr>
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
                   <tr>
                       <td>SAMPLE</td>
                       <td>SAMPLE</td>
                       <td>SAMPLE</td>
                       <td>SAMPLE</td>
                       <td>SAMPLE</td>
                       <td>SAMPLE</td>
                       <td style="vertical-align: middle; text-align: center;">
                            <form action="" method="POST">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="training_no" value="1">
                                <button type="submit" class="btn btn-outline-danger btn-sm"><i class="fe fe-trash"></i></button>
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
  
    <div class="modal fade margin-top-70" id="learning-development-info" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="learning-development-modal" role="document" style="max-width: 600px;">
            <form method="POST" action="">
                <input type = "hidden" name="action" value="save">
                <input type = "hidden" name ="new_training[EmployeeID]" value="<?php echo $emp['emp_id'];?>">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add Learning & Development Attended</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Title of Learning and Development Interventions</label>
                                    <input type="text" class="form-control" name="new_training[TrainingName]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Inclusive Date (FROM)</label>
                                    <input type="date" class="form-control" name="date_from">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Inclusive Date (TO)</label>
                                    <input type="date" class="form-control" name="date_to">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Number of Hours</label>
                                    <input type="text" class="form-control" name="new_training[TrainingHour]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Type of LD</label>
                                    <input type="text" class="form-control" name="new_training[TrainingType]">
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Conducted/Sponsored by</label>
                                    <input type="text" class="form-control" name="new_training[TrainingSponsor]">
                                </div>
                            </div>
                        </div>
                        <p><i>Type of LD (Managerial/Supervisory/Technical/etc.)</i></p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
{/if}