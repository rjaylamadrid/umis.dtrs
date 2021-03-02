{extends file="layout.tpl"}
{block name=content}
<div class="page-content">
    <div class="container text-center">
        <div class="display-1 text-muted mb-5"><i class="si si-exclamation"></i> {$code}</div>
        <h1 class="h2 mb-3">{$message}</h1>
        <p class="h4 text-muted font-weight-normal mb-7">{$submessage}</p>
        <a class="btn btn-primary" href="javascript:history.back()">
        <i class="fe fe-arrow-left mr-2"></i>Go back
        </a>
    </div>
</div>
{/block}