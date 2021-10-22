<div class="row">
    <div class="col-lg-3 mb-4">
        <div class="card">
            <div class="card-body">
                <form action="/payroll" method="POST">
                    <div class="form-group mb-1">
                        <label class="form-label">Payroll Type</label>
                        <select name="payroll[type]" class="form-control custom-select" id="payroll_type">
                            <option value="1" selected="">Regular Payroll</option>
                            <option value="2">Differential</option>
                            <option value="3">Special Payroll</option> 
                        </select>
                    </div>
                    <div class="form-group mb-2">
                        <label class="form-label">Employee Status</label>
                        <select name="payroll[emp_type]" class="form-control custom-select" id="emp_type">
                            <option value="1">Regular Employees</option>
                            <option value="2">Casual Employees</option>
                            <option value="3">Job-Order Employees</option>
                            <option value="4">COS Instructor Employees</option>
                            <option value="5">Project-Based Employees</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Period Start</label>
                        <input type="date" name="payroll[date_from]" class="form-control" id="date_from">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Period End</label>
                        <input type="date" name="payroll[date_to]" class="form-control" id="date_to">
                    </div>
                    <input type="hidden" name="action" value="download_payroll">
                    <button class="btn btn-block btn-primary">Download Payroll</button>
                </form>
            </div>
        </div>
    </div>
    <div class="col-lg-9" id="settings_tab">
        <div class="card">
            <div class="card-body">
                <h3 class="card-title">Content</h3>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Compensation</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Deduction</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Employer Share</label>
                        </div>
                    </div>
                </div>
                <h3 class="card-title">Footer</h3>
                <div class="row">
                    <div class="col-md-4">
                        <fieldset class="form-fieldset">
                            <div class="form-group">
                                <label class="form-label">A</label>
                                <textarea class="form-control" name="example-textarea-input" rows="6" placeholder="Content..">CERTIFIED :Services have been rendered as stated :
                                </textarea>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Signatory</label>
                                <input class="form-control" type="text" value="Maria Minerva DLP. Aragon    ">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Position</label>
                                <input class="form-control" type="text" value="Administrative Officer IV">
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>