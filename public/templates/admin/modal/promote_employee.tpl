<div class="modal fade margin-top-70" id="promote-employee-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Promotion</h3>
                </div>
                <div class="card-body">
                    <form action="" method="POST">
                        <input type="hidden" id="campus" value="{$employee->info.campus_id}">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Employment Status</label>
                                    <select class="form-control" name="emp_status1[etype_id]" required onchange="javascript:init_pos (this.value)">
                                        <option selected disabled>Employment Status</option>
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
                                        <option selected disabled>Position</option>
                                        {foreach from=$positions item=position}
                                        <option value="{$position.no}" {if $position.no == $employee->info.position_id}selected{/if}>{$position.position_desc}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Effectivity Date</label>
                                    <input type="date" class="form-control" name="emp_status[date_start]" value="{$employee->info.date_start}" id="date-start" onchange="get_salary()">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Salary</label>
                                    <input type="text" class="form-control" name="" value="Php {$employee->position.salary|number_format:2:".":","}" disabled id="salary">
                                </div>
                            </div>
                             <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Department</label>
                                    <select class="form-control" name="emp_status1[etype_id]" required onchange="javascript:init_pos (this.value)">
                                        <option selected disabled>Department</option>
                                        {foreach from=$departments item=dept}
                                        <option value="{$dept.no}" {if $dept.no == $employee->info.department_id}selected{/if}>{$dept.department_desc}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="form-label">Designation</label>
                                    <select class="form-control" name="emp_status[position_id]" id="positions">
                                        <option selected disabled>Designation</option>
                                        {foreach from=$designations item=designation}
                                        <option value="{$designation.priv_level}" {if $designation.priv_level == $employee->info.privilege}selected{/if}>{$designation.priv_desc}</option>
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