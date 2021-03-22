<div class="modal fade margin-top-70" id="add-service-record-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="card m-0">
                <div class="card-header">
                    <h3 class="card-title">Past Service Record</h3>
                </div>
                <div class="card-body">
                    <form action="/employees" method="POST">
                        <input type="hidden" name="action" value="update_employment_info">
                        <input type="hidden" name="type" value="new">
                        <input type="hidden" name="emp_status[campus_id]" id="campus" value="{$employee->info.campus_id}">
                        <input type="hidden" name="emp_status[employee_id]" value="{$employee->id}">
                        <div class="row">
                            <div class="col-md-12 form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="form-label">Date Started</label>
                                        <input type="date" class="form-control" name="emp_status[date_start]" id="date-start">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Date Ended</label>
                                        <input type="date" class="form-control" name="emp_status[date_end]">
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Employment Status</label>
                                    <select class="form-control" name="emp_status[etype_id]" required onchange="javascript:init_pos (this.value)">
                                        <option selected disabled>Select</option>
                                        <option value="1" {if $positions->emp_type == '1'}selected{/if}>Permanent | Teaching</option> 
                                        <option value="2" {if $positions->emp_type == '2'}selected{/if}>Permanent | Non-Teaching</option> 
                                        <option value="5" {if $positions->emp_type == '5'}selected{/if}>COS | Teaching</option>
                                        <option value="6" {if $positions->emp_type == '6'}selected{/if}>COS | Non-Teaching</option>
                                        <option value="7" {if $positions->emp_type == '7'}selected{/if}>Project-based</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Position</label>
                                    <select class="form-control" name="emp_status[position_id]" id="positions">
                                        <option selected disabled>Select</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Salary</label>
                                    <input type="text" class="form-control" name="emp_status[salary]">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="form-label">SG</label>
                                    <input type="text" class="form-control" name="emp_status[salary_grade]">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="form-label">Step</label>
                                    <input type="text" class="form-control" name="emp_status[step]">
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Remarks</label>
                                    <input type="text" class="form-control" name="emp_status[remarks]">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <span style="float: right;">
                            <input type="submit" class="btn btn-primary" value="Submit">
                            <a href="#" class="btn btn-secondary" data-dismiss="modal">Cancel</a>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>