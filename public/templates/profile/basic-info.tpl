{* {$emp = $emp[0]} *}
{* {var_dump($employee->id)} *}
{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee->id}{else}/update{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
            <tr class="row-header"><td colspan="2">Personal Information</td></tr>
            <tr><td>Name</td><td>{$employee->basic_info.first_name} {$employee->basic_info.middle_name} {$employee->basic_info.last_name}</td></tr>
            <tr><td>Birthdate</td><td>{$employee->basic_info.birthdate}</td></tr>
            <tr><td>Birthplace</td><td>{$employee->basic_info.birthplace}</td></tr>
            <tr><td>Sex</td><td>{$employee->basic_info.gender}</td></tr>
            <tr><td>Civil Status</td><td>{$employee->basic_info.marital_status}</td></tr>
            <tr><td>Height (m)</td><td>{$employee->basic_info.height}</td></tr>
            <tr><td>Weight (kg)</td><td>{$employee->basic_info.weight}</td></tr>
            <tr><td>Blood Type</td><td>{$employee->basic_info.blood_type}</td></tr>
            <tr><td>Citizenship</td><td>{$employee->basic_info.citizenship}</td></tr>
            <tr><td>Residential Address</td><td>{$employee->basic_info.resadd_house_block_no}, {$employee->basic_info.resadd_street}</td></tr>
            <tr><td>Permanent Address</td><td>{$employee->basic_info.peradd_house_block_no}, {$employee->basic_info.peradd_street}</td></tr>
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
    <form action="{$server}{if $user.is_admin}/employees/save/{$employee->id}{else}/save{/if}" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
        <input type="hidden" name="employeeinfo[no]" value="{$employee->basic_info.no}">
        <input type="hidden" name="employeeinfo[employee_id]" value="{$employee->basic_info.employee_id}">
        <input type="hidden" name="employeeinfo[employee_picture]" value="{$employee->basic_info.employee_picture}">
        <div class="form-group row btn-square">
            <div class="row">
                <div class="col-sm-12 col-lg-4 col-md-4 mb-4 text-center btn-square">
                    <div class="form-group">
                        <div style="text-align: center; border: 2; width: 100%; align-content: center" id="thumb-output">
                            <img style="text-align: center; border: 1;" src="img/profile_temp.jpeg"  >
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="file" id="file-input" class="" name="profile_picture" value="img/profile_temp.jpeg" style="width:13rem">
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
                        <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="employeeinfo[citizenship]">
                            <option value="" disabled selected="">Select Citizenship</option>
                            <option value="Filipino" {if $employee->basic_info.citizenship == "Filipino"} selected {/if}>Filipino</option>
                            <option value="Dual Citizenship - by birth">Dual Citizenship - by birth</option>
                            <option value="Dual Citizenship - by naturalization">Dual Citizenship - by naturalization</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label" for="civil_stat">Pls. indicate country</label>
                        <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="marital_stat">
                            <option value="" disabled selected="">Select Country</option>
                            <option value="Afganistan">Afganistan</option>
                            <option value="America">America</option>
                        </select>
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
                        <input readonly class="form-control" type="text" name="employeeinfo[blood_type]" value="{$employee->basic_info.blood_type}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">GSIS ID No.</label>
                        <input readonly type="text" class="form-control" name="employeeinfo[gsis_no]" value="{$employee->basic_info.gsis_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">PAG-IBIG ID No.</label>
                        <input readonly class="form-control" type="text" name="employeeinfo[pagibig_no]" value="{$employee->basic_info.pagibig_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">PHILHEALTH No.</label>
                        <input readonly class="form-control" type="text" name="employeeinfo[philhealth_no]" value="{$employee->basic_info.philhealth_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">SSS No.</label>
                        <input readonly  type="text" class="form-control" name="employeeinfo[sss_no]" value="{$employee->basic_info.sss_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">TIN No.</label>
                        <input readonly class="form-control" type="text" name="employeeinfo[tin_no]" value="{$employee->basic_info.tin_no}">
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