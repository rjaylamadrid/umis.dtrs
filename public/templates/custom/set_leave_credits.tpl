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
                <img class="avatar avatar-xxl" src="/assets/employee_picture/{$request.employee_picture}"></img>
              </p>
            </div>

            <div class="col-9">
              <div class="fetch-data">
                <label class="form-label">Name</label>
                <select name="emp_id" class="form-control custom-select" onchange="javascript:change_emp(this.value)">
                    {foreach $emp_list as $emp}
                    <option value="{$emp}">{$emp.name}</option>
                    {/foreach}
                    {* <option value="{$server}/leave/0" {if $tab == '0'}selected{/if}>Pending</option>
                    <option value="{$server}/leave/1" {if $tab == '1'}selected{/if}>For Recommendation</option>
                    <option value="{$server}/leave/2" {if $tab == '2'}selected{/if}>Approved</option>
                    <option value="{$server}/leave/3" {if $tab == '3'}selected{/if}>Disapproved</option> *}
                </select>
                <label class="form-label">Position</label><input type="text" class="form-control" value="{$request.position_desc}" readonly>
                <label class="form-label">Office</label><input type="text" class="form-control" value="{$request.lv_office}" readonly>
              </div>
            </div>
          </div>
          <hr />
          <form action="/leave" method="POST">
            <input type="hidden" name="action" value="leaveRecommendation">
            <input type="hidden" name="hr_id" value="{$user.employee_id}">
            <input type="hidden" name="leave_id" value="{$request.leave_id}">
            <input type="hidden" name="emp_id" value="">
            {* <input type="hidden" name="leave_info[employee_id]" value="{$request.employee_id}"> *}
            <div class="form-group">
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">Vacation Leave Credits</label><input type="text" class="form-control" value="{$request.leave_desc}" readonly>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Sick Leave Credits</label><input type="text" class="form-control" value="{$request.leave_desc}" readonly>
                </div>
              </div>
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">Effectivity Date</label><input type="text" class="form-control" value="{$request.lv_date_fr|date_format:"F d, Y"}" readonly>
                </div>
              </div>
            </div>
        </div>
      </div>
      <div class="modal-footer">
      <input type="submit" class="btn btn-primary" value="Confirm">
      <button class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
    </form>
    </div><!--/.Content-->
    
  </div>
</div>