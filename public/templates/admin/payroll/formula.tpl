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
                <div class="d-flex" onclick="javascript:collapse('deduction')">
                    <label class="card-title mb-0">DEDUCTION</label>
                    <span class="ml-auto"><i class="deduction fe fe-chevron-up"></i></span>
                </div>
                {menu data = $deduction level='deduction'}
            </div>
        </div>
        <div class="card mb-2">
            <div class="card-body py-3">
                <div class="d-flex" onclick="javascript:collapse('employer-share')">
                    <label class="card-title mb-0">EMPLOYER-SHARE</label>
                    <span class="ml-auto"><i class="employer-share fe fe-chevron-up"></i></span>
                </div>
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