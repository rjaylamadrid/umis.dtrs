<div class="table-responsive">
    <table class="table card-table table-striped">
        {foreach from=$employee->service_record item=record}
            <tr class="row-header">
                <td colspan="2">{$record@iteration}</td>
            </tr>
            <tr>
                <td>Inclusive Dates</td>
                <td>{$record.date_start} to {if $record.date_end} {$record.date_end} {else} Present {/if}</td>
            </tr>
            <tr>
                <td>Position</td>
                <td>{$record.position_desc}</td>
            </tr>
            <tr>
                <td>Status</td>
                <td>{$record.type_desc}</td>
            </tr>
            <tr>
                <td>Station / Place of Assignment</td>
                <td>CBSUA - {$record.campus_name} Campus</td>
            </tr>
            <tr>
                <td>Salary</td>
                <td>Php {if $record.jo == 0} {$record.salary|number_format:2:".":","} <div class="small text-muted">Salary Grade: {$record.salary_grade} - Step {$record.step} </div> {else} {$cos_pay = explode(";",$record.step_increment)} {$cos_pay[1]|lower} {$cos_pay[0]|lower} {/if}</td>
            </tr>
        {/foreach}
    </table>
</div>