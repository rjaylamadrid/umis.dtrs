{if !$vw_formula}
<div class="card">
    <div class="card-body">
        <div class="col-lg-3 mb-4">
            <div class="form-group mb-2">
                <label class="form-label">Employee Status</label>
                <select name="payroll[emp_type]" class="form-control custom-select" id="emp_type" onchange="change_etype_formula()">
                    <option value="1">Regular Employees</option>
                    <option value="2">Casual Employees</option>
                    <option value="3">Job-Order Employees</option>
                    <option value="4">COS Instructor Employees</option>
                    <option value="5">Project-Based Employees</option>
                </select>
            </div>
        </div>
    </div>
</div>
<div id="formula_tab">
{/if}
    <div class ="row">
        {foreach $payroll as $fact}
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$fact.title}</h2>
                </div>
                <table class="table card-table">
                    <tbody>
                        {foreach $fact.data as $data}
                        <tr>
                            <td>{$data.code}</td>
                            <td class="text-right">
                                <a class="icon" href="javascript:void(0)">
                                    <i class="fe fe-edit"></i>
                                </a>
                            </td>
                        </tr>    
                        {/foreach}                 
                    </tbody>
                </table>
                
                <div class="card-footer">
                    <a href="javascript:add_payroll_data('{$fact.title}')" class="btn btn-block btn-primary">Add</a>
                </div>
            </div>
        </div>
        {/foreach}
    </div>
</div>
<div class="modal fade" id="add-payroll-modal" role="dialog">
</div>