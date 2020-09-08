{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <div class="row row-cards row-deck">
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><b>{date('F')}</b> Birthday Celebrants {$bdaycelebrant.first_name}</h3>
                    </div>
                    <div class="card-body o-auto" style="height: 20rem">
                    <ul class="list-unstyled list-separated">
                        {foreach from = $bdaycelebrant  item = celebrant}
                        <li class="list-separated-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <span class="avatar avatar-md d-block" style="background-image: url(assets/images/employees/{$celebrant.profile_picture})"></span>
                                </div>
                                <div class="col">
                                    <div>
                                        <a href="javascript:void(0)" class="text-inherit">{$celebrant.first_name} {$celebrant.last_name} @ {$celebrant.Age}</a>
                                    </div>
                                    <small class="d-block item-except text-sm text-muted h-1x">{$celebrant.BDate} - {$celebrant.Araw}</small>
                                </div>
                            </div>
                        </li>
                        {/foreach}
                    </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-8">
                <div class="alert alert-primary">Employee Statistics</div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <div id="chart-gender-ratio" class="c3">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <div id="chart-campus-ratio" class="c3">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{/block}