{* {$emp = $emp[0]} *}
{* {var_dump($employee->id)} *}
{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee->id}{else}/update{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
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
            <tr class="row-header"><td colspan="2">Personal Information</td></tr>
            <tr><td>Name</td><td>{$employee->basic_info.first_name} {$employee->basic_info.middle_name} {$employee->basic_info.last_name} {$employee->basic_info.ext_name}</td></tr>
            <tr><td>Birthdate</td><td>{$employee->basic_info.birthdate|date_format:'F d, Y'}</td></tr>
            <tr><td>Birthplace</td><td>{$employee->basic_info.birthplace}</td></tr>
            <tr><td>Sex</td><td>{$employee->basic_info.gender}</td></tr>
            <tr><td>Civil Status</td><td>{$employee->basic_info.marital_status}</td></tr>
            <tr><td>Height (m)</td><td>{$employee->basic_info.height}</td></tr>
            <tr><td>Weight (kg)</td><td>{$employee->basic_info.weight}</td></tr>
            <tr><td>Blood Type</td><td>{$employee->basic_info.blood_type}</td></tr>
            <tr><td>Citizenship</td><td>{$employee->basic_info.citizenship}</td></tr>
            {if $employee->basic_info.dual_citizen}<tr><td>Other Citizenship</td><td>{$employee->basic_info.dual_citizen}</td></tr>{/if}
            <tr><td>Residential Address</td><td>{if $employee->basic_info.resadd_house_block_no != ''}{$employee->basic_info.resadd_house_block_no}{/if} {if $employee->basic_info.resadd_street != ''}{$employee->basic_info.resadd_street}, {/if} {if $employee->basic_info.resadd_sub_village}{$employee->basic_info.resadd_sub_village}, {/if}{if $employee->basic_info.resadd_brgy}{$employee->basic_info.resadd_brgy}, {/if}{if $employee->basic_info.resadd_mun_city}{$employee->basic_info.resadd_mun_city}, {/if}{if $employee->basic_info.resadd_province}{$employee->basic_info.resadd_province} {/if}{if $employee->basic_info.resadd_zip_code}{$employee->basic_info.resadd_zip_code}{/if}</td></tr>
            <tr><td>Permanent Address</td><td>{if $employee->basic_info.peradd_house_block_no != ''}{$employee->basic_info.peradd_house_block_no}{/if} {if $employee->basic_info.peradd_street != ''}{$employee->basic_info.peradd_street}, {/if} {if $employee->basic_info.peradd_sub_village}{$employee->basic_info.peradd_sub_village}, {/if}{if $employee->basic_info.peradd_brgy}{$employee->basic_info.peradd_brgy}, {/if}{if $employee->basic_info.peradd_mun_city}{$employee->basic_info.peradd_mun_city}, {/if}{if $employee->basic_info.peradd_province}{$employee->basic_info.peradd_province} {/if}{if $employee->basic_info.peradd_zip_code}{$employee->basic_info.peradd_zip_code}{/if}</td></tr>
            <tr class="row-header"><td colspan="2">Other Information</td></tr>
            <tr><td>GSIS ID No</td><td>{$employee->basic_info.gsis_no}</td></tr>
            <tr><td>PAG-IBIG ID No</td><td>{$employee->basic_info.pagibig_no}</td></tr>
            <tr><td>SSS No</td><td>{$employee->basic_info.sss_no}</td></tr>
            <tr><td>TIN No</td><td>{$employee->basic_info.tin_no}</td></tr>
            <tr><td>Agency Employee No</td><td>{$employee->basic_info.employee_id}</td></tr>
            <tr><td>Telephone No</td><td>{$employee->basic_info.telephone_no}</td></tr>
            <tr><td>Mobile No</td><td>{$employee->basic_info.cellphone_no}</td></tr>
            <tr><td>E-mail Address</td><td>{$employee->basic_info.email_address}</td></tr>
        </table>
    </div>
{else}
    <form action="{$server}{if $user.is_admin}/employees/save/{$employee->id}/basic-info{else}/save{/if}" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
        <input type="hidden" name="employeeinfo[no]" value="{$employee->basic_info.no}">
        <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->basic_info.employee_id}">
        <div class="form-group row btn-square">
            <div class="row">
                <div class="col-sm-12 col-lg-4 col-md-4 mb-4 text-center btn-square">
                    <div class="form-group">
                        <div style="text-align: center; border: 2; width: 100%; align-content: center" id="thumb-output">
                            <img style="text-align: center; border: 1;" src="{$server}/assets/employee_picture/{if $employee->basic_info.employee_picture}{$employee->basic_info.employee_picture}{else}0.jpeg{/if}"  >
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="file" id="file-input" class="" name="profile_picture" value="{$employee->basic_info.employee_picture}" accept="image/*" style="width:13rem">
                    </div>
                </div>
                <div class="col-sm-12 col-md-8" style="padding-right: 0px; padding-left: 0px;">
                    <div class="row">
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group">
                                <label class="form-label">First Name</label>
                                <input type="text" class="form-control" name="employeeinfo[first_name]" value="{$employee->basic_info.first_name}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group">
                                <label class="form-label">Middle Name</label>
                                <input type="text" class="form-control" name="employeeinfo[middle_name]" value="{$employee->basic_info.middle_name}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group">
                                <label class="form-label">Last Name</label>
                                <input type="text" class="form-control" name="employeeinfo[last_name]" value="{$employee->basic_info.last_name}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group">
                                <div class="label-floating">
                                    <label class="form-label">Extension Name (Jr,Sr)</label>
                                    <input type="text" class="form-control" name="employeeinfo[ext_name]" value="{$employee->basic_info.ext_name}">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class=" label-floating">
                                <label class="form-label" for="gender">Gender</label>
                                <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="employeeinfo[gender]">
                                    <option value="" disabled></option>
                                    <option value="Male" {if $employee->basic_info.gender == 'Male'} selected {/if}>Male</option>
                                    <option value="Female" {if $employee->basic_info.gender == 'Female'} selected {/if}>Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group label-floating">
                                <label class="form-label">Birthday</label>
                                <input type="date" class="form-control" name="employeeinfo[birthdate]" value="{$employee->basic_info.birthdate}" max="">
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label">Birthplace</label>
                                <input type="text" class="form-control" name="employeeinfo[birthplace]" value="{$employee->basic_info.birthplace}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <label class="form-label form-label-main">RESIDENTIAL ADDRESS</label>
                </div>
                <hr style="width: 100%; margin: 5px 1px;">
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">House/Block/Lot No.</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_house_block_no]" value="{$employee->basic_info.resadd_house_block_no}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Street</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_street]" value="{$employee->basic_info.resadd_street}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Subdivision/Village</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_sub_village]" value="{$employee->basic_info.resadd_sub_village}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Barangay</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_brgy]" value="{$employee->basic_info.resadd_brgy}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">City/Municipality</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_mun_city]" value="{$employee->basic_info.resadd_mun_city}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Province</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_province]" value="{$employee->basic_info.resadd_province}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">ZIP Code</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_zip_code]" value="{$employee->basic_info.resadd_zip_code}">
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <label class="form-label form-label-main">PERMANENT ADDRESS</label>
                </div>
                <hr style="width: 100%; margin: 5px 1px;">
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">House/Block/Lot No.</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_house_block_no]" value="{$employee->basic_info.peradd_house_block_no}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Street</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_street]" value="{$employee->basic_info.peradd_street}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Subdivision/Village</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_sub_village]" value="{$employee->basic_info.peradd_sub_village}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Barangay</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_brgy]" value="{$employee->basic_info.peradd_brgy}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">City/Municipality</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_mun_city]" value="{$employee->basic_info.peradd_mun_city}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Province</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_province]" value="{$employee->basic_info.peradd_province}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">ZIP Code</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_zip_code]" value="{$employee->basic_info.peradd_zip_code}">
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <label class="form-label form-label-main">OTHER INFORMATION</label>
                </div>
                <hr style="width: 100%; margin: 10px 1px;">
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label" for="civil_stat">Marital Status</label>
                        <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="employeeinfo[marital_status]">
                            <option value="" disabled>Civil Status</option>
                            <option value="Single" {if $employee->basic_info.marital_status == 'Single'} selected {/if}>Single</option>
                            <option value="Married" {if $employee->basic_info.marital_status == 'Married'} selected {/if}>Married</option>
                            <option value="Widowed" {if $employee->basic_info.marital_status == 'Widowed'} selected {/if}>Widowed</option>
                            <option value="Separated" {if $employee->basic_info.marital_status == 'Separated'} selected {/if}>Separated</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label" for="civil_stat">Citizenship</label>
                        <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="employeeinfo[citizenship]" onchange="javascript:dual_citizenship(this.value)" required>
                            <option value="" disabled selected="">Select Citizenship</option>
                            <option value="Filipino" {if $employee->basic_info.citizenship == "Filipino"} selected {/if}>Filipino</option>
                            <option value="Dual Citizenship - by birth" {if $employee->basic_info.citizenship == "Dual Citizenship - by birth"} selected {/if}>Dual Citizenship - by birth</option>
                            <option value="Dual Citizenship - by naturalization" {if $employee->basic_info.citizenship == "Dual Citizenship - by naturalization"} selected {/if}>Dual Citizenship - by naturalization</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label" for="dual_citizen">Pls. indicate country (if dual citizen)</label>
                        <input class="form-control" type="text" id="dual_citizen" name="employeeinfo[dual_citizen]" {if $employee->basic_info.dual_citizen == "Filipino"} readonly {else}value="{$employee->basic_info.dual_citizen}" {/if} {if $employee->basic_info.dual_citizen != "Filipino"} required {/if}>
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Height (m)</label>
                        <input  type="text"  class="form-control" name="employeeinfo[height]" value="{$employee->basic_info.height}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Weight (kg)</label>
                        <input class="form-control" type="text" name="employeeinfo[weight]" value="{$employee->basic_info.weight}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Blood Type</label>
                        <input class="form-control" type="text" name="employeeinfo[blood_type]" value="{$employee->basic_info.blood_type}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">GSIS ID No.</label>
                        <input type="text" class="form-control" name="employeeinfo[gsis_no]" value="{$employee->basic_info.gsis_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">PAG-IBIG ID No.</label>
                        <input class="form-control" type="text" name="employeeinfo[pagibig_no]" value="{$employee->basic_info.pagibig_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">PHILHEALTH No.</label>
                        <input class="form-control" type="text" name="employeeinfo[philhealth_no]" value="{$employee->basic_info.philhealth_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">SSS No.</label>
                        <input  type="text" class="form-control" name="employeeinfo[sss_no]" value="{$employee->basic_info.sss_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">TIN No.</label>
                        <input class="form-control" type="text" name="employeeinfo[tin_no]" value="{$employee->basic_info.tin_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Agency Employee No.</label>
                        <input readonly class="form-control" type="text" value="{$employee->basic_info.employee_id}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Email Address</label>
                        <input type="email"  class="form-control" name="employeeinfo[email_address]" value="{$employee->basic_info.email_address}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Mobile Number</label>
                        <input class="form-control bfh-phone" type="tel" name="employeeinfo[cellphone_no]"  value="{$employee->basic_info.cellphone_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Telephone Number</label>
                        <input class="form-control bfh-phone" type="tel" name="employeeinfo[telephone_no]"  value="{$employee->basic_info.telephone_no}">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" style="text-align: right;">
            <button type="submit" class="btn btn-primary">{if $user.is_admin}Save changes{else}Submit to HR{/if}</button>
            </div>
        </div>
    </form>
{/if}