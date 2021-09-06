<div class="header py-4">
    <div class="card-status bg-secondary"></div>
    <div class="container" style="padding-right: 0.75rem; padding-left: 0.75rem;">
        <div class="d-flex">
            <a class="header-brand mr-1" href="{$server}/dashboard">
                <img src="{$server}/assets/img/cbsua_logosmall.png" class="header-brand-img" alt="cbsua umis logo" style="height:50px">
            </a>
            <div class="header-title d-lg-block">
                <h2 class="title-default">CBSUA</h2>
                <label class="title-muted">Human Resource Information System</label>
            </div>
            <div class="d-flex order-lg-2 ml-auto">
                <div class="dropdown">
                    <a href="#" class="nav-link pr-0 leading-none" data-toggle="dropdown">
                        <span><img class="avatar" style="object-fit: cover;" src="{$server}/assets/employee_picture/{if $user.employee_picture}{$user.employee_picture}{else}0.jpeg{/if}"></span>
                        <span class="ml-2 d-none d-lg-block">
                            <span class="text-default">{$user.first_name|upper} {$user.last_name|upper}</span>
                            <input id="user" type="hidden" value="{$user.employee_id}"/>
                            <small class="text-muted d-block mt-1">{$user.position}</small>
                        </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                        {if $user.type == "admin"}
                            <a class="dropdown-item" href="#loginOtherAccountModal" data-toggle="modal">
                                <i class="dropdown-icon fe fe-user"></i> Account
                            </a>
                        {/if}
                        {* <a class="dropdown-item" href="/messages">
                            <span class="float-right">
                                <span id="notif" class="badge badge-primary"></span>
                            </span>
                            <i class="dropdown-icon fe fe-send"></i> Messages
                        </a>  *}
                        <a class="dropdown-item" href="/settings/security">
                            <i class="dropdown-icon fe fe-lock"></i> Change Password
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/logout">
                            <i class="dropdown-icon fe fe-log-out"></i> Sign out
                        </a>
                    </div>
                </div>
            </div>
            <a href="#" class="header-toggler d-lg-none ml-3 ml-lg-0" data-toggle="collapse" data-target="#headerMenuCollapse">
                <span class="header-toggler-icon"></span>
            </a>
        </div>
    </div>
</div> 
<div class="header collapse d-lg-flex p-0" id="headerMenuCollapse">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg order-lg-first">
                <ul class="nav nav-tabs border-0 flex-column flex-lg-row">
                
                    {foreach from = $headers item = 'header'}
                      
                        <li class="nav-item">
                            <a href="/{$header.url}" class="nav-link {if $page == $header.url}active{/if}"><i class="fe fe-{$header.icon}"></i> {$header.title}</a>
                        </li>
                   
                    {/foreach}
                </ul>
            </div> 
        </div>
    </div>
</div>
{if $user}{include file="modal/account_modal.tpl"}{/if}