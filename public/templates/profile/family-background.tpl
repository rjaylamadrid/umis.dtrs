{foreach from = $employee->family_background item = family_background}
    {if $family_background.relationship == 1}
        {$spouse = $family_background}
    {elseif $family_background.relationship == 2}
        {$mother = $family_background}
    {elseif $family_background.relationship == 3}
        {$father = $family_background}
    {elseif $family_background.relationship == 0}
        {$child = $family_background}
    {/if}
{/foreach}
{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee->id}/family-background{else}/update/family-background{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
            <tr class="row-header"><td colspan="2">Spouse's Information</td></tr>
            <tr><td>Name</td><td>{$spouse.first_name} {$spouse.middle_name} {$spouse.last_name} {$spouse.ext_name}</td></tr>
            <tr><td>Occupation</td><td>{$spouse.occupation}</td></tr>
            <tr><td>Employer/Business</td><td>{$spouse.employer}</td></tr>
            <tr><td>Business Address</td><td>{$spouse.business_address}</td></tr>
            <tr><td>Telephone No</td><td>{$spouse.telephone_no}</td></tr>
            <tr class="row-header"><td colspan="2">Parents' Information</td></tr>
            <tr><td>Father's Name</td><td>{$father.first_name} {$father.middle_name} {$father.last_name} {$father.ext_name}</td></tr>
            <tr><td>Mother's Name</td><td>{$mother.first_name} {$mother.middle_name} {$mother.last_name} {$mother.ext_name}</td></tr>
        </table>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped" id="children_table">
            <tr class="row-header"><td colspan="2">Children</td></tr>
            <tr>
                <th>Name of Children</th>
                <th>Date of Birth </th>
            </tr>
            {foreach from = $employee->family_background item = child }
                {if $child.relationship == 0}<tr><td>{$child.first_name} {$child.middle_name} {$child.last_name} {$child.ext_name}</td><td>{$child.birthdate}</td></tr>{/if}
            {/foreach}
        </table>
    </div>
{else}
    <form action="{$server}{if $user.is_admin}/employees/save/{$employee->id}/family-background{else}/save{/if}" method="POST">
        <div class="form-group row btn-square">
            <label class="h4">Spouse's Information</label>
            <div class="row">
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <input type="text" class="form-control" name="employeeinfo[1][first_name]" value="{$spouse.first_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Middle Name</label>
                        <input type="text" class="form-control" name="employeeinfo[1][middle_name]" value="{$spouse.middle_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Last Name</label>
                        <input type="text" class="form-control" name="employeeinfo[1][last_name]" value="{$spouse.last_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Ext Name</label>
                        <input type="text" class="form-control" name="employeeinfo[1][ext_name]" value="{$spouse.ext_name}">
                    </div>
                </div>
                <br />
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <label class="form-label">Occupation</label>
                        <input type="text" class="form-control" name="employeeinfo[1][occupation]" value="{$spouse.occupation}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <label class="form-label">Telephone No.</label>
                        <input type="text" class="form-control" name="employeeinfo[1][telephone_no]" value="{$spouse.telephone_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <label class="form-label">Employer/Business Name</label>
                        <input type="text" class="form-control" name="employeeinfo[1][employer]" value="{$spouse.employer}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <div class="label-floating">
                            <label class="form-label">Business Address</label>
                            <input type="text" class="form-control" name="employeeinfo[1][business_address]" value="{$spouse.business_address}">
                        </div>
                    </div>
                </div>
            </div>
    
            <label class="h4">Parent's Information</label>
            <div class="row">
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">Father's Surname</label>
                        <input type="text" class="form-control" name="employeeinfo[3][last_name]" value="{$father.last_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <input type="text" class="form-control" name="employeeinfo[3][first_name]" value="{$father.first_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">Middle Name</label>
                        <input type="text" class="form-control" name="employeeinfo[3][middle_name]" value="{$father.middle_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">Ext Name</label>
                        <input type="text" class="form-control" name="employeeinfo[3][ext_name]" value="{$father.ext_name}">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Mother's Maiden Name</label>
                        <input type="text" class="form-control" name="employeeinfo[2][last_name]" value="{$mother.last_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <input type="text" class="form-control" name="employeeinfo[2][first_name]" value="{$mother.first_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Middle Name</label>
                        <input type="text" class="form-control" name="employeeinfo[2][middle_name]" value="{$mother.middle_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">Ext Name</label>
                        <input type="text" class="form-control" name="employeeinfo[2][ext_name]" value="{$father.ext_name}">
                    </div>
                </div>
            </div>
            <label class="h4">Children</label>
            <div class="row p-2">
                <div class="table-responsive">
                    <table class="table table-bordered" id="children_table">
                        <tr>
                            <th colspan="4">Name of Children</th>
                            <th>Date of Birth</th>
                            <th style="width: 10%; vertical-align: middle; text-align: center;"><a href="#" class="btn btn-outline-success btn-sm"data-toggle="modal" data-target="#children-info"><i class="fe fe-plus"></i></a></th>
                        </tr>

                        <tbody>
                            {foreach from = $employee->family_background item = child }
                                {if $child.relationship == 0}
                                <tr id="row">
                                        <input type="hidden" class="form-control" name="employeeinfo[0][{$child@iteration}][no]" value="{$child.no}">
                                        <td><input type="text" class="form-control" name="employeeinfo[0][{$child@iteration}][first_name]" value="{$child.first_name}"></td>
                                        <td><input type="text" class="form-control" name="employeeinfo[0][{$child@iteration}][middle_name]" value="{$child.middle_name}"></td>
                                        <td><input type="text" class="form-control" name="employeeinfo[0][{$child@iteration}][last_name]" value="{$child.last_name}"></td>
                                        <td><input type="text" class="form-control" name="employeeinfo[0][{$child@iteration}][ext_name]" value="{$child.ext_name}"></td>
                                        <td><input type="text" class="form-control" name="employeeinfo[0][{$child@iteration}][birthdate]" value="{$child.birthdate}"></td>
                                        <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-danger btn-sm" href="javascript:confirm_delete({$child.no},{$child.employee_id},'{$tab}')"><i class="fe fe-trash"></i></a></td>
                                </tr>
                                {/if}
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" style="text-align: right;">
                <button type="submit" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </form>

    <div class="modal fade margin-top-70" id="children-info" role="dialog" tabindex="-1" style="margin-left:-50px;">
        <div class="modal-dialog" id="eligibility-modal" role="document" style="max-width: 600px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add new child</h4>
                </div>
                <div class="modal-body">
                    <form action="{$server}{if $user.is_admin}/employees/add_profile_info/{$employee->id}/family-background{else}/save{/if}" method="POST">
                    <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->id}">
                    <input type="hidden" name="employeeinfo[relationship]" value="0">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">First Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[first_name]" required="">
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Middle Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[middle_name]" required="">
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Last Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[last_name]" required="">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Extension Name</label>
                                    <input type="text" class="form-control" name="employeeinfo[ext_name]">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Birthdate</label>
                                    <input type="date" class="form-control" name="employeeinfo[birthdate]" required="">
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