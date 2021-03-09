<div class="modal fade margin-top-70" id="set_forced_leave" role="dialog" tabindex="-1" style="margin-left:-50px;">
  <div class="modal-dialog modal-side modal-bottom-right modal-notify modal-danger" role="document" style="max-width: 600px;">
    <!--Content-->
    <div id="cover-spin" style="display: none; position:absolute;" class="spinner1"></div>
    <div class="modal-content">
      <!--Header-->
      <div class="card" style="margin-bottom: 0">
        <div class="card-header">
          <h3 class="card-title">Set Forced Leave</h3>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-3">
              <p class="text-center">
                <img class="avatar avatar-xxl" id="fl_pic" src="/assets/employee_picture/0.jpeg"></img>
              </p>
            </div>

            <div class="col-9">
              <div class="fetch-data">
                <label class="form-label">Name</label>
                <select name="emp_id" id="emp_info" class="form-control custom-select" onchange="javascript:forced_leave_change(this.value)">
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
          <form action="/leave" method="POST">
            <input type="hidden" name="action" value="set_forced_leave">
            <input type="hidden" name="fl[employee_id]" id="fl_emp_id" value="">
            <input type="hidden" name="fl[emp_salary]" id="fl_emp_salary" value="">
            <input type="hidden" name="fl[lv_office]" id="fl_dept" value="">
            <div class="form-group">
              <div class="row" id="leave-credits">
              </div>
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">Start</label><input type="date" class="form-control" name="fl[lv_date_fr]" value="" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label">End</label><input type="date" class="form-control" name="fl[lv_date_to]" value="" required>
                </div>
              </div>
            </div>
        </div>
      </div>
      <div class="modal-footer">
      {* <button class="btn btn-primary" onclick="javascript:save_leave_credits()">Save</button> *}
        <input type="submit" class="btn btn-primary" value="Save">
        <button class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </form>
    </div><!--/.Content-->
  </div>
</div>