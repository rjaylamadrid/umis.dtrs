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
                                        <input type="hidden" name="action" value="filter">
                                        <input type="hidden" name="filter" value="status">
                                        <div class="form-group" style="margin-bottom: 0px;">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    Filter by
                                                    </button>
                                                    <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 37px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                        <a class="dropdown-item" href="javascript:change_filter(0)">Employment Status</a>
                                                        <a class="dropdown-item" href="javascript:change_filter(1)">Department</a>
                                                        <a class="dropdown-item" href="javascript:change_filter(2)">Specialization</a>
                                                    </div>
                                                </div>
                                                <select name="status" class="form-control custom-select" onchange="document.forms['frm_inactive'].submit()" id="status">
                                                    <option value="">All Employee</option>
                                                    {foreach $emp_type as $e}
                                                        <option value="{$e.id}" {if $e.id == $type}selected{/if}>{$e.type_desc} {if $e.type_desc2} | {$e.type_desc2}{/if}</option>
                                                    {/foreach}
                                                </select>
                                                <select name="department" class="form-control custom-select collapse" onchange="document.forms['frm_inactive'].submit()" id="department">
                                                    <option value="">All Department</option>
                                                    {foreach $emp_type as $e}
                                                        <option value="{$e.id}" {if $e.id == $period.emp_type}selected{/if}>{$e.type_desc} {if $e.type_desc2} | {$e.type_desc2}{/if}</option>
                                                    {/foreach}
                                                </select>
                                                <select name="specialization" class="form-control custom-select collapse" onchange="document.forms['frm_inactive'].submit()" id="specialization">
                                                    <option value="">All Specialization</option>
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
                {include file="admin/employee_tbl.tpl"}
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