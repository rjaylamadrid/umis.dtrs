{extends file="layout.tpl"}
{block name=content}
    <div class="my-3 my-md-5">
        <div class="container">
            {include file="admin/employee_stats.tpl"}
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="form-group form-inline">
                                <a href="?a=employees&show=registration" class="btn btn-primary"><i class="fe fe-user-plus"></i> New employee</a>
                                <div style="float: right;">
                                    <form action="" method="POST" id="inactivefrm">
                                        <div class="form-group" style="margin-bottom: 0px;">
                                            <label class="custom-switch" style="display: inline-block; padding: 0 10px; ">
                                                <input type="checkbox" name="inactive" class="custom-switch-input" onclick="inactivefrm.submit()" {if $frm['inactive']}checked{/if}>
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
                                <th>Gender</th>
                                <th>BirthDate</th>
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
                                        <td>{$employee.birthdate}</td>
                                        <td></td>
                                        <td class="text-center"><div class="item-action dropdown">
                                            <a href="javascript:void(0)" data-toggle="dropdown" class="icon" aria-expanded="false"><i class="fe fe-more-vertical"></i></a>
                                            <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-181px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                <a href="{$server}/employees/profile/{$employee.employee_id}" class="dropdown-item"><i class="dropdown-icon fe fe-tag"></i> View Profile 
                                                </a>
                                                <a href="?a=employees&show=employment&id={$employee.employee_id}&tab=employment" class="dropdown-item"><i class="dropdown-icon fe fe-user"></i> View Employment 
                                                </a>
                                                <a href="javascript:set_inactive('{$employee.employee_id}');" class="dropdown-item"><i class="dropdown-icon fe fe-tag"></i> Set as Inactive 
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
            fetch ({
                action: 'set-active', active: val, id: id
            }).then (response => response.json().then (function (result) {
                if (result.success) location.reload();
            }));
        }
    </script>
{/block}