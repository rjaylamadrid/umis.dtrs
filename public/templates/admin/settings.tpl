{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <div class="row">
          	<div class="col-md-3"><h3 class="page-title mb-5">System Settings</h3><div>
          	<div class="list-group list-group-transparent mb-0">
                <a href="/settings" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == "general"}active{/if}"><span class="icon mr-3"><i class="fe fe-settings"></i></span>General</a>
          		<a href="/settings/connection" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == "connection"}active{/if}"><span class="icon mr-3"><i class="fe fe-inbox"></i></span>Connection</a>
                <a href="/settings/salary-grade" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == "salary-grade"}active{/if}"><span class="icon mr-3"><i class="fe fe-send"></i></span>Salary Grade</a>
                <a href="/settings/payroll" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == "payroll"}active{/if}"><span class="icon mr-3"><i class="fe fe-send"></i></span>Payroll</a>
                <a href="/settings/position" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == "position"}active{/if}"><span class="icon mr-3"><i class="fe fe-send"></i></span>Position</a>
                <a href="/settings/w-tax" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == "w-tax"}active{/if}"><span class="icon mr-3"><i class="fe fe-send"></i></span>Withholding Tax</a>
          	</div>
        </div>
    </div>
    <div class="col-md-9">
        <div class="card">
          	<div class="card-body" id="setting">
          		{include file="admin/settings/{$tab}.tpl"}
          	</div>
        </div>
    </div>
</div>
</div>
{/block}