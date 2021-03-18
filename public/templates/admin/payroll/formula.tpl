{* {include file = "admin/payroll/header.tpl"} *}
{* {* {function name=menu level=0} *}
{function menu}
    <div class="collapse" id="{$level}">
        <div class="custom-controls-stacked">
            {foreach $data as $entry}
                {if is_array($entry)}
                    <label class="custom-control pt-1" onclick="javascript:collapse('{$entry@key}')">
                        <span class="mr-2"><i class="{$entry@key} fe fe-chevron-right"></i></span>{$entry@key}
                    </label>
                    {menu data=$entry level=$entry@key}
                {else}
                    <label class="custom-control pt-1">
                        {$entry}
                    </label>
                {/if}
            {/foreach}
            <label class="custom-control">
                <span class=""><i class="fe fe-plus"></i></span> Add
            </label>
        </div>
    </div>
{/function}
<div class=row>
    <div class = "col-md-8">
        <div class="card mb-2">
            <div class="card-body py-3">
                <label class="card-title mb-0" onclick="javascript:collapse('compensation')"><span class="mr-2"><i class="compensation fe fe-chevron-down"></i></span>COMPENSATION</label>
                {menu data = $compensation level='compensation'}
            </div>
        </div>
        <div class="card mb-2">
            <div class="card-body py-3">
                <div>
                    <label class="card-title mb-0">DEDUCTION</label>
                    <div class="float-right">
                        <span class=""><i class="fe fe-chevron-up"></i></span>
                    </div>
                </div>
                <div class="collapse" id="deduction">
                </div>
            </div>
        </div>
        <div class="card mb-2">
            <div class="card-body py-3">
                <div>
                    <label class="card-title mb-0">EMPLOYER-SHARE</label>
                    <div class="float-right">
                        <span class=""><i class="fe fe-chevron-up"></i></span>
                    </div>
                </div>
                <div class="collapse" id="employer_share">
                </div>
            </div>
        </div>
    </div>
    <div class = "col-md-4">
        <div class = "card">
            <div class="card-body">
            </div>
        </div>
    </div>
</div>