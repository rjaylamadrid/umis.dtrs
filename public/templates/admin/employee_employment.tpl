{extends file='layout.tpl'}
{block name='content'}
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
<div class="my-3 my-md-5">
    <div class="container">
      <div class="row">
      	{if ($view == 'update')}
          <div class="col-md-2">
            <div class="list-group list-group-transparent mb-0">
              <a href="{$server}/employees/employment/{$employee->id}/{$tab}" class="list-group-item list-group-item-action d-flex align-items-center active"><span class="icon mr-3"><i class="fe fe-back"></i></span> Back to employment</a>
            </div>
          </div>
        {else}
	      	<div class="col-md-4">
	          <div class="card">
	          	<div class="card-body">
	              <div class="media">
	              	<span class="avatar avatar-xxl mr-5" style="background-image: url(<?php echo $emp['EmpPicture'] ? '../assets/images/employees/avatar/'.$emp['EmpPicture'] : 'img/profile_temp.jpeg'; ?>)"></span>
	              	<div class="media-body">
	                	<h4 class="m-0">{$employee->info.first_name} {$employee->info.last_name}</h4>
	                	<p class="text-muted mb-0">{$employee->position.position_desc}</p>
	              	</div>
	              </div>
	          	</div>
	          </div>
	          <div class="employee-tab">
	          	<div class="list-group list-group-transparent mb-0">
	            	<a href="{$server}/employees/employment/{$employee->id}" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == ''}active{/if}{if $tab == 'employment'}active{/if}"><span class="icon mr-3"><i class="fe fe-user"></i></span>Employment</a>
	            	<a href="{$server}/employees/employment/{$employee->id}/schedule" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'schedule'}active{/if}"><span class="icon mr-3"><i class="fe fe-clock"></i></span>Schedule</a>
	            	<a href="{$server}/employees/employment/{$employee->id}/leave-record" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'leave-record'}active{/if}"><span class="icon mr-3"><i class="fe fe-clipboard"></i></span>Leave Record</a>
	            	<a href="{$server}/employees/employment/{$employee->id}/service-record" class="list-group-item list-group-item-action d-flex align-items-center {if $tab == 'service-record'}active{/if}"><span class="icon mr-3"><i class="fe fe-layers"></i></span>Service Record</a>
	          	</div>
	          </div>
	        </div>
        {/if}
        <div class="{if ($view == 'update')}col-md-10{else}col-md-8{/if} col-sm-12">
          <div class="card" style="min-height: 680px;">
          	<div class="card-body">
          		<div class="card-body profile-content">
				{include file = "employment/{$tab}.tpl"}
          	</div>
          </div>
        </div>
      </div>
    </div>
</div>
{/block}