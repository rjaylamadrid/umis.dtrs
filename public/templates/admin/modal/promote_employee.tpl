<div class="modal fade margin-top-70" id="promote-employee-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">New Employment Information</h3>
                </div>
                <div class="card-body">
                    <form action="/employees" method="POST">
                        <input type="hidden" name="action" value="update_employment_info">
                        <input type="hidden" name="emp_status[campus_id]" id="campus" value="{$employee->info.campus_id}">
                        <input type="hidden" name="emp_status[employee_id]" id="employee_id" value="{$employee->id}">
                        <div class="row">
                            {if $employee->id}
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Last Day on Previous Position</label>
                                    <input type="date" class="form-control" name="date_end">
                                </div>
                            </div>
                            {/if}
                            <hr>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Employment Status</label>
                                    <select class="form-control" name="emp_status[etype_id]" required onchange="javascript:init_pos (this.value)">
                                        <option selected disabled>Select</option>
                                        {foreach from=$emp_type item=type}
                                        <option value="{$type.etype_id}">{$type.etype_desc}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Position</label>
                                    <select class="form-control" name="emp_status[position_id]" id="positions" onchange="get_salary()">
                                        <option selected disabled>Select</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Effectivity Date</label>
                                    <input type="date" class="form-control" name="emp_status[date_start]" id="date-start" onchange="get_salary()">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Salary</label>
                                    <input type="text" class="form-control" name="" value="Php 0.00" disabled id="salary">
                                </div>
                            </div>
                             <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Department</label>
                                    <select class="form-control" name="emp_status[department_id]" required>
                                        <option selected disabled>Select</option>
                                        {foreach from=$departments item=dept}
                                        <option value="{$dept.no}">{$dept.department_desc}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Designation</label>
                                    <select class="form-control" name="emp_status[privilege]">
                                        {foreach from=$designations item=designation}
                                        <option value="{$designation.priv_level}" {if $designation.priv_level == '0'}selected{/if}>{$designation.priv_desc}</option>
                                        {/foreach}
                                    </select>
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