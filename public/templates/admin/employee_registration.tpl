{extends file="layout.tpl"}
{block name="content"}
<div class="my-3 my-md-5">
          
    <div class="container center align-content-center">     
        <div class="row row-cards row-deck">
        <div class="col-sm-10 m-auto">
            {if $message}<div class="alert card-alert {if $message.success}alert-success{else}alert-danger{/if} alert-dismissible">
                <button type="button" class="close" data-dismiss="alert"></button>
                <i class="fe {if $message.success}fe-check{else}fe-alert-triangle{/if} mr-2" aria-hidden="true"></i>{$message.message}
            </div>{/if}
            <div class="card ">
                <form class="user ml-5 mr-5" method="post" action="/employees" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="register">
                    <input type="hidden" name="emp[no]" value="{$no}">
                    <div class="card-body">
                        <h1 class="card-title">Employee Registration</h1>
                        <div class="row">
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                <label class="form-label">First Name</label>
                                <input type="text" required class="form-control" name="emp[first_name]" value="" required>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <label class="form-label">Middle Name</label>
                                <input type="text" class="form-control" name="emp[middle_name]" value="">
                            </div>
                            <div class="col-lg-4 col-md-7 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Last Name</label>
                                    <input type="text" required class="form-control" name="emp[last_name]" value="" required>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-5 col-sm-12">
                                <div class="label-floating">
                                    <label class="form-label">Extension Name</label>
                                    <input type="text" class="form-control" name="emp[ext_name]" value="">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">E-mail Address</label>
                                    <input required type="email" required class="form-control" name="emp[email_address]" value="">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12">
                                <div class="label-floating">
                                    <label class="form-label">Contact Number</label>
                                    <input class="form-control bfh-phone" type="tel" name="emp[cellphone_no]" value="">
                                </div>
                            </div>
                            <div class="col-lg-5 col-md-5 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" name="emp[birthdate]" max="<?php echo $date_now; ?>" required>
                                </div>
                            </div>
                            <div class="col-lg-7 col-md-7 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Place of Birth</label>
                                    <input type="text" class="form-control" name="emp[birthplace]">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label" for="gender">Sex</label>
                                    <select required class="selectpicker form-control" data-style="btn btn-success btn-round" name="emp[gender]" required>
                                        <option value="" selected="true" disabled>Select</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label" for="civil_stat">Civil Status</label>
                                    <select required class="selectpicker form-control" data-style="btn btn-success btn-round" name="emp[marital_status]" required>
                                        <option value="" selected="true" disabled>Select</option>
                                        <option value="Single">Single</option>
                                        <option value="Married">Married</option>
                                        <option value="Widowed">Widowed / Widower</option>
                                        <option value="Separated">Legally   Separated</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <label class="form-label form-label-main">EMPLOYMENT</label>
                                <label class="custom-switch pl-0">
                                    <input type="checkbox" name="new_employee" class="custom-switch-input" checked onchange="javascript:set_new(this.checked)">
                                    <span class="custom-switch-indicator"></span>
                                    <span class="custom-switch-description">New Employee</span>
                                </label>
                            </div>
                            <hr style="width: 100%; margin: 5px 1px;">
                            <div class="col-lg-3 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Employee ID No.</label>
                                    <input type="text" class="form-control" name="emp[employee_id]" value="{$id}" readonly id="employee_id" required>
                                </div>
                            </div>
                            <div class="col-lg-9 col-md-6 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Schedule</label>
                                    <select class="form-control" name="sched_code" required>
                                        <option selected disabled>Select</option>
                                        {foreach from = $schedules item = schedule}
                                            <option value = "{$schedule.sched_code}">{$schedule.sched_day} ({$schedule.sched_time})</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-7 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Department</label>
                                    <select class="form-control" name="emp_status[department_id]" required>
                                        <option selected disabled>Department</option>
                                        {foreach from = $departments item = department}
                                            <option value = "{$department.no}">{$department.department_desc}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-5 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Designation</label>
                                    <select class="form-control" name="emp_status[privilege]" required>
                                        <option selected disabled>Designation</option>
                                        {foreach from = $designations item = designation}
                                            <option value = "{$designation.priv_level}" {if $designation.priv_level == 0}selected{/if}>{$designation.priv_desc}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12">
                                <div class="row">
                                    <div class="col-md-6 col-sm-12">
                                        <div class="form-group label-floating">
                                            <label class="form-label">Date Hired (current position)</label>
                                            <input type="date" class="form-control" name="emp_status[date_start]" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <div class="form-group label-floating">
                                            <label class="form-label">Employment Status</label>
                                            <select class="form-control" name="emp_status[etype_id]" required onchange="javascript:init_pos (this.value)">
                                                <option selected disabled>Select</option>
                                                {foreach from=$emp_type item=type}
                                                <option value="{$type.id}">{$type.type_desc}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12 col-sm-12">
                                <div class="form-group label-floating">
                                    <label class="form-label">Position</label>
                                    <select class="form-control" name="emp_status[position_id]" id="positions" required>
                                        <option selected disabled>Select</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <div class="d-flex">
                            <a href="/employees" class="btn btn-link">Cancel</a>
                            <button type="submit" class="btn btn-primary ml-auto">Register</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        </div>
    </div>
</div>
{/block}