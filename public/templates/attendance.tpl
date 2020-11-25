{if $user.is_admin}
{include file="admin/attendance.tpl"}
{else}
    {extends file="layout.tpl"}
    {block name=content}
    <div class="my-3 my-md-5">
        <div class="container">
            <div class="dimmer active" id="loading_spinner" style="display: none;">
                <div class="loader"></div>
                <div class="dimmer-content"></div> 
            </div>
            <div class="row row-cards" id="attendance-content">
                <div class="col-md-6 col-lg-3">
                    <div class="card">
                        <div class="card-status bg-green"></div>
                            <div class="card-header">
                                <h3 class="card-title">DTR Period</h3>
                            </div>
                            <div class="card-body">
                                {* <form method="POST" action=""> *}
                                    <input type="hidden" id="date_from" value="{date('Y-m-01')}">
                                    <input type="hidden" id="date_to" value="{date('Y-m-t')}">
                                    <input type="hidden" id="period" value="3">
                                    <div class="form-group">
                                        <label class="form-label">Select Month</label>
                                        <select name="dtr_month" id="month" class="form-control custom-select" onchange="javascript:setDate()">
                                            <option value="00" disabled="">Month</option>
                                            {include file="custom/select_month.tpl"}
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Select Year</label>
                                        <input type="number" name="year" id="year" class="form-control" value = "{date('Y')}" onchange="javascript:setDate()">
                                    </div>

                                    <div class="form-group">
                                        <a href="javascript:init_dtr('{$user.employee_id}')" name="init_dtr" class="btn btn-primary" style="width: 100%;">Submit</a>
                                    </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-9">
                        <div class="card" id="dtr">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        require(['core'], function () {
            $(document).ready(function () {
                init_dtr('{$user.employee_id}');
            });
        });
    </script>
    {/block}
{/if}