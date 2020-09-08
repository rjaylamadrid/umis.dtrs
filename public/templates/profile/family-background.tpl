{foreach from = $emp item = rel}
    {if $rel.relationship == 1}
        {$spouse = $rel}
    {elseif $rel.relationship == 2}
        {$mother = $rel}
    {elseif $rel.relationship == 3}
        {$father = $rel}
    {/if}
{/foreach}
{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee.employee_id}/family-background{else}/update/family-background{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
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
                <th>Date of Birth</th>
            </tr>
            {foreach from = $emp item = child }
                {if $child.relationship == 0}<tr><td>{$child.first_name} {$child.middle_name} {$child.last_name} {$child.ext_name}</td><td>{$child.birthdate}</td></tr>{/if}
            {/foreach}
        </table>
    </div>
{else}
    <form action="" method="POST">
        <input type="hidden" name="action" value="save_changes">
        <div class="form-group row btn-square">
            <label class="h4">Spouse's Information</label>
            <div class="row">
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <input type="text" class="form-control" name="employeeinfo[SpouseFirstname]" value="{$spouse.first_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Middle Name</label>
                        <input type="text" class="form-control" name="employeeinfo[SpouseMiddlename]" value="{$spouse.middle_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Last Name</label>
                        <input type="text" class="form-control" name="employeeinfo[SpouseLastname]" value="{$spouse.last_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Ext Name</label>
                        <input type="text" class="form-control" name="employeeinfo[SpouseExtname]" value="{$spouse.ext_name}">
                    </div>
                </div>
                <br />
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <label class="form-label">Occupation</label>
                        <input type="text" class="form-control" name="employeeinfo[SpouseWork]" value="{$spouse.occupation}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <label class="form-label">Telephone No.</label>
                        <input type="text" class="form-control" name="employeeinfo[SpouseTelephone]" value="{$spouse.telephone_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <label class="form-label">Employer/Business Name</label>
                        <input type="text" class="form-control" name="employeeinfo[SpouseEmployer]" value="{$spouse.employer}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6">
                    <div class="form-group">
                        <div class="label-floating">
                            <label class="form-label">Business Address</label>
                            <input type="text" class="form-control" name="employeeinfo[SpouseAddress]" value="{$spouse.business_address}">
                        </div>
                    </div>
                </div>
            </div>
    
            <label class="h4">Parent's Information</label>
            <div class="row">
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">Father's Surname</label>
                        <input type="text" class="form-control" name="employeeinfo[FatherLastname]" value="{$father.last_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <input type="text" class="form-control" name="employeeinfo[FatherFirstname]" value="{$father.first_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">Middle Name</label>
                        <input type="text" class="form-control" name="employeeinfo[FatherMiddlename]" value="{$father.middle_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="form-group">
                        <label class="form-label">Ext Name</label>
                        <input type="text" class="form-control" name="employeeinfo[FatherExtname]" value="{$father.ext_name}">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Mother's Maiden Name</label>
                        <input type="text" class="form-control" name="employeeinfo[MotherLastname]" value="{$mother.last_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <input type="text" class="form-control" name="employeeinfo[MotherFirstname]" value="{$mother.first_name}">
                    </div>
                </div>
                <div class="col-sm-12 col-md-3">
                    <div class="form-group">
                        <label class="form-label">Middle Name</label>
                        <input type="text" class="form-control" name="employeeinfo[MotherMiddlename]" value="{$mother.middle_name}">
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
                            <th style="width: 10%; vertical-align: middle; text-align: center;"><a href="#" class="btn btn-outline-success btn-sm"><i class="fe fe-plus"></i></a></th>
                            <!-- <th style="width: 10%; vertical-align: middle; text-align: center;"><a href="javascript:add_children_row()" class="btn btn-outline-success btn-sm"><i class="fe fe-plus"></i></a></th> -->
                        </tr>

                        <tbody>
                            {foreach from = $emp item = child }
                                {if $child.relationship == 0}
                                    <tr id="row">
                                            <td><input type="text" class="form-control" name="first_name" value="{$child.first_name}"></td>
                                            <td><input type="text" class="form-control" name="middle_name" value="{$child.middle_name}"></td>
                                            <td><input type="text" class="form-control" name="last_name" value="{$child.last_name}"></td>
                                            <td><input type="text" class="form-control" name="ext_name" value="{$child.ext_name}"></td>
                                            <td><input type="text" class="form-control" name="birthdate" value="{$child.birthdate}"></td>
                                            <td style="vertical-align: middle; text-align: center;"><a class="btn btn-outline-danger btn-sm"><i class="fe fe-trash"></i></a></td>
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
{/if}