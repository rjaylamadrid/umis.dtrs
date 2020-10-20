{if $events}
<thead>
    <tr><td style="text-align: center;font-weight: bold" colspan="2">{date_format($event_date, 'F d, Y')}</td></tr>
</thead>

<tbody>
    {foreach from=$events item=event}
        <tr><td class="border-right-0"><div>{$event.event_name}</div><div class="small text-muted">{$event.event_start} - {$event.event_end}</div></td>
        <td class="border-left-0"><a data-toggle="modal" data-target="#edit-event-modal" class="float-right"><i class="fe fe-edit-3"></i></a></td></tr>
    {/foreach}
      <tr><td colspan="2" class="border-0"><a data-toggle="modal" data-target="#add-event-modal" class="float-right"><i class="fe fe-plus">Add Event</i></a></td></tr>
</tbody>
{else}
<thead>
    <tr><td style="text-align: center;font-weight: bold" colspan="2">{date_format($event_date, 'F d, Y')}</td></tr>
</thead>
<tbody>
        <tr><td>No events found.</td></tr>
        <tr><td colspan="2" class="border-0"><a data-toggle="modal" data-target="#add-event-modal" class="float-right"><i class="fe fe-plus">Add Event</i></a></td></tr>
</tbody>
{/if}