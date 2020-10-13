{extends file="layout.tpl"}
{block name=content}
    <div class="my-3 my-md-5">
        <div class="container">
            <div class="dimmer active" id="loading_spinner" style="display: none;">
                <div class="loader"></div>
                <div class="dimmer-content"></div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="card mb-2">
                        <div class="card-body">
                            <form action="" method="POST">
                                <label class="form-label">Set Period:</label>
                                <div class="row">
                                    <select name="month" class="col-md-6 form-control custom-select" id="month">
                                    <option value="" selected="" disabled="">Month</option>
                                    {include file="custom/select_month.tpl"}
                                    </select>
                                    <input name="year" type="number" class="col-md-5 form-control ml-4" placeholder="Year" value="{date('Y')}" id="year">
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="list-group list-group-transparent mb-0">
                        <a href="{$server}/calendar/event" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == "event"}active{/if}">
                            <span class="icon mr-3"><i class="fe fe-calendar"></i></span>Event 
                        </a>
                    </div>
                    <div class="list-group list-group-transparent mb-0">
                        <a href="{$server}/calendar/overtime" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == "overtime"}active{/if}">
                            <span class="icon mr-3"><i class="fe fe-clock"></i></span>Overtime
                        </a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="card">
                        <div class="card-body" id="calendar">
                            {include file="admin/calendar/$tab.tpl"}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}