{extends file="layout.tpl"}
{block name=content}
{if $result == 'success'} <script>alert('Employee has been set to inactive successfully');</script> {/if}
    <div class="my-3 my-md-5">
        <div class="container">
            {include file="admin/employee_stats.tpl"}
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="form-group">
                                <div style="float: right;">
                                    <a href="/employees/registration" class="btn btn-primary"><i class="fe fe-user-plus"></i> Add new employee</a>
                                </div>
                                <button type="button" class="btn btn-secondary" onclick="javascript:show_collapse('filters','#')">
                                    Show Filters <span class="fe fe-chevron-down"></span>
                                </button>
                                <div class="collapse" id="filters">
                                    <div id="cover-spin" style="display: none; position:absolute;" class="spinner1"></div>
                                    
                                    <div id="multiselect">
                                    <form class="demo-example">
                                        <label for="people">Select people:</label>
                                        <select id="people" name="people" multiple="" style="display: none;">
                                            <option value="alice">Alice</option>
                                            <option value="bob">Bob</option>
                                            <option value="carol">Carol</option>
                                        </select><div class="multi-select-container"><span class="multi-select-button" role="button" aria-haspopup="true" tabindex="0" aria-label="Select people:">-- Select --</span><div class="multi-select-menu" role="menu" style="width: auto;"><div class="multi-select-menuitems"><label class="multi-select-menuitem" for="people_0" role="menuitem"><input type="checkbox" id="people_0" value="alice"> Alice</label><label class="multi-select-menuitem" for="people_1" role="menuitem"><input type="checkbox" id="people_1" value="bob"> Bob</label><label class="multi-select-menuitem" for="people_2" role="menuitem"><input type="checkbox" id="people_2" value="carol"> Carol</label></div></div></div>
                                    </form>
                                    </div>

                                    <form action="" method="POST" id="frm_inactive">
                                        <br />
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-label">Campus:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;" disabled>
                                                    <option value="">Sipocot</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Department:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">GASS</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Designation:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">HR Officer</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Position:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">Administrative Officer IV</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Graduate Studies:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">MAED - Biological Science</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Bachelor's Degree:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">BS Information Technology</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Eligibility:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">Career Service - Professional</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Trainings and Seminars:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">Computer System Servicing</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Appointment Status:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">Permanent | Non-Teaching</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Gender:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;" multiple size="3">
                                                    <option value="">All</option>
                                                    <option value="">Male</option>
                                                    <option value="">Female</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Marital Status:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">Single</option>
                                                </select>
                                            </div>
                                            {* <div class="col-md-3">
                                                <div class="form-label">Citizenship:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">Filipino</option>
                                                    <option value="">Non-Filipino</option>
                                                </select>
                                            </div> *}
                                            <div class="col-md-3">
                                                <div class="form-label">Active Status:</div>
                                                <select name="emp_type" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;">
                                                    <option value="">Active</option>
                                                    <option value="">Inactive</option>
                                                </select>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row row-cards row-deck">
                {include file="admin/employee_tbl.tpl"}
            </div>
        </div>
    </div>
    <script>
        $(function(){
            $('#people').multiSelect();
        });

        function set_inactive (id, val = 0) {
            status = val == 0 ? 'inactive' : 'active';
            //if(confirm("Are you sure you want to set this employee " + status + "?")) {
                if (val == 0) {
                    f({ action: 'set_active', active: val, id: id}, "json", "/employees").then (function (result) {
                        if (result.success) location.reload();
                    });
                } else {
                    $('#campus').val({$user.campus_id});
                    $('#employee_id').val(id);
                    $('#promote-employee-modal').modal('show');
                }
            //}
        }
    </script>
    <div class="modal fade margin-top-70" id="employee-status-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" role="document">
        </div>
    </div>
    {include file="admin/modal/promote_employee.tpl"}
    {include file="admin/modal/set_employee_inactive.tpl"}
{/block}