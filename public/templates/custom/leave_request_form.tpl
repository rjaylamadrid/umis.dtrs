<div class="modal fade margin-top-70" id="leave-request-form" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" id="leave-request-modal" role="document" style="max-width: 1200px;">
        <div class="my-3 my-md-5">
            <div class="container">
                <div class="col-md-12">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Application for Leave</h4>
                        </div>

                        <div class="modal-body">
                            <form class="user" method="POST" action="/leave">
                            <input type="hidden" name="action" value="submitLeave">
                            <input type="hidden" name="leave_info[employee_id]" value="{$user.employee_id}">

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12">
                                    <div class="form-group">
                                        <label class="form-label">1) Office/Agency</label>
                                        <input style="color: black; text-align: left;" required type="text" readonly class="form-control" name="leave_info[lv_office]" value="{$office[0].department_desc}">
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-6 col-sm-12">
                                    <div class="form-group">
                                        <label class="form-label">2) Employee Name</label>
                                        <input style="color: black; text-align: left;" required type="text" disabled class="form-control" name="name" value="{$user.last_name}, {$user.first_name} {$user.middle_name}">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-4 col-md-4">
                                    <div class="form-group">
                                        <label>3) Date of Filing</label>
                                        <input readonly style="color: black; text-align: left;" required type="date"  class="form-control " name="leave_info[lv_dateof_filing]" value="{date('Y-m-d')}">
                                    </div>
                                </div>

                                <div class="col-lg-4 col-md-4">
                                    <div class="form-group">
                                        <label>4) Position</label>
                                        <input style="color: black; text-align: left;" required type="text" disabled class="form-control " name="position" value="{$position.position_desc}">
                                    </div>
                                </div>

                                <div class="col-lg-4 col-md-4">
                                    <div class="form-group">
                                        <label>5) Salary(monthly)</label>
                                        <input style="color: black; text-align: left;" readonly required type="" class="form-control " step="0.01" name="leave_info[emp_salary]" value="{$position.salary}">
                                    </div>
                                </div>
                            </div>

                            <hr>

                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label class="form-label">6. A) Type of Leave</label>
                                        <div class="custom-controls-stacked">
                                            <label class="custom-control custom-radio">
                                                <input required type="radio" id="vacation" class="custom-control-input radio_type" name="leave_info[lv_type]" value="1" onchange="javascript:toggle_options(1)">
                                                <div class="custom-control-label">Vacation Leave</div>
                                            </label>

                                            <div class="custom-controls-stacked" style="padding-left: 20px;">
                                                <label class="custom-control custom-radio">
                                                    <input required type="radio" id="seek_employment" class="custom-control-input radio_type" name="leave_info[lv_type_others]" value="To Seek Employment" onchange="javascript:toggle_other(2)">
                                                    <div class="custom-control-label">To Seek Employment</div>
                                                </label>
                                                <label class="custom-control custom-radio">
                                                    <input required type="radio" id="vacation_other" class="custom-control-input radio_type" name="leave_info[lv_type_others]" value="" onchange="javascript:toggle_other(1)">
                                                    <div class="custom-control-label">Other (Specify below)</div>
                                                </label>
                                                <input type="text" id="vacation_text" class="form-control ml-1" name="leave_info[lv_type_others]" value="">
                                            </div>

                                            <label class="custom-control custom-radio">
                                                <input required type="radio" id="sick" class="custom-control-input radio_type" name="leave_info[lv_type]" value="2" onchange="javascript:toggle_options(2)"><div class="custom-control-label">Sick Leave</div>
                                            </label>
                                            <label class="custom-control custom-radio">
                                                <input required type="radio" id="leave_type" onchange="javascript:toggle_options(3)" class="custom-control-input radio_type" name="leave_info[lv_type]" value="3"><div class="custom-control-label">Maternity</div>
                                            </label>
                                            <label class="custom-control custom-radio">
                                                <input required type="radio" id="leave_type" onchange="javascript:toggle_options(3)" class="custom-control-input radio_type" name="leave_info[lv_type]" value="4"><div class="custom-control-label">Paternity</div>
                                            </label>
                                            <label class="custom-control custom-radio">
                                                <input required type="radio" id="sick_others" onchange="javascript:toggle_options(4)" class="custom-control-input radio_type" name="leave_info[lv_type]" value="Other"><div class="custom-control-label">Other (Specify below)</div>
                                            </label>
                                            <select  id="other_type_text" required class="form-control" disabled="true" name="leave_info[lv_type_others]">
                                                <option selected value="" disabled>Select Type</option>
                                                    {foreach $leave_types as $types}
                                                        {if $types.id > 4}
                                                        <option value="{$types.id}">{$types.leave_desc}</option>
                                                        {/if}
                                                    {/foreach}
                                                </option>
                                            </select>
                                        </div>
                                    </div>                    
                                </div>

                                <div class="col-lg-4">
                                    <label>6. B) Where Leave will be spent</label>
                                    <div id="optionb">
                                        <label class="form-label"> (In case of Vacation Leave)</label>
                                        <label class="custom-control custom-radio">
                                            <input required type="radio" id="phonly" onchange="javascript:toggle_other(3)" class="custom-control-input radio_type" name="leave_info[lv_where]" value="Within the Philippines">
                                            <div class="custom-control-label">Within the Philippines</div>
                                        </label>

                                        <label class="custom-control custom-radio">
                                            <input required type="radio" id="abroad" onchange="javascript:toggle_other(4)" class="custom-control-input radio_type" name="leave_info[lv_where]" value="Abroad">
                                            <div class="custom-control-label">Abroad (Specify below)</div>
                                        </label>
                                        <input type="text" id="where_specific" required class="form-control ml-1" name="leave_info[lv_where_specific]">
                                        
                                        <label class="custom-control custom-radio"><input required type="radio" id="hospital" class="custom-control-input radio_type" name="leave_info[lv_where]" value="In Hospital">
                                            <div class="custom-control-label">in Hospital (Specify below)</div>
                                        </label>
                                        
                                        <label class="custom-control custom-radio">
                                            <input required type="radio" id="outpatient" class="custom-control-input radio_type" name="leave_info[lv_where]" value="Out Patient">
                                            <div class="custom-control-label">Out Patient (Specify below)</div>
                                        </label>
                                        <input type="text" id="where_specific" required class="form-control ml-1" value="" name="leave_info[lv_where_specific]">
                                    </div>

                                    <div class="form-group">
                                        <label class="text">Commutation</label>
                                        <div class="custom-controls-stacked">
                                            <label class="custom-control custom-radio">
                                                <input required type="radio" class="custom-control-input  radio_type" name="leave_info[lv_commutation]" value="Requested"><div class="custom-control-label">Requested</div>
                                            </label>
                                            <label class="custom-control custom-radio">
                                                <input required type="radio" class="custom-control-input  radio_type" name="leave_info[lv_commutation]" value="Not Requested"><div class="custom-control-label">Not Requested</div>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-4">
                                    <label>6. C) Number of Working Days Applied For</label>
                                    <input type="" name="leave_info[lv_no_days]" id="no_of_working_days" readonly min="1" max="10950" class="form-control" value="">
                                    <label>Inclusive Dates</label>
                                    <i>From</i>
                                    <input type="date" name="leave_info[lv_date_fr]" id="date_from" required class="form-control " onchange="javascript:dtmin(this.form); javascript:date_max(); javascript:date_min();" value="">
                                    <i>To</i>
                                    <input type="date" name="leave_info[lv_date_to]" id="date_to" required class="form-control "  onchange="javascript:dtmin(this.form); javascript:date_min(); javascript:date_max();" value="">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" value="Submit Request">
                                <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>