{extends file="layout.tpl"}
{block name=content}
<div class="my-3 my-md-5">
    <div class="container">
        <div class="row row-cards">
            <div class="col-sm-6 col-lg-3">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <span class="stamp stamp-md bg-red mr-3">
                            <i class="fe fe-users"></i>
                        </span>
                        <div>
                            <h4 class="m-0"><a href="/employees">{$employee.total} <small>Employees</small></a></h4>
                            <small class="text-muted">0 Newly Hired</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <span class="stamp stamp-md bg-blue mr-3">
                            <i class="fe fe-briefcase"></i>
                        </span>
                        <div>
                            <h4 class="m-0"><a href="#">132 <small>Payroll</small></a></h4>
                            <small class="text-muted">12 Pending</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <span class="stamp stamp-md bg-green mr-3">
                            <i class="fe fe-file-text"></i>
                        </span>
                        <div>
                            <h4 class="m-0"><a href="#">0 <small>Daily Time Records</small></a></h4>
                            <small class="text-muted">For the Month of {date('F')}</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <span class="stamp stamp-md bg-yellow mr-3">
                            <i class="fe fe-message-square"></i>
                        </span>
                        <div>
                            <h4 class="m-0"><a href="#">12 <small>Request Forms</small></a></h4>
                            <small class="text-muted"> For Review</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row row-cards row-deck">
            <div class="col-md-6 col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><b>{date('F')}</b> Birthday Celebrants {$bdaycelebrant.first_name} ({sizeof($bdaycelebrant)})</h3>
                    </div>
                    <div class="card-body o-auto" style="height: 20rem">
                    <ul class="list-unstyled list-separated">
                        {foreach from = $bdaycelebrant  item = celebrant}
                        <li class="list-separated-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <span class="avatar avatar-md d-block" style="background-image: url({$server}/assets/employee_picture/{if $celebrant.employee_picture}{$celebrant.employee_picture}{else}0.jpeg{/if})"></span>
                                </div>
                                <div class="col">
                                    <div>
                                        <a class="text-inherit">{$celebrant.first_name} {$celebrant.last_name} @ {$celebrant.Age}</a>
                                    </div>
                                    <small class="d-block item-except text-sm text-muted h-1x">{$celebrant.BDate} - {$celebrant.Araw|date_format: '%A'}</small>
                                </div>
                            </div>
                        </li>
                        {/foreach}
                    </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-8">
                <div class="alert alert-primary">Employees' Statistics</div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <div id="chart-gender-ratio-holder" class="c3">
                                        <canvas id="chart-gender-ratio" width="500" height="300"></canvas>
                                    </div>
                                    <script>
                                        require(['chartjs'], function() {
                                            $(document).ready(function() {
                                                var data = {$employee.gender|json_encode};
                                                var ctx = document.getElementById('chart-gender-ratio').getContext('2d');
                                                window.myPie = new Chart(ctx, {
                                                    type: 'pie',
                                                    data: {
                                                        labels: Object.keys(data),
                                                        datasets: [{
                                                            label: 'Question',
                                                            data: Object.values(data),
                                                            backgroundColor: colours(2),
                                                        }],
                                                    },
                                                    options: {
                                                        maintainAspectRatio: false,
                                                        responsive:true,
                                                        plugins: {
                                                            datalabels: {
                                                                color: 'white',
                                                                display: true,
                                                                font: {
                                                                    weight: 'bold'
                                                                },
                                                            }
                                                        },
                                                        legend: {
                                                            display: true,
                                                            position: 'bottom',
                                                            fullWidth: true,
                                                        }
                                                    }
                                                });
                                            })
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <div id="chart-employee-ratio-holder" class="c3">
                                        <canvas id="chart-employee-ratio" width="500" height="300"></canvas>
                                    </div>
                                    <script>
                                        require(['chartjs'], function() {
                                            $(document).ready(function() {
                                                var data = {$employee.type|json_encode};
                                                var ctx = document.getElementById('chart-employee-ratio').getContext('2d');
                                                window.myPie = new Chart(ctx, {
                                                    type: 'pie',
                                                    data: {
                                                        labels: Object.keys(data),
                                                        datasets: [{
                                                            label: 'Question',
                                                            data: Object.values(data),
                                                            backgroundColor: colours(2),
                                                        }],
                                                    },
                                                    options: {
                                                        maintainAspectRatio: false,
                                                        responsive: true,
                                                        plugins: {
                                                            datalabels: {
                                                                color: 'white',
                                                                display: true,
                                                                font: {
                                                                    weight: 'bold'
                                                                },
                                                            }
                                                        },
                                                        legend: {
                                                            display: true,
                                                            position: 'bottom',
                                                            fullWidth: true,
                                                        }
                                                    }
                                                });
                                            })
                                        });
                                    </script>
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