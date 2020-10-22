{extends file="layout.tpl"}
{block name=content}
    <div class="my-3 my-md-5">
        <div class="container">
            {* <div class="dimmer active" id="loading_spinner" style="display: none;">
                <div class="loader"></div>
                <div class="dimmer-content"></div>
            </div> *}
            <div class="row">
                <div class="col-md-3">
                    <div class="card mb-2">
                        <div class="card-body">
                            <form action="/calendar" method="POST">
                            <input type="hidden" name="action" value="get_calendar">
                                <label class="form-label">Set Period:</label>
                                <div class="row">
                                    <select name="month" class="col-md-6 form-control custom-select" id="month">
                                        <option value="" selected="" disabled="" readonly>Month</option>
                                        {include file="custom/select_month.tpl"}
                                    </select>
                                    <input name="year" type="number" class="col-md-5 form-control ml-4" placeholder="Year" value="{date_format($date,'Y')}" id="year">
                                </div>
                                <div class="col-md-12 mt-5">
                                    <div class="form-group" style="float: right;">
                                        <button name="submit" value="submit" class="btn btn-primary">Submit</button>
                                    </div>
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
                        {if $date != NULL}
                            {include file="admin/calendar/$tab.tpl"}
                        {else if $tab == 'overtime'}
                            <div class="page-content">
                                <div class="container text-center">
                                    <div class="display-1 text-muted mb-5"><i class="si si-exclamation"></i> 404</div>
                                    <h1 class="h2 mb-3">This page is under construction.</h1>
                                    <p class="h4 text-muted font-weight-normal mb-7">We are sorry but this page is currently not available.</p>
                                    <a class="btn btn-primary" href="javascript:history.back()">
                                    <i class="fe fe-arrow-left mr-2"></i>Go back
                                    </a>
                                </div>
                            </div>
                        {else}
                            <div class="page-content">
                                <div class="container text-center">
                                    <h1 class="h2 mb-3">Select Month and Year.</h1>
                                    <p class="h4 text-muted font-weight-normal mb-7">Please select the month and year you wanted to view or edit.</p>
                                </div>
                            </div>
                        {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}