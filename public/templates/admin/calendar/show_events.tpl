{if $events}
<thead>
    <tr><td style="text-align: center;font-weight: bold" colspan="2">{$date|date_format:'F d, Y'}</td></tr>
</thead>

<tbody>
    {foreach from=$events item=event}
        <tr><td class="border-right-0"><div>{$event.event_name} ({$event.dtr_code_desc})</div><div class="small text-muted">{$event.event_start|date_format:'g:i A'} - {$event.event_end|date_format:'g:i A'}</div></td>
        <td class="border-left-0"><a class="float-right ml-2" onclick="javascript:delete_event({$event.no})"><i class="btn btn-outline-danger fe fe-trash" style="font-size: 1rem;"></i></a>
        {* <a data-toggle="modal" data-target="#edit-event-modal" class="float-right btn btn-outline-success" href="#"><i class="fe fe-edit-3"></i></a> *}
        </td></tr>
    {/foreach}
        <tr><td colspan="2"><a href="#" class="btn btn-sm float-right btn-outline-success" data-toggle="modal" data-target="#add-event-modal"><i class="fe fe-plus"></i>Add Event</a></td></tr>
        {* <tr><td colspan="2" class="border-0"><a data-toggle="modal" data-target="#add-event-modal" class="float-right"><i class="fe fe-plus">Add Event</i></a></td></tr> *}
</tbody>
{else}
<thead>
    <tr><td style="text-align: center;font-weight: bold" colspan="2">{$date|date_format:'F d, Y'}</td></tr>
</thead>
<tbody>
        <tr><td>No events found.</td></tr>
        <tr><td colspan="2"><a href="#" class="btn btn-sm float-right btn-outline-success" data-toggle="modal" data-target="#add-event-modal"><i class="fe fe-plus"></i>Add Event</a></td></tr>
</tbody>
{/if}