{extends file="layout.tpl"}
{block name="content"}
<div class="my-3 my-md-5">
    <div class="container center align-content-center">     
        <div class="page-header">
            <h1 class="page-title"><?php echo "Register Employee "//. ucfirst ($frm['a']); ?></h1>
        </div>
        <div class="row row-cards row-deck">
        <div class="col-sm-10 m-auto">
            <div class="card ">
                <form class="user ml-5 mr-5" method="post" action="" enctype="multipart/form-data">
                    <div class="card-body">
                        <h1 class="card-title">Register Employee</h1>
                        <div class="row">
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                <label class="form-label">First Name</label>
                                <input type="text" required class="form-control" name="emp[FirstName]" value="">
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <label class="form-label">Middle Name</label>
                                <input type="text" class="form-control" name="emp[MiddleName]" value="">
                            </div>
                            <div class="col-lg-4 col-md-7 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Last Name</label>
                                    <input type="text" required class="form-control" name="emp[LastName]" value="">
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-5 col-sm-12">
                                <div class="label-floating">
                                    <label class="form-label">Extension Name</label>
                                    <input type="text" class="form-control" name="emp[ExtName]" value="">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Email Address</label>
                                    <input required type="email" required class="form-control" name="emp[EmailAddress]" value="">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12">
                                <div class="label-floating">
                                    <label class="form-label">Contact Number</label>
                                    <input class="form-control bfh-phone" type="tel" name="emp[CellphoneNo]" value="">
                                </div>
                            </div>
                            <div class="col-lg-5 col-md-5 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Birthday</label>
                                    <input type="date" class="form-control" name="emp[BirthDate]" max="<?php echo $date_now; ?>">
                                </div>
                            </div>
                            <div class="col-lg-7 col-md-7 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Birthplace</label>
                                    <input type="text" class="form-control" name="emp[BirthPlace]">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label" for="gender">Gender</label>
                                    <select required class="selectpicker form-control" data-style="btn btn-success btn-round" name="emp[Gender]">
                                        <option value="" selected="true" disabled>Gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label" for="civil_stat">Marital Status</label>
                                    <select required class="selectpicker form-control" data-style="btn btn-success btn-round" name="emp[MaritalStatus]">
                                        <option value="" selected="true" disabled>Civil Status</option>
                                        <option value="Single">Single</option>
                                        <option value="Married">Married</option>
                                        <option value="Widowed">Widowed</option>
                                        <option value="Separated">Separated</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <label class="form-label form-label-main">EMPLOYMENT</label>
                                <label class="custom-switch pl-0">
                                    <input type="checkbox" name="new_employee" class="custom-switch-input">
                                    <span class="custom-switch-indicator"></span>
                                    <span class="custom-switch-description">New Employee</span>
                                </label>
                            </div>
                            <hr style="width: 100%; margin: 5px 1px;">
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Employee ID No.</label>
                                    <input type="text" class="form-control" name="employee_status[employee_id]" value="">
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Schedule</label>
                                    <select class="form-control" name="">
                                        <option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-7 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Department</label>
                                    <input type="text" class="form-control" name="employee_status[employee_id]" value="">
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Designation</label>
                                    <select class="form-control" name="">
                                        <option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12">
                                <div class="row">
                                    <div class="col-md-6 col-sm-12">
                                        <div class="form-group label-floating">
                                            <label class="form-label">Date Hired (*current position)</label>
                                            <input type="date" class="form-control" name="employee_status['date_hired']">
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <div class="form-group label-floating">
                                            <label class="form-label">Employment Status</label>
                                            <select class="form-control" name="" required onchange="javascript:init_pos (this.value)">
                                                <option selected disabled>Employment Status</option>
                                                {foreach from=$emp_type item=type}
                                                <option value="{$type.etype_id}">{$type.etype_desc}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Position</label>
                                    <select class="form-control" name="" id="positions">
                                        <option selected disabled>Position</option>
                                        {foreach from=$positions item=position}
                                        <option value="{$position.no}">{$position.position_desc}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <div class="d-flex">
                            <a href="/employees" class="btn btn-link">Cancel</a>
                            <button type="submit" class="btn btn-primary ml-auto">Register Employee</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        </div>
    </div>
</div>
{/block}