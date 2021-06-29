{* {$x = json_encode($filter_conditions)} *}
<input type="hidden" value='{json_encode($filter_conditions)}' id="filter_conditions">
{json_encode($filter_conditions)}
<div class="col-12"><div class="card">
<div id="cover-spin" style="display: none; position:absolute;" class="spinner1"></div>
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
                                {if $employee.is_active == '1'}
                                    <a href="javascript:set_emp_inactive('{$employee.employee_no}', '{if $employee.is_active == '0'}1{else}0{/if}','{$employee.first_name|upper} {$employee.last_name|upper}','{$employee.position}');" class="dropdown-item"><i class="dropdown-icon fe fe-tag"></i> Set as {if $employee.is_active == '0'}Active{else}Inactive{/if}
                                {else}
                                    <a href="javascript:set_inactive('{$employee.employee_no}', '{if $employee.is_active == '0'}1{else}0{/if}');" class="dropdown-item"><i class="dropdown-icon fe fe-tag"></i> Set as {if $employee.is_active == '0'}Active{else}Inactive{/if}
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