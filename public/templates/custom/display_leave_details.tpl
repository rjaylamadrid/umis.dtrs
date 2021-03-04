{foreach $requests as $request}
<div class="modal fade margin-top-70" id="display_leave_details{$request.leave_id}" role="dialog" tabindex="-1" style="margin-left:-50px;">
  <div class="modal-dialog modal-side modal-bottom-right modal-notify modal-danger" role="document" style="max-width: 600px;">
    <!--Content-->
    <div class="modal-content">
      <!--Header-->
      <div class="card" style="margin-bottom: 0">
        <div class="card-header">
          <h3 class="card-title">Leave Application Details</h3>
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
                <label class="form-label">Name</label><input type="text" class="form-control" value="{$request.name}" readonly>
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
            {* <input type="hidden" name="leave_info[employee_id]" value="{$request.employee_id}"> *}
            <div class="form-group">
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">Leave Type</label><input type="text" class="form-control" value="{$request.leave_desc}" readonly>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Commutation</label><input type="text" class="form-control" value="{$request.lv_commutation}" readonly>
                </div>
              </div>
              {if $request.lv_no_days > 1}
              <label class="form-label">Number of Working Days Applied for</label><input type="text" class="form-control" value="{$request.lv_no_days} days" readonly>
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">From</label><input type="text" class="form-control" value="{$request.lv_date_fr|date_format:"F d, Y"}" readonly>
                </div>
                <div class="col-md-6">
                  <label class="form-label">To</label><input type="text" class="form-control" value="{$request.lv_date_to|date_format:"F d, Y"}" readonly>
                </div>
              </div>
              {else}
              <div class="row">
                <div class="col-md-6">
                  <label class="form-label">Date</label><input type="text" class="form-control" value="{$request.lv_date_fr|date_format:"F d, Y"}" readonly>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Number of Working Days Applied for</label><input type="text" class="form-control" value="1 day" readonly>
                </div>
              </div>
              {/if}
              <label class="form-label">Where Leave will be Spent</label><input type="text" class="form-control" value="{$request.lv_where} {if $request.lv_where_specific} ({$request.lv_where_specific}) {/if}" readonly>
              <hr />
              
              {if $request.lv_status > 0}
              <div class="form-label">Status</div>
              <div class="row">
                <div class="col-md-12 align-center ml-5 pl-5 br-5">
                    <div class="selectgroup selectgroup-pills">
                      <label class="selectgroup-item">
                        <input type="checkbox" name="" value="" class="selectgroup-input" {if $request.lv_status == 1} checked {/if} disabled>
                        <span class="selectgroup-button" {if $request.lv_status == 1} style="color:#5eba00; border-color:#5eba00; background:#5eba001c;"{/if}>For Approval</span>
                      </label>
                      <label class="selectgroup-item">
                        <input type="checkbox" name="" value="" class="selectgroup-input" {if $request.lv_status == 2} checked {/if} disabled>
                        <span class="selectgroup-button">Approved</span>
                      </label>
                      <label class="selectgroup-item">
                        <input type="checkbox" name="" value="" class="selectgroup-input" {if $request.lv_status == 3} checked {/if} disabled>
                        <span class="selectgroup-button" {if $request.lv_status == 3} style="color:darkred; border-color:darkred; background:#cd201f29; {/if}">Disapproved</span>
                      </label>
                    </div>
                  </div>
                </div>
              {else}
              <div class="form-label">Recommendation</div>
              <div class="custom-controls-stacked">
                <label class="custom-control custom-radio custom-control-inline">
                  <input id="approved" type="radio" class="custom-control-input opt_response" name="recommendation" value="1" onclick="disapp(this.form)" required>
                  <span class="custom-control-label">For Approval</span>
                </label>
                <label class="custom-control custom-radio custom-control-inline">
                  <input id="disapproved" type="radio" class="custom-control-input opt_response" onclick="disapp(this.form)" name="recommendation" value="3" required>
                  <span class="custom-control-label">Disapprove due to</span>
                </label>
                <label class="custom-control custom-control-inline">
                  <input id="remarks" type="text" disabled="true" class="form-control" name="remarks" required>
                </label>
              </div>
              {/if}
            </div>
            {* <div class="card-options" style="float: right;">
              <a href="#" class="btn btn-primary">Confirm</a>
              <a class="btn btn-secondary ml-2" data-dismiss="modal">Close</a>
            </div> *}
          
        </div>
      </div>
      <div class="modal-footer">
      {if $request.lv_status == 0}<input type="submit" class="btn btn-primary" value="Confirm">{/if}
      <button class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
    </form>
    </div><!--/.Content-->
    
  </div>
</div>
{/foreach}