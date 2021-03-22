{function menu}
    <div class="collapse" id="{$level}">
        <div class="pl-5 custom-controls-stacked">
            {foreach $data as $entry}
                {if is_array($entry)}
                    <div class="d-flex" onclick="javascript:collapse('{$entry@key}')">
                        <label class="custom-control pt-1 pl-0">{$entry@key}</label>
                        <span class="ml-auto"><i class="{$entry@key} fe fe-chevron-up"></i></span>
                    </div>
                    {menu data=$entry level=$entry@key}
                {else}
                        <label class="custom-control pt-1 pl-0">{$entry}</label>
                {/if}
            {/foreach}
        </div>
    </div>
{/function}
<div class=row>
    <div class = "col-md-8">
        <div class="card mb-2">
            <div class="card-body py-3">
                <div class="d-flex" onclick="javascript:collapse('compensation')">
                    <label class="card-title mb-0">COMPENSATION</label>
                    <span class="ml-auto"><i class="compensation fe fe-chevron-up"></i></span>
                </div>
                {menu data = $compensation level='compensation'}
            </div>
        </div>
        <div class="card mb-2">
            <div class="card-body py-3">
                <label class="card-title mb-0" onclick="javascript:collapse('deduction')"><span class="mr-2"><i class="deduction fe fe-chevron-right"></i></span>DEDUCTION</label>
                {menu data = $deduction level='deduction'}
            </div>
        </div>
        <div class="card mb-2">
            <div class="card-body py-3">
                <label class="card-title mb-0" onclick="javascript:collapse('employer-share')"><span class="mr-2"><i class="employer-share fe fe-chevron-right"></i></span>EMPLOYER-SHARE</label>
                {menu data = $employer_share level='employer-share'}
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