{$emp = $emp[0]}
{if $view != "update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}{if $user.is_admin}/employees/update/{$employee.employee_id}{else}/update{/if}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    <div class="table-responsive">
        <table class="table card-table table-striped">
            <tr class="row-header"><td colspan="2">Personal Information</td></tr>
            <tr><td>Name</td><td>{$emp.first_name} {$emp.middle_name} {$emp.last_name}</td></tr>
            <tr><td>Birthdate</td><td>{$emp.birthdate}</td></tr>
            <tr><td>Birthplace</td><td>{$emp.birthplace}</td></tr>
            <tr><td>Sex</td><td>{$emp.gender}</td></tr>
            <tr><td>Civil Status</td><td>{$emp.marital_status}</td></tr>
            <tr><td>Height (m)</td><td>{$emp.height}</td></tr>
            <tr><td>Weight (kg)</td><td>{$emp.weight}</td></tr>
            <tr><td>Blood Type</td><td>{$emp.blood_type}</td></tr>
            <tr><td>Citizenship</td><td>{$emp.citizenship}</td></tr>
            <tr><td>Residential Address</td><td>{$emp.resadd_house_block_no}, {$emp.resadd_street}</td></tr>
            <tr><td>Permanent Address</td><td>{$emp.peradd_house_block_no}, {$emp.peradd_street}</td></tr>
            <tr class="row-header"><td colspan="2">Other Information</td></tr>
            <tr><td>GSIS ID No</td><td>{$emp.gsis_no}</td></tr>
            <tr><td>PAG-IBIG ID No</td><td>{$emp.pagibig_no}</td></tr>
            <tr><td>SSS No</td><td>{$emp.sss_no}</td></tr>
            <tr><td>TIN No</td><td>{$emp.tin_no}</td></tr>
            <tr><td>Agency Employee No</td><td>{$emp.employee_id}</td></tr>
            <tr><td>Telephone No</td><td>{$emp.telephone_no}</td></tr>
            <tr><td>Mobile No</td><td>{$emp.cellphone_no}</td></tr>
            <tr><td>E-mail Address</td><td>{$emp.email_address}</td></tr>
        </table>
    </div>
{else}
    <form action="{$server}{if $user.is_admin}/employees/save/{$employee.employee_id}{else}/save{/if}" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
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
                                <input type="text" class="form-control" name="employeeinfo[FirstName]" value="{$emp.first_name}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group">
                                <label class="form-label">Middle Name</label>
                                <input type="text" class="form-control" name="employeeinfo[MiddleName]" value="{$emp.middle_name}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group">
                                <label class="form-label">Last Name</label>
                                <input type="text" class="form-control" name="employeeinfo[LastName]" value="{$emp.last_name}">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group">
                                <div class="label-floating">
                                    <label class="form-label">Extension Name (Jr,Sr)</label>
                                    <input type="text" class="form-control" name="employeeinfo[ExtName]" value="{$emp.ext_name}">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class=" label-floating">
                                <label class="form-label" for="gender">Gender</label>
                                <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="employeeinfo[Gender]">
                                    <option value="" disabled></option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <div class="form-group label-floating">
                                <label class="form-label">Birthday</label>
                                <input type="date" class="form-control" name="employeeinfo[BirthDate]" value="{$emp.birthdate}" max="">
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="form-group label-floating">
                                <label class="form-label">Birthplace</label>
                                <input type="text" class="form-control" name="employeeinfo[BirthPlace]" value="{$emp.birthplace}">
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
                        <input type="text" class="form-control" name="employeeinfo[resadd_house_block_no]" value="{$emp.resadd_house_block_no}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Street</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_street]" value="{$emp.resadd_street}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Subdivision/Village</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_sub_village]" value="{$emp.resadd_sub_village}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Barangay</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_brgy]" value="{$emp.resadd_brgy}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">City/Municipality</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_mun_city]" value="{$emp.resadd_mun_city}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Province</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_province]" value="{$emp.resadd_province}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">ZIP Code</label>
                        <input type="text" class="form-control" name="employeeinfo[resadd_zip_code]" value="{$emp.resadd_zip_code}">
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <label class="form-label form-label-main">PERMANENT ADDRESS</label>
                </div>
                <hr style="width: 100%; margin: 5px 1px;">
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">House/Block/Lot No.</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_house_block_no]" value="{$emp.peradd_house_block_no}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Street</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_street]" value="{$emp.peradd_street}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Subdivision/Village</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_sub_village]" value="{$emp.peradd_sub_village}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Barangay</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_brgy]" value="{$emp.peradd_brgy}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">City/Municipality</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_mun_city]" value="{$emp.peradd_mun_city}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">Province</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_province]" value="{$emp.peradd_province}">
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="form-group label-floating">
                        <label class="form-label">ZIP Code</label>
                        <input type="text" class="form-control" name="employeeinfo[peradd_zip_code]" value="{$emp.peradd_zip_code}">
                    </div>
                </div>

                <div class="col-lg-12 col-md-12 col-sm-12">
                    <label class="form-label form-label-main">OTHER INFORMATION</label>
                </div>
                <hr style="width: 100%; margin: 10px 1px;">
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label" for="civil_stat">Marital Status</label>
                        <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="employeeinfo[MaritalStatus]">
                            <option value="" disabled>Civil Status</option>
                            <option value="Single" {if $emp.marital_status == 'Single'} selected {/if}>Single</option>
                            <option value="Married" {if $emp.marital_status == 'Married'} selected {/if}>Married</option>
                            <option value="Widowed" {if $emp.marital_status == 'Widowed'} selected {/if}>Widowed</option>
                            <option value="Separated" {if $emp.marital_status == 'Separated'} selected {/if}>Separated</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label" for="civil_stat">Citizenship</label>
                        <select  class="selectpicker form-control" data-style="btn btn-success btn-round" name="employeeinfo[Citizenship]">
                            <option value="" disabled selected="">Select Citizenship</option>
                            <option value="Filipino" {if $emp.citizenship == "Filipino"} selected {/if}>Filipino</option>
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
                        <input  type="text"  class="form-control" name="employeeinfo[Height]" value="{$emp.height}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Weight (kg)</label>
                        <input class="form-control" type="text" name="employeeinfo[Weight]" value="{$emp.weight}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Blood Type</label>
                        <input readonly class="form-control" type="text" name="employeeinfo[BloodType]" value="{$emp.blood_type}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">GSIS ID No.</label>
                        <input readonly type="text" class="form-control" name="employeeinfo[GSISNo]" value="{$emp.gsis_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">PAG-IBIG ID No.</label>
                        <input readonly class="form-control" type="text" name="employeeinfo[PagibigNo]" value="{$emp.pagibig_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">PHILHEALTH No.</label>
                        <input readonly class="form-control" type="text" name="employeeinfo[PhilhealthNo]" value="{$emp.philhealth_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">SSS No.</label>
                        <input readonly  type="text" class="form-control" name="employeeinfo[SSSNo]" value="{$emp.sss_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">TIN No.</label>
                        <input readonly class="form-control" type="text" name="employeeinfo[TINNo]" value="{$emp.tin_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Agency Employee No.</label>
                        <input readonly class="form-control" type="text" value="{$emp.employee_id}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Email Address</label>
                        <input type="email"  class="form-control" name="employeeinfo[EmailAddress]" value="{$emp.email_address}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Mobile Number</label>
                        <input class="form-control bfh-phone" type="tel" name="employeeinfo[CellphoneNo]" pattern="^(?:0|\(?\+63\)?\s?)[9](\d){9}$"  name="employeeinfo[CellphoneNo]" value="{$emp.cellphone_no}">
                    </div>
                </div>
                <div class="col-sm-12 col-lg-4">
                    <div class="form-group label-floating">
                        <label class="form-label">Telephone Number</label>
                        <input class="form-control bfh-phone" type="tel" name="employeeinfo[TelephoneNo]"  name="employeeinfo[TelephoneNo]" value="{$emp.telephone_no}">
                    </div>
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