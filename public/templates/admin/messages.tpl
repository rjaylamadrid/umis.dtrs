{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <h3 class="page-title mb-5">Messages</h3>

        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        
                        <form class="input-icon my-3 my-lg-0">
                            <input type="msgSearch" class="form-control header-search" placeholder="Search Employees&hellip;" tabindex="1">
                            <div class="input-icon-addon">
                              <i class="fe fe-search"></i>
                            </div>
                          </form>
                    </div>
                    <div class="card-body o-auto" style="height: 40rem">
                        <div id="contacts">
                        <ul class="list-unstyled" id="employees">
                            {foreach from = $employees item = employee}
                                {if $employee.no != $emp_user}
                            <li class="list-separated-item" onclick="javascript:getSelectedEmployee('{$employee.no}')">
                                <div class="row align-items-center">
                                    <div class="col-md-2">
                                        <div class="avatar d-block" style="background-image: url({$server}/assets/employee_picture/{if $user.employee_picture}{$user.employee_picture}{else}0.jpeg{/if})">
                                            <span id="isActive{$employee.no}"></span>
                                        </div>
                                    </div>

                                    <div class="col-md-10">
                                        <span id="isSeen{$employee.no}" class='mt-2 float-right badge badge-danger'></span>
                                        <div>{$employee.first_name} {$employee.last_name}</div>
                                        <div class='small text-muted'>{$employee.email_address}</div>
                                    </div>
                                </div>
                            </li>
                                {/if}
                            {/foreach}
                        </ul>
                    </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8" id="settings_tab">
                <div class="card">
                    <div class="card-header">
                        <div class="col-auto">
                            <span class="avatar avatar-md d-block" style="background-image: url({$server}/assets/employee_picture/{if $user.employee_picture}{$user.employee_picture}{else}0.jpeg{/if})"></span>
                        </div>

                        <div class="col">
                            <div>
                                <a class="text-inherit" id="chatName"></a>
                            </div>
                            <small class="d-block item-except text-sm text-muted h-1x" id="chatEmail"></small>
                        </div>
                    </div>
                    <div class="card-body" style="height: 40rem">

                        <div id="feed" class="feed" ref="feed">
                           
                        </div>

                        <div class="composer">
                            <textarea id="message" placeholder="Message..."></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<style scoped>
    input.form-control.header-search {
        width: 325;
    }
    .dateTime {
        text-align: center;
        display: block;
    }

    .composer textarea {
        width:97%;
        margin: 10px;
        resize: none;
        border-radius: 3px;
        border: 1px solid lightgray;
        padding: 6px;
    }

    .feed {
        background: #f0f0f0;
        height: 100%;
        max-height: 470px;
        overflow: scroll;
    }

    .feed ul{
        list-style-type: none;
        padding: 5px;
    }

    .feed ul li.message{
        margin: 10px 0;
        width: 100%;
    }

    .text{
        max-width: 300px;
        border-radius: 20px;
        padding: 12px;
        display: inline-block; 
        margin-bottom: 5;
    }

    li.message.received{
        text-align: right;
    }
    li.message.received .text{
        background: #b2b2b2;
    }

    li.message.sent{
        text-align: left;
    }
    
    li.message.sent .text{
        background: #81c4f9;
    } 
</style>
{/block}

