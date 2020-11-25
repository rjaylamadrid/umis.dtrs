{$service_records = $employee->service_record}
{if $view !="update"}
    <div class="form-group" style="float: right;">
        <a href="{$server}/employees/employment-update/{$employee->id}/{$tab}" class="btn btn-secondary btn-sm ml-2"><i class="fe fe-edit-2"></i> Edit</a>
    </div>
    {include file="custom/service_record.tpl"}
{else}
    <div class="form-group form-inline">
    {if $message}
            <div class="alert card-alert {if $message.success}alert-success{else}alert-danger{/if} alert-dismissible">
                <button type="button" class="close" data-dismiss="alert"></button>
                <i class="fe {if $message.success}fe-check{else}fe-alert-triangle{/if} mr-2" aria-hidden="true"></i>{$message.message}
            </div><br/>
    {/if}
    <label class="h4" style="display: inline-block;">Service Record</label>
        <div style="float: right;">
            <a href="" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#add-service-record-modal"><i class="fe fe-plus"></i>Add Past Service Record</a>
        </div>
    </div>
    <div class="row">
        <div class="card">
            <div class="table-responsive">
                <table class="table table-hover table-outline table-vcenter text-nowrap card-table" id="eligibility_table">
                    <thead>
                        <tr>
                        <th>Position</th>
                        <th>Status</th>
                        <th>Salary</th>
                        <th>Station/Place of Assignment</th>
                        <th style="width: 5%;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$service_records item=record}
                            <tr>
                                <td>
                                    <div>{$record.position_desc}</div>
                                    <div class="small text-muted">Date: {$record.date_start} to {if $record.active_status == 0} {$record.date_end} {else} Present {/if}</div>
                                </td>
                                <td>
                                    <div>{$record.etype_desc}</div>
                                </td>
                                <td>
                                    <div>Php {if $record.jo == 0} {$record.step_increment|number_format:2:".":","} <div class="small text-muted">Salary Grade: {$record.salary_grade} - Step {$record.step} </div> {else} {$cos_pay = explode(";",$record.step_increment)} {$cos_pay[1]|lower} {$cos_pay[0]|lower} {/if}</div>
                                </td>
                                <td>
                                    <div>CBSUA - {$record.campus_name}</div>
                                </td>
                                <td style="vertical-align: middle; text-align: center;">
                                <a href="javascript:confirm_delete({$record.no},{$employee->id},'service_record')" class="btn btn-outline-danger btn-sm">
                                    <i class="fe fe-trash"></i>
                                </a>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {include file="admin/modal/add_service_record.tpl"}
{/if}
