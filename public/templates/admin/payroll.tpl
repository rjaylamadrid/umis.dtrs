{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    {* <div class="container">
        <div class="row">
          	<div class="col-md-3">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title mb-3">Payroll Details</h3>
                        <div class="form-group">
                            <label class="form-label">Payroll Type</label>
                            <select name="payroll[type]" class="form-control custom-select">
                                <option value="1" selected="">Regular Payroll</option>
                                <option value="2">Differential</option>
                                <option value="3">Special Payroll</option> 
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Employee Type</label>
                            <select name="payroll[emp_type]" class="form-control custom-select">
                                <option value="1">Regular Employees</option>
                                <option value="2">Casual Employees</option>
                                <option value="3">Job-Order Employees</option>
                                <option value="4">COS Instructor Employees</option>
                                <option value="5">Project-Based Employees</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Set Period</label>
                            <div class="row">
                                <div class="col-md-6">
                                    <select name="payroll[month]" class="form-control custom-select">
                                    <option value="" selected="" disabled="">Month</option>
                                        {include file="custom/select_month.tpl"}
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <input name="payroll[year]" type="number" class="form-control" placeholder="Year" value="{date('Y')}">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <select name="payroll[range]" class="form-control custom-select">
                                <option value="0">1-15</option>
                                <option value="1">16-31</option>
                                <option value="2">1-31</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="list-group mb-0">
                    <a href="/payroll" class="list-group-item list-group-item-action py-2 {if $tab == "payroll"}active{/if}">Payroll Report</a>
                    <a href="/payroll/payslip" class="list-group-item list-group-item-action py-2 {if $tab == "payslip"}active{/if}">Payslip</a>
                    <a href="/payroll/salary-grade" class="list-group-item list-group-item-action py-2 {if $tab == "salary-grade"}active{/if}">Salary Grade</a>
                    <div>
                        <a href="javascript:show_settings()" class="list-group-item list-group-item-action py-2 {if $settings}sub-menu{/if}">Settings</a>
                        <div id="settings-menu" class="{if !$setting}collapse{/if}">
                            <a href="/payroll/formula" class="list-group-item list-group-item-action sub-menu py-2 {if $tab == "formula"}active{/if}">Formula</a>
                            <a href="/payroll/content" class="list-group-item list-group-item-action sub-menu py-2 {if $tab == "content"}active{/if}">Content</a>
                            <a href="/payroll/signatories" class="list-group-item list-group-item-action sub-menu py-2 {if $tab == "signatories"}active{/if}">Signatories</a>
                        </div>
                    </div>
                </div>
            <div>
        </div>
    </div>
    <div class="col-md-9" id="settings_tab">
        {include file="admin/payroll/{$tab}.tpl"}
    </div> *}
    <div class="container">
        <div class="row">
            <div class="col-lg-3 order-lg-1 mb-4">
                <div>
                    <div class="form-group mb-1">
                        <label class="form-label">Payroll Type</label>
                        <select name="payroll[type]" class="form-control custom-select">
                            <option value="1" selected="">Regular Payroll</option>
                            <option value="2">Differential</option>
                            <option value="3">Special Payroll</option> 
                        </select>
                    </div>
                    <div class="form-group mb-2">
                        <label class="form-label">Employee Type</label>
                        <select name="payroll[emp_type]" class="form-control custom-select">
                            <option value="1">Regular Employees</option>
                            <option value="2">Casual Employees</option>
                            <option value="3">Job-Order Employees</option>
                            <option value="4">COS Instructor Employees</option>
                            <option value="5">Project-Based Employees</option>
                        </select>
                    </div>
                </div>
                <a href="#" class="btn btn-block btn-primary mb-6">
                    Initialize Payroll Details
                </a>
                <div class="list-group list-group-transparent mb-0">
                    <a href="/payroll" class="list-group-item list-group-item-action {if $tab == "payroll"}active{/if}"><span class="icon mr-3"><i class="fe fe-book"></i></span>Reports</a>
                    <a href="/payroll/payslip" class="list-group-item list-group-item-action {if $tab == "payslip"}active{/if}"><span class="icon mr-3"><i class="fe fe-file-text"></i></span>Payslip</a>
                    <a href="/payroll/salary-grade" class="list-group-item list-group-item-action {if $tab == "salary-grade"}active{/if}"><span class="icon mr-3"><i class="fe fe-list"></i></span>Salary Grade</a>
                    <a href="/payroll/formula" class="list-group-item list-group-item-action {if $tab == "formula"}active{/if}"><span class="icon mr-3"><i class="fe fe-slack"></i></span>Formula</a>
                    <a href="/payroll/content" class="list-group-item list-group-item-action {if $tab == "content"}active{/if}"><span class="icon mr-3"><i class="fe fe-image"></i></span>Content</a>
                    <a href="/payroll/signatories" class="list-group-item list-group-item-action {if $tab == "signatories"}active{/if}"><span class="icon mr-3"><i class="fe fe-edit-3"></i></span>Signatories</a>
                </div>
            </div>
            <div class="col-lg-9" id="settings_tab">
                {include file="admin/payroll/{$tab}.tpl"}
            </div>
        </div>
    </div>
</div>
</div>
{/block}