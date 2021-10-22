<div class="modal-dialog" id="raw-data" role="document">
    <div class="modal-content" style="width: 28rem">
        <div class="card m-0">
            <div class="card-header">
                <h3 class="card-title"><label class="title"></label></h3>
            </div>
            <div class="card-body">
                <form method="POST" action="" id="add_payroll_data">
                    <input type="hidden" name="action" value="add_payroll_factor">
                    <input id="payroll_data_type" type="hidden" name="type" value="">
                    <input id="etype_id" type="hidden" name="etype_id" value="">
                    <div class="form-group">
                        <label class="form-label"><label class="title"></label> Code</label>
                        <input type="text" class="form-control col-md-5" name="code">
                    </div>
                    <div class="form-group">
                        <label class="form-label"><label class="title"></label>  Name</label>
                        <input type="text" class="form-control" name="name">
                    </div>
                    <div class="form-group">
                        <label class="form-label"><div class=""></div>Computation Type</label>
                        <div class="custom-controls-stacked">
                            <label class="custom-control custom-radio custom-control-inline">
                                <input type="radio" class="custom-control-input" name="example-inline-radios" value="value" checked="" onclick="change_type(this.value)">
                                <span class="custom-control-label">Value</span>
                            </label>
                            <label class="custom-control custom-radio custom-control-inline">
                                <input type="radio" class="custom-control-input" name="example-inline-radios" value="formula" onclick="change_type(this.value)">
                                <span class="custom-control-label">Formula</span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><div class=""></div>Computation Type</label>
                        <div class="custom-controls-stacked">
                            <label class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="example-radios" value="mandatory" checked="">
                                <div class="custom-control-label">Mandatory</div>
                            </label>
                            <label class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="example-radios" value="optional">
                                <div class="custom-control-label">Per Employee</div>
                            </label>
                        </div>
                    <div class="form-group">
                        <label class="form-label"><div class=""></div>Formula</label>
                        <input type="text" class="form-control" name="formula">
                    </div>
                    <div class="form-group">
                        <label class="form-label"><div class=""></div>Value</label>
                        <input type="text" class="form-control" name="value">
                    </div>
                    <div class="form-footer">
                        <a href="javascript:add_payroll_data('', true)" class="btn btn-block btn-primary">Save</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function change_type(btn) {
        console.log(btn);
    }
</script>