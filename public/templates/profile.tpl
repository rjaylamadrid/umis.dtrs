{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <style type="text/css">
        .row-header {
            background: #868e96!important;
            color: white;
            font-weight: bold;
            font-size: 16px;
            padding: 4px 4px;
        }

        .profile-content table td:first-child {
            font-weight: bold;
        }
        </style>
        <div class="row">
        {* {var_dump($employee->id)} *}
{if $view == "update"}
            <div class="col-md-2">
                <div class="list-group list-group-transparent mb-0">
                  <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/{$tab}{else}/profile/{$tab}{/if}" class="list-group-item list-group-item-action d-flex align-items-center active"><span class="icon mr-3"><i class="fe fe-back"></i></span> Back to profile</a>
                </div>
              </div>
{else}
            <div class="col-md-4 col-sm-12">
                <div class="card">
                    <div class="card-body">
                        <div class="media">
                            <span class="avatar avatar-xxl mr-5" style="background-image: url({$server}/assets/employee_picture/{if $employee->info.employee_picture}{$employee->info.employee_picture}{else}0.jpeg{/if})"></span>
                            <div class="media-body">
                                <h4 class="m-0">{$employee->info.first_name} {$employee->info.last_name}</h4>
                                <p class="text-muted mb-0">{$employee->position.position_desc}</p> 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="employee-tab">
                    <div class="list-group list-group-transparent mb-0">
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/basic-info{else}/profile{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'basic-info'} active {else if $tab == ''} active {/if}"><span class="icon mr-3"><i class="fe fe-users"></i></span>Personal Info</a>
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/family-background{else}/profile/family-background{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'family-background'} active {/if}"><span class="icon mr-3"><i class="fe fe-home"></i></span>Family Background</a>
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/education{else}/profile/education{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'education'} active {/if}"><span class="icon mr-3"><i class="fe fe-award"></i></span>Education</a>
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/eligibility{else}/profile/eligibility{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'eligibility'} active {/if}"><span class="icon mr-3"><i class="fe fe-file"></i></span>Eligibility</a>
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/employment{else}/profile/employment{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'employment'} active {/if}"><span class="icon mr-3"><i class="fe fe-tag"></i></span>Work Experience</a>
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/voluntary-work{else}/profile/voluntary-work{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'voluntary-work'} active {/if}"><span class="icon mr-3"><i class="fe fe-clipboard"></i></span>Voluntary Work</a>
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/training-seminar{else}/profile/training-seminar{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'training-seminar'} active {/if}"><span class="icon mr-3"><i class="fe fe-bookmark"></i></span>Trainings/Seminars</a>
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/references{else}/profile/references{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'references'} active {/if}"><span class="icon mr-3"><i class="fe fe-star"></i></span>References</a>
                        <a href="{$server}{if $user.is_admin}/employees/profile/{$employee->id}/other-info{else}/profile/other-info{/if}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'other-info'} active {/if}"><span class="icon mr-3"><i class="fe fe-file-text"></i></span>Other Info</a>
                    </div>
                </div>
                {* <form method="POST" action="{$server}/employees/profile/{$employee->id}/export"> *}
                    <a href="{$server}/employees/{$employee->id}/export" class="btn btn-success btn-block" style="margin-top: 10px; margin-bottom: 10px; color: white;">Generate Personal Data Sheet</a>
                {* </form> *}
            </div>
{/if}
            <div class="{if $view == 'update'}col-md-10{else}col-md-8{/if} col-sm-12">
                <div class="card p-2" style="min-height: 600px;">
                    <div class="card-body profile-content">
                        {include file = "profile/{$tab}.tpl"}
                    </div>
                </div>
            </div>
                
            
        </div>
    </div>
</div>
{/block}