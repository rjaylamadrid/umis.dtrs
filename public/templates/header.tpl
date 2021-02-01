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
                            <small class="text-muted d-block mt-1">{$user.position}</small>
                        </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                        {if $user.type == "admin"}
                        <a class="dropdown-item" href="#loginOtherAccountModal" data-toggle="modal">
                            <i class="dropdown-icon fe fe-user"></i> Account
                        </a>
                        {/if}
                        {* <a class="dropdown-item" href="#">
                            <i class="dropdown-icon fe fe-send"></i> Messages
                        </a> *}
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
                    {if $user.is_admin}
                        <li class="nav-item">
                            <a href="/dashboard" class="nav-link {if $page == 'dashboard'}active{/if}"><i class="fe fe-home"></i> Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a href="/employees" class="nav-link {if $page == 'employees'}active{/if}"><i class="fe fe-users"></i> Employees</a>
                        </li>
                        {* <li class="nav-item">
                            <a href="/payroll" class="nav-link {if $page == 'payroll'}active{/if}"><i class="fe fe-credit-card"></i> Payroll</a>
                        </li> *}
                        <li class="nav-item">
                            <a href="/attendance" class="nav-link {if $page == 'attendance'}active{/if}"><i class="fe fe-clock"></i> Daily Time Records</a>
                        </li>
                        <li class="nav-item">
                            <a href="/calendar" class="nav-link {if $page == 'calendar'}active{/if}"><i class="fe fe-calendar"></i> Calendar</a>
                        </li>
                        {* <li class="nav-item">
                            <a href="/request" class="nav-link {if $page == 'request'}active{/if}"><i class="fe fe-mail"></i> Leave Requests</a>
                            <span><div class="notif"></div></span>
                        </li> *}
                        <li class="nav-item">
                            <a href="/settings" class="nav-link {if $page == 'settings'}active{/if}"><i class="fe fe-settings"></i> Settings</a>
                        </li>
                    {else}
                        <li class="nav-item">
                            <a href="/profile" class="nav-link {if $page == 'profile'}active{/if}"><i class="fe fe-user"></i> Profile</a>
                        </li>
                        <li class="nav-item">
                            <a href="/payroll" class="nav-link {if $page == 'payroll'}active{/if}"><i class="fe fe-credit-card"></i> Payroll</a>
                        </li>
                        <li class="nav-item">
                            <a href="{$server}/dtr" class="nav-link {if $page == 'dtr'}active{/if}"><i class="fe fe-clock"></i> Daily Time Records</a>
                        </li>
                        <li class="nav-item">
                            <a href="{$server}/leave" class="nav-link {if $page == 'leave'}active{/if}"><i class="fe fe-clock"></i> Leave Management</a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
</div>
{if $user}{include file="modal/account_modal.tpl"}{/if}