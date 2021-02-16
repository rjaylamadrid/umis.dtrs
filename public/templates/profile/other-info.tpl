{$other_info.other_skill = ";"|explode:$employee->other_info.other_skill}
{$other_info.other_recognition = ";"|explode:$employee->other_info.other_recognition}
{$other_info.other_organization = ";"|explode:$employee->other_info.other_organization}
{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee->id}/other-info{else}/update/other-info{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    {if $message}
        <div class="alert card-alert {if $message.success}alert-success{else}alert-danger{/if} alert-dismissible">
            <button type="button" class="close" data-dismiss="alert"></button>
            <i class="fe {if $message.success}fe-check{else}fe-alert-triangle{/if} mr-2" aria-hidden="true"></i>{$message.message}
        </div>
        <br />
    {/if}
    <div class="table-responsive">
        <table class="table card-table table-striped">
        {if $employee->other_info}
            <tr class="row-header">
                <td>Skills and Hobbies</td>
                {for $i=0 to $other_info.other_skill|@count-1}
                <tr>
                    <td style="font-weight:normal">
                        {if $other_info.other_skill[0]}
                            <p>{$other_info.other_skill[$i]}</p>
                        {else}
                            <p>No Record(s) Found</p>
                        {/if}
                    </td>
                </tr>
                {/for}
            </tr>

            <tr class="row-header">
                <td>Recognition</td>
                {for $i=0 to $other_info.other_recognition|@count-1}
                <tr>
                    <td style="font-weight:normal">
                        {if $other_info.other_recognition[0]}
                            <p>{$other_info.other_recognition[$i]}</p>
                        {else}
                            <p>No Record(s) Found</p>
                        {/if}
                    </td>
                </tr>
                {/for}
            </tr>

            <tr class="row-header">
                <td>Association/Organization</td>
                {for $i=0 to $other_info.other_organization|@count-1}
                <tr>
                    <td style="font-weight:normal">
                        {if $other_info.other_organization[0]}
                            <p>{$other_info.other_organization[$i]}</p>
                        {else}
                            <p>No Record(s) Found</p>
                        {/if}
                    </td>
                </tr>
                {/for}
            </tr>
            
        {else}
            <tr class="row-header">
                <td colspan="2">No Record(s) Found</td>
            </tr>
        {/if}
        </table>
    </div>
{else}
    <form method="POST" action="{$server}{if $user.is_admin}/employees/save/{$employee->id}/other-info{else}/save{/if}">
        <input type="hidden" name="admin_id" value="{$user.employee_id}">
        <div class="row">
            {if $employee->other_info}
                <input type="hidden" name="employeeinfo[no]" value="{$other_info.no}">
                <input type="hidden" name="employeeinfo[employee_id]" value="{$other_info.employee_id}">
                <div class="col-md-4 table-responsive">
                    <table class="table table-bordered" id="skill">
                        <thead><tr><th colspan="2">Skills</th></tr></thead>
                            {for $i=0 to $other_info.other_skill|@count-1}
                                {if ($other_info.other_skill[$i] != '')}
                                    <tr id="skill">
                                        <td style="font-weight:normal"><input class="form-control" type="text" name="employeeinfo[skill][{$i}]" value="{$other_info.other_skill[$i]}"></td>
                                        <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-danger btn-sm" href="javascript:confirm_delete({$other_info.no},{$other_info.employee_id},'{$tab}', '{"other_skill"}', '{$other_info.other_skill[$i]}',{$user.employee_id})"><i class="fe fe-trash"></i></a></td>
                                    </tr>
                                {/if}
                            {/for}
                            <tr>
                                <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-success btn-sm" href="#" data-toggle="modal" data-target="#other-skill">Add new skill<i class="fe fe-plus"></i></a></td>
                            </tr>
                    </table>
                </div>
                <div class="col-md-4 table-responsive">
                    <table class="table table-bordered" id="recog">
                        <thead><tr><th colspan="2">Recognition</th></tr></thead>
                        {for $i=0 to $other_info.other_recognition|@count-1}
                            {if ($other_info.other_recognition[$i] != '')}
                            <tr id="recog">
                                <td style="font-weight:normal"><input class="form-control" type="text" name="employeeinfo[recog][{$i}]" value="{$other_info.other_recognition[$i]}"></td>
                                <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-danger btn-sm" href="javascript:confirm_delete({$other_info.no},{$other_info.employee_id},'{$tab}', '{"other_recognition"}', '{$other_info.other_recognition[$i]}',{$user.employee_id})"><i class="fe fe-trash"></i></a></td>
                            </tr>
                            {/if}
                        {/for}
                        <tr>
                            <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-success btn-sm" href="#" data-toggle="modal" data-target="#other-recog">Add new recognition<i class="fe fe-plus"></i></a></td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-4 table-responsive">
                    <table class="table table-bordered" id="org">
                        <thead><tr><th colspan="2">Association/Organization</th></tr></thead>
                        {for $i=0 to $other_info.other_organization|@count-1}
                            {if ($other_info.other_organization[$i] != '')}
                                <tr id="org">
                                    <td style="font-weight:normal"><input class="form-control" type="text" name="employeeinfo[org][{$i}]" value="{$other_info.other_organization[$i]}"></td>
                                    <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-danger btn-sm" href="javascript:confirm_delete({$other_info.no},{$other_info.employee_id},'{$tab}', '{"other_organization"}', '{$other_info.other_organization[$i]}',{$user.employee_id})"><i class="fe fe-trash"></i></a></td>
                                </tr>
                            {/if}
                        {/for}
                        <tr>
                            <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-success btn-sm" href="#" data-toggle="modal" data-target="#other-org">Add new association/organization<i class="fe fe-plus"></i></a></td>
                        </tr>
                    </table>
                </div>
            {else}
                <input type="hidden" name="employeeinfo[employee_id]" value="{$other_info.employee_id}">
                <div class="col-md-4 table-responsive">
                    <table class="table table-bordered" id="skill">
                        <thead><tr><th colspan="2">Skills</th></tr></thead>
                            {* <tr id="skill">
                                <td style="font-weight:normal"><input class="form-control" type="text" name="employeeinfo[skill][0]"></td>
                                <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-danger btn-sm" href="javascript:confirm_delete({$other_info.no},{$other_info.employee_id},'{$tab}', '{"other_skill"}', '{$other_info.other_skill[$i]}',{$user.employee_id})"><i class="fe fe-trash"></i></a></td>
                            </tr> *}
                            <tr>
                                <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-success btn-sm" href="#" data-toggle="modal" data-target="#other-skill">Add new skill<i class="fe fe-plus"></i></a></td>
                            </tr>
                    </table>
                </div>
                <div class="col-md-4 table-responsive">
                    <table class="table table-bordered" id="recog">
                        <thead><tr><th colspan="2">Recognition</th></tr></thead>
                        {* <tr id="recog">
                            <td style="font-weight:normal"><input class="form-control" type="text" name="employeeinfo[recog][0]" value="{$other_info.other_recognition[$i]}"></td>
                            <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-danger btn-sm" href="javascript:confirm_delete({$other_info.no},{$other_info.employee_id},'{$tab}', '{"other_recognition"}', '{$other_info.other_recognition[$i]}',{$user.employee_id})"><i class="fe fe-trash"></i></a></td>
                        </tr>   *}
                        <tr>
                            <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-success btn-sm" href="#" data-toggle="modal" data-target="#other-recog">Add new recognition<i class="fe fe-plus"></i></a></td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-4 table-responsive">
                    <table class="table table-bordered" id="org">
                        <thead><tr><th colspan="2">Association/Organization</th></tr></thead>
                        {* <tr id="org">
                            <td style="font-weight:normal"><input class="form-control" type="text" name="employeeinfo[org][0]" value="{$other_info.other_organization[$i]}"></td>
                            <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-danger btn-sm" href="javascript:confirm_delete({$other_info.no},{$other_info.employee_id},'{$tab}', '{"other_organization"}', '{$other_info.other_organization[$i]}',{$user.employee_id})"><i class="fe fe-trash"></i></a></td>
                        </tr> *}
                        <tr>
                            <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-success btn-sm" href="#" data-toggle="modal" data-target="#other-org">Add new association/organization<i class="fe fe-plus"></i></a></td>
                        </tr>
                    </table>
                </div>
            {/if}
        </div>
        <div class="row">
            <div class="col-md-12 mt-2" style="text-align: right;">
                <button type="submit" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </form>

    <div class="modal fade margin-top-70" id="other-skill" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="eligibility-modal" role="document" style="max-width: 600px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add new skill</h4>
                </div>
                <div class="modal-body">
                    <form action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/other-info{else}/save{/if}" method="POST">
                        <input type="hidden" name="admin_id" value="{$user.employee_id}">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Type of Skill</label>
                                    <input type="text" class="form-control" name="employeeinfo[other_skill]" required="">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade margin-top-70" id="other-recog" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="eligibility-modal" role="document" style="max-width: 600px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add new recognition</h4>
                </div>
                <div class="modal-body">
                    <form action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/other-info{else}/save{/if}" method="POST">
                        <input type="hidden" name="admin_id" value="{$user.employee_id}">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Title of Recognition</label>
                                    <input type="text" class="form-control" name="employeeinfo[other_recognition]" required="">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade margin-top-70" id="other-org" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="eligibility-modal" role="document" style="max-width: 600px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add new association/organization</h4>
                </div>
                <div class="modal-body">
                    <form action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/other-info{else}/save{/if}" method="POST">
                        <input type="hidden" name="admin_id" value="{$user.employee_id}">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Association/Organization Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[other_organization]" required="">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/if}