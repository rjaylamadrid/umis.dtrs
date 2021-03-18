<div class="modal fade margin-top-70" id="view_leave_record" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-side modal-bottom-right modal-notify modal-danger" role="document" style="max-width: 1200px;">
    <!--Content-->
        <div id="cover-spin2" style="display: none; position:absolute;" class="spinner1"></div>
        <div class="modal-content">
      <!--Header-->
            <div class="card" style="margin-bottom: 0">
                <div class="card-header">
                    <h3 class="card-title">Employee's Leave Record Card</h3>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-3">
                            <p class="text-center" style="margin-top:1rem;">
                                <img class="avatar avatar-xxl" id="fl_pic" src="/assets/employee_picture/0.jpeg" style="width: 10rem; height: 10rem;"></img>
                            </p>
                        </div>

                        <div class="col-9">
                            <div class="fetch-data">
                                <label class="form-label">Name</label>
                                <select name="emp_id" id="emp_info" class="form-control custom-select" onchange="javascript:view_leave_record(this.value)">
                                    <option selected disabled>Select employee</option>
                                    {foreach $emp_list[1] as $emp}
                                    <option value="{$emp.no};{$emp.employee_picture};{$emp.name};{$emp.position_desc};{$emp.department_desc};fl_;{$emp.salary}">{$emp.name}</option>
                                    {/foreach}
                                </select>
                                <label class="form-label">Position</label><input type="text" id="fl_position" class="form-control" value="" readonly>
                                <label class="form-label">Office</label><input type="text" id="fl_department" class="form-control" value="" readonly>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div id="leave-record-card">
                    
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div><!--/.Content-->
            </div>
        </div>
    </div>
</div>