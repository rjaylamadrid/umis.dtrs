<div class="modal fade margin-top-70" id="set-employee-inactive-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Set as Inactive</h3>
                </div>
                <div class="card-body">
                    <form action="/employees" method="POST">
                        <input type="hidden" name="action" value="set_inactive">
                        <input type="hidden" name="emp_id" id="emp_id" value="">
                        <input type="hidden" name="status" id="status" value="">
                        <div class="row col-md-12">
                            <div class="form-group">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" name="emp_name" id="emp_name" value="" readonly>
                                <br />
                                <label class="form-label">Position</label>
                                <input type="text" class="form-control" name="emp_pos" id="emp_pos" value="" readonly>
                                <br />
                                <label class="form-label">Last Day of Service in the Previous Position</label>
                                <input type="date" class="form-control" name="date_end" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <span style="float: right;">
                            <input type="submit" class="btn btn-primary" value="Submit">
                            <a href="#" class="btn btn-secondary" data-dismiss="modal">Cancel</a>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>