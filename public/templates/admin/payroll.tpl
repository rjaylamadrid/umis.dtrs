{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <div class="row">
          	<div class="col-md-3">
                <h3 class="page-title mb-5">Payroll</h3>
                <div class="list-group mb-0">
                    <a href="/payroll/reports" class="list-group-item list-group-item-action d-flex align-items-center py-2 {if $tab == "reports"}active{/if}">Reports</a>
                    <a href="/payroll/payslip" class="list-group-item list-group-item-action d-flex align-items-center py-2 {if $tab == "payslip"}active{/if}">Payslip</a>
                    <a href="/payroll/salary-grade" class="list-group-item list-group-item-action d-flex align-items-center py-2 {if $tab == "salary-grade"}active{/if}">Salary Grade</a>
                    <a href="/payroll/formula" class="list-group-item list-group-item-action d-flex align-items-center py-2 {if $tab == "formula"}active{/if}">Formula</a>
                    <a href="/payroll/new-payroll" class="list-group-item list-group-item-action d-flex align-items-center py-2 {if $tab == "new-payroll"}active{/if}">New Payroll</a>
                </div>
                <form action="" method="POST">
                    <input type="hidden" name="action" value="download_payroll">
                    <button class="btn btn-primary">Download Payroll</button>
                </form>
            <div>
        </div>
    </div>
    <div class="col-md-9" id="settings_tab">
        {include file="admin/payroll/{$tab}.tpl"}
    </div>
</div>
</div>
{/block}