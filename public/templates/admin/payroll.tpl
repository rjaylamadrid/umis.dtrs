{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container" id="settings_tab">
        {include file="admin/payroll/{$tab}.tpl"}
    </div>
</div>
{/block}