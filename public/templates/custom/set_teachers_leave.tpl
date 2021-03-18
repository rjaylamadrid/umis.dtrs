<div class="modal fade margin-top-70" id="set_teachers_leave" role="dialog" tabindex="-1" style="margin-left:-50px;">
  <div class="modal-dialog modal-side modal-bottom-right modal-notify modal-danger" role="document" style="max-width: 600px;">
    <!--Content-->
    <div id="cover-spin4" style="display: none; position:absolute;" class="spinner4"></div>
    <div class="modal-content">
      <!--Header-->
      <div class="card" style="margin-bottom: 0">
        <div class="card-header">
          <h3 class="card-title">Set Teachers' Leave</h3>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-3">
              <p class="text-center">
                <img class="avatar avatar-xxl" id="tl_pic" src="/assets/employee_picture/0.jpeg"></img>
              </p>
            </div>

            <div class="col-9">
              <div class="fetch-data">
                <label class="form-label">Name</label>
                <select name="emp_id" id="emp_info" class="form-control custom-select" onchange="javascript:teachers_leave_change(this.value)">
                    <option value="0" selected>ALL TEACHERS</option>
                    {foreach $emp_list[2] as $emp}
                    <option value="{$emp.no};{$emp.employee_picture};{$emp.name};{$emp.position_desc};{$emp.department_desc};tl_;{$emp.salary}">{$emp.name}</option>
                    {/foreach}
                </select>
                <label class="form-label">Position</label><input type="text" id="tl_position" class="form-control" value="N/A" readonly>
                <label class="form-label">Office</label><input type="text" id="tl_department" class="form-control" value="N/A" readonly>
                <br />
                <div id="note"><i>Note: Selecting 'ALL TEACHERS' would not include those who incurred absences of more than 1.5 days, as they are not entitled to the proportional vacation pay (PVP).</i></div>
              </div>
            </div>
          </div>
          <hr />
          <form action="/leave" method="POST">
            <input type="hidden" name="action" value="set_teachers_leave">
            <input type="hidden" name="tl[employee_id]" id="tl_emp_id" value="0">
            <input type="hidden" name="tl[emp_salary]" id="tl_emp_salary" value="0">
            <input type="hidden" name="tl[lv_office]" id="tl_dept" value="0">
            <div class="form-group">
              <label class="form-label">Leave Type</label>
                <select name="tl[lv_type]" class="form-control custom-select" required>
                    <option selected disabled>Select type</option>
                    <option value="14">Summer Vacation (70 days paid leave for teachers incurring absences not more than 1.5 days)</option>
                    <option value="15">Christmas Vacation (14 days paid leave for teachers incurring absences not more than 1.5 days)</option>
                </select>
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">Start</label><input type="date" class="form-control" name="tl[lv_date_fr]" value="" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label">End</label><input type="date" class="form-control" name="tl[lv_date_to]" value="" required>
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