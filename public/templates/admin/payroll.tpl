{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <div class="row row-cards">
            <div class="col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-body">
                        <form action="" method="POST">
                            <input type="hidden" name="action" value="init_payroll">                        
                            <div class="form-group">
                                <label class="form-label">Payroll Type:</label>
                                <select name="payroll[type]" class="form-control custom-select">
                                    <option value="1" selected="">Regular Payroll</option>
                                    <option value="2">Differential</option>
                                    <option value="3">Special Payroll</option> 
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Set Period:</label>
                                <div class="row">
                                    <select name="payroll[month]" class="col-md-6 form-control custom-select ml-3">
                                        <option value="" selected="" disabled="">Month</option>
                                        {include file="custom/select_month.tpl"}
                                    </select>
                                    <input name="payroll[year]" type="number" class="col-md-4 ml-4 form-control" placeholder="Year" value="{date('Y')}">
                                </div>
                            </div>
                            <div class="form-group">
                                <select name="payroll[range]" class="form-control custom-select">
                                    <option value="0">1-15</option>
                                    <option value="1">16-31</option>
                                    <option value="2">1-31</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Employee Type:</label>
                                <select name="payroll[emp_type]" class="form-control custom-select">
                                    <option value="1" {if $init == '1'}selected{/if}>Regular Employees</option>
                                    <option value="3" {if $init == '3'}selected{/if}>Casual Employees</option>
                                    <option value="5" {if $init == '5'}selected{/if}>COS Instructor Employees</option>
                                    <option value="6" {if $init == '6'}selected{/if}>Job-Order Employees</option>
                                    <option value="7" {if $init == '7'}selected{/if}>Project-Based Employees</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <input type="submit" name="init_payroll" class="btn btn-primary" value="Initialize Payroll" style="width: 100%;">
                            </div>
                            <div class="form-group">
                                <input type="submit" name="clear_payroll" class="btn btn-secondary" value="Clear" style="width: 100%;">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-5 col-lg-9">
                {include file = "admin/payroll/init_payroll.tpl"}
            </div>
        </div>
    </div>
</div>
{/block}