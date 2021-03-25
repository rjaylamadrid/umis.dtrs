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
                            <div class="form-group form-inline">
                                <a href="/employees/registration" class="btn btn-primary"><i class="fe fe-user-plus"></i> New Employee</a>
                                <div style="float: right;">
                                    <form action="" method="POST" id="frm_inactive">
                                        <div class="form-group" style="margin-bottom: 0px;">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        Filter by
                                                    </button>
                                                    <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                        <a class="dropdown-item" href="javascript:void(0)">Employment Status</a>
                                                        <a class="dropdown-item" href="javascript:void(0)">Department</a>
                                                        <a class="dropdown-item" href="javascript:void(0)">Specialization</a>
                                                    </div>
                                                </div>
                                                <select name="emp_type" class="form-control custom-select" onchange="document.forms['frm_inactive'].submit()">
                                                    <option value="">All Employees</option>
                                                    {foreach $emp_type as $e}
                                                        <option value="{$e.id}" {if $e.id == $period.emp_type}selected{/if}>{$e.type_desc} {if $e.type_desc2} | {$e.type_desc2}{/if}</option>
                                                    {/foreach}
                                                </select>
                                                <select name="emp_type" class="form-control custom-select collapse" onchange="document.forms['frm_inactive'].submit()">
                                                    <option value="">All Employees</option>
                                                    {foreach $emp_type as $e}
                                                        <option value="{$e.id}" {if $e.id == $period.emp_type}selected{/if}>{$e.type_desc} {if $e.type_desc2} | {$e.type_desc2}{/if}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                            <label class="custom-switch" style="display: inline-block; padding: 0 10px; ">
                                                <input type="checkbox" name="inactive" onchange="document.forms['frm_inactive'].submit()" class="custom-switch-input" {if $status == '0'}checked{/if}>
                                                <span class="custom-switch-indicator"></span>
                                                <span class="custom-switch-description">Inactive </span>
                                            </label>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row row-cards row-deck">
                <div class="col-12"><div class="card">
                    <div class="table-responsive">
                        <table style=" font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-employees">
                            <thead>
                                <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Sex</th>
                                <th>Date of Birth</th>
                                <th>Position</th>
                                <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from = $employees item = employee}
                                    <tr>
                                        <td>{$employee.employee_id}</td>
                                        <td>{$employee.first_name|upper} {$employee.last_name|upper}</td>
                                        <td>{$employee.gender}</td>
                                        <td>{$employee.birthdate|date_format:'M d, Y'}</td>
                                        <td>{$employee.position}</td>
                                        <td class="text-center"><div class="item-action dropdown">
                                            <a href="javascript:void(0)" data-toggle="dropdown" class="icon" aria-expanded="false"><i class="fe fe-more-vertical"></i></a>
                                            <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-181px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                <a href="{$server}/employees/profile/{$employee.employee_no}/basic-info" class="dropdown-item"><i class="dropdown-icon fe fe-tag"></i> Profile 
                                                </a>
                                                <a href="{$server}/employees/employment/{$employee.employee_no}/employment_info" class="dropdown-item"><i class="dropdown-icon fe fe-user"></i> Employment
                                                </a>
                                                {if $employee.active_status == '1'}
                                                    <a href="javascript:set_emp_inactive('{$employee.employee_no}', '{if $employee.active_status == '0'}1{else}0{/if}','{$employee.first_name|upper} {$employee.last_name|upper}','{$employee.position}');" class="dropdown-item"><i class="dropdown-icon fe fe-tag"></i> Set as {if $employee.active_status == '0'}Active{else}Inactive{/if}
                                                {else}
                                                    <a href="javascript:set_inactive('{$employee.employee_no}', '{if $employee.active_status == '0'}1{else}0{/if}');" class="dropdown-item"><i class="dropdown-icon fe fe-tag"></i> Set as {if $employee.active_status == '0'}Active{else}Inactive{/if}
                                                {/if}
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
                <script>
                    require (['datatables'], function () {
                        $("#tbl-employees").DataTable();
                    })
                </script>
            </div>
        </div>
    </div>
    <script>
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