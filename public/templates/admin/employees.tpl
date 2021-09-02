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
                                    <a href="javascript:create_schedule()" class="btn btn-primary"><i class="fe fe-calendar"></i> Create Preset Schedule</a>
                                    <a href="/employees/registration" class="btn btn-primary"><i class="fe fe-user-plus"></i> Add new employee</a>
                                </div>
                                <button type="button" class="btn btn-secondary" onclick="javascript:show_collapse('filters','#')">
                                    Show Filters <span class="fe fe-chevron-down"></span>
                                </button>
                                <div class="collapse" id="filters">
                                    <div id="cover-spin" style="display: none; position:absolute;" class="spinner1"></div>

                                    {* <div id="multiselect">
                                    <form class="demo-example">
                                        <label for="people">Select people:</label>
                                        <select id="people" name="people" multiple="" style="display: none;">
                                            <option value="alice">Alice</option>
                                            <option value="bob">Bob</option>
                                            <option value="carol">Carol</option>
                                        </select>
                                    </form>
                                    </div>

                                    <div id="multiselect">
                                    <form class="demo-example">
                                        <label for="asd">Select people:</label>
                                        <select id="asd" name="asd" multiple="" style="display: none;">
                                            <option value="alice">Alice</option>
                                            <option value="bob">Bob</option>
                                            <option value="carol">Carol</option>
                                        </select>
                                    </form>
                                    </div> *}

                                    <form action="" method="POST" id="frm_inactive">
                                        <br />
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-label">Campus:</div>
                                                <select name="filter[campus]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem;" disabled>
                                                    <option value="">Sipocot</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                    <div class="form-label">Department:</div>
                                                    <select id="dept" name="department" class="form-control custom-select" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                        {foreach $filters.departments as $dept}
                                                            {if $campus == $dept.campus_id}
                                                                <option value="{$dept.no}" selected>{$dept.department_desc}</option>
                                                            {/if}
                                                        {/foreach}
                                                    </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Designation:</div>
                                                <select id="designation" name="filter[designation]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                    {foreach $filters.designation as $des}
                                                            <option value="{$des.priv_level}" selected>{$des.priv_desc}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Position:</div>
                                                <select id="position" name="filter[position]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                    {foreach $filters.position as $pos}
                                                        <option value="{$pos.no}" selected>{$pos.position_desc}
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Graduate Studies:</div>
                                                <select id="graduate" name="filter[grad_stud]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="" disabled>
                                                    {foreach $filters.graduate_study as $grad}
                                                        <option value="'{$grad.highest_level}'" selected>{$grad.highest_level}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Bachelor's Degree:</div>
                                                <select id="bachelor" name="filter[bach_degree]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="" disabled>
                                                    {foreach $filters.bachelors as $bach}
                                                        <option value="'{$bach.school_degree}'" selected>{$bach.school_degree}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Eligibility:</div>
                                                <select id="eligibility" name="filter[eligibility]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                    {foreach $filters.eligibility as $eli}
                                                        <option value="'{$eli.eligibility_name}'" selected>{$eli.eligibility_name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Trainings and Seminars:</div>
                                                <select id="training" name="filter[trainings]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                    {foreach $filters.training as $train}
                                                        <option value="'{$train.training_title}'" selected>{$train.training_title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Appointment Status:</div>
                                                <select id="appointment" name="filter[apt_status]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                    {foreach $filters.status as $stat}
                                                        <option value="{$stat.id}" selected>{$stat.type_desc}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Gender:</div>
                                                <select id="gender" name="filter[gender]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                    <option value="'Male'" selected>Male</option>
                                                    <option value="'Female'" selected>Female</option>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Marital Status:</div>
                                                <select id="marital" name="filter[marital_status]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                    {foreach $filters.marital as $marital}
                                                        <option value="'{$marital.marital_status}'" selected>{$marital.marital_status}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-label">Active Status:</div>
                                                <select id="active" name="filter[active_status]" class="form-control custom-select" onchange="" style="padding: 0rem 1.75rem 0rem 0.75rem; max-width:100%;" multiple="">
                                                    <option value="1" selected>Active</option>
                                                    <option value="2" selected>Inactive</option>
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
            <div class="row row-cards row-deck" id="employees_list">
                {include file="admin/employee_tbl.tpl"}
            </div>
        </div>
    </div>
    <script>
        require (['multiselect'], function () {
            $('#dept').multiSelect({
                allText: 'All Departments',
                noneText: 'None',
                presets: [ {
                    name: 'All Departments',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#dept').on('change', function() {
                var dep = $('#filter_conditions').val();
                employees_filter($(this).val(), 'department_id', dep);
            });
            $('#designation').multiSelect({
                allText: 'All Designations',
                noneText: 'None',
                presets: [ {
                    name: 'All Designations',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#designation').on('change', function() {
                var des = $('#filter_conditions').val();
                employees_filter($(this).val(), 'privilege', des);
            });
            $('#position').multiSelect({
                allText: 'All Positions',
                noneText: 'None',
                presets: [ {
                    name: 'All Positions',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#position').on('change', function() {
                var pos = $('#filter_conditions').val();
                employees_filter($(this).val(), 'position_id', pos);
            });
            $('#graduate').multiSelect({
                allText: 'All Graduate Studies',
                noneText: 'None',
                presets: [ {
                    name: 'All Graduate Studies',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#graduate').on('change', function() {
                //$('#filter[bach_degree]_preset_0').attr("checked","checked");
                //document.getElementById("filter[bach_degree]_preset_0").checked = true;
                var gra = $('#filter_conditions').val();
                employees_filter($(this).val(), 'highest_level', gra,2);
            });
            $('#bachelor').multiSelect({
                allText: 'All College Degrees',
                noneText: 'None',
                presets: [ {
                    name: 'All College Degrees',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#bachelor').on('change', function() {
                var bac = $('#filter_conditions').val();
                employees_filter($(this).val(), 'school_degree', bac,1);
            });
            $('#eligibility').on('change', function() {
                var eli = $('#filter_conditions').val();
                employees_filter($(this).val(), 'eligibility_name', eli);
            });
            $('#eligibility').multiSelect({
                allText: 'All Eligibilities',
                noneText: 'None',
                presets: [ {
                    name: 'All Eligibilities',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#training').multiSelect({
                allText: 'All Trainings / Seminars',
                noneText: 'None',
                presets: [ {
                    name: 'All Trainings / Seminars',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#training').on('change', function() {
                var tra = $('#filter_conditions').val();
                employees_filter($(this).val(), 'training_title', tra);
            });
            $('#appointment').multiSelect({
                allText: 'All Appointment Status',
                noneText: 'None',
                presets: [ {
                    name: 'All Appointment Status',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#appointment').on('change', function() {
                var app = $('#filter_conditions').val();
                employees_filter($(this).val(), 'etype_id', app);
            });
            $('#gender').multiSelect({
                allText: 'All Genders',
                noneText: 'None',
                presets: [ {
                    name: 'All Genders',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#gender').on('change', function() {
                var gen = $('#filter_conditions').val();
                employees_filter($(this).val(), 'gender', gen);
            });
            $('#marital').multiSelect({
                allText: 'All Status',
                noneText: 'None',
                presets: [ {
                    name: 'All Status',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#marital').on('change', function() {
                var mar = $('#filter_conditions').val();
                employees_filter($(this).val(), 'marital_status', mar);
            });
            $('#active').multiSelect({
                allText: 'All Status',
                noneText: 'None',
                presets: [ {
                    name: 'All Status',
                    all: true
                }, {
                    name: 'None',
                    options: []
                } ]
            });
            $('#active').on('change', function() {
                var act = $('#filter_conditions').val();
                employees_filter($(this).val(), 'is_active', act);
            });
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