{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <div class="row">
          	<div class="col-md-3">
                {* <h3 class="page-title mb-5">Payroll</h3> *}
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
    </div>
</div>
</div>
{/block}