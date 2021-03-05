<div class="modal fade margin-top-70" id="set_leave_credits" role="dialog" tabindex="-1" style="margin-left:-50px;">
  <div class="modal-dialog modal-side modal-bottom-right modal-notify modal-danger" role="document" style="max-width: 600px;">
    <!--Content-->
    <div class="modal-content">
      <!--Header-->
      <div class="card" style="margin-bottom: 0">
        <div class="card-header">
          <h3 class="card-title">Set Employee's Leave Credits</h3>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-3">
              <p class="text-center">
                <img class="avatar avatar-xxl" id="slc_pic" src="/assets/employee_picture/0.jpeg"></img>
              </p>
            </div>

            <div class="col-9">
              <div class="fetch-data">
                <label class="form-label">Name</label>
                <select name="emp_id" id="emp_info" class="form-control custom-select" onchange="javascript:change_emp(this.value)">
                    <option selected disabled>Select employee</option>
                    {foreach $emp_list as $emp}
                    <option value="{$emp.no};{$emp.employee_picture};{$emp.name};{$emp.position_desc};{$emp.department_desc};slc_">{$emp.name}</option>
                    {/foreach}
                </select>
                <label class="form-label">Position</label><input type="text" id="slc_position" class="form-control" value="" readonly>
                <label class="form-label">Office</label><input type="text" id="slc_department" class="form-control" value="" readonly>
              </div>
            </div>
          </div>
          <hr />
          <form action="/leave" method="POST">
            <input type="hidden" name="action" value="set_leave_credits">
            <input type="hidden" name="slc[employee_id]" id="slc_emp_id" value="">
            <div class="form-group">
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">Vacation Leave Credits</label>{literal}<input class="form-control" name="slc[vacation]" value="" pattern="^-?\d*(\.\d{0,9})?$" required>{/literal}
                </div>
                <div class="col-md-6">
                  <label class="form-label">Sick Leave Credits</label>{literal}<input class="form-control" name="slc[sick]" value="" pattern="^\d*(\.\d{0,9})?$" required>{/literal}
                </div>
              </div>
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">Effectivity Date</label><input type="date" class="form-control" name="slc[date_credited]" value="" required>
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