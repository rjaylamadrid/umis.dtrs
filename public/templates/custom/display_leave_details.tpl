<div class="modal fade margin-top-70" id="display_leave_details" role="dialog" tabindex="-1" style="margin-left:-50px;">
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
                <img class="avatar avatar-xxl" src="../<?php echo substr($requests[$i]['EmpPicture'], 14); ?>"></img>
              </p>
            </div>

            <div class="col-9">
              <div class="fetch-data"></div>
            </div>
          </div>
          <form action="" method="POST">
            <input type="hidden" name="id" value="1">
            <div class="form-group">
              <div class="form-label">Recommendation</div>
              <div class="custom-controls-stacked">
                <label class="custom-control custom-radio custom-control-inline">
                  <input id="approved" type="radio" class="custom-control-input opt_response" name="example-inline-radios" value="1">
                  <span class="custom-control-label">For Approval</span>
                </label>
                <label class="custom-control custom-radio custom-control-inline">
                  <input id="disapproved" type="radio" class="custom-control-input opt_response" onchange="disapp(this.form)" name="example-inline-radios" value="0">
                  <span class="custom-control-label">For Approval Due to</span>
                </label>
                <label class="custom-control custom-control-inline">
                  <input id="remarks" type="text" disabled class="form-control" name="remarks">
                </label>
              </div>

            </div>
            <div class="card-options" style="float: right;">
              <a href="#" class="btn btn-primary">Confirm</a>
              <a class="btn btn-secondary ml-2" data-dismiss="modal">Close</a>
            </div>
          </form>
        </div>
      </div>
    </div>
    <!--/.Content-->
  </div></div>

</div>
</div>