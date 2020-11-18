<!doctype html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta http-equiv="Content-Language" content="en" />
        <meta name="msapplication-TileColor" content="#2d89ef">
        <meta name="theme-color" content="#4188c9">
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="mobile-web-app-capable" content="yes">
        <meta name="HandheldFriendly" content="True">
        <meta name="MobileOptimized" content="320">
        <link rel="icon" href="{$server}/favicon.ico" type="image/x-icon"/>
        <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />

        <title>{block name=title}CBSUA :: HRIS{/block}</title>
        <!-- Dashboard Core -->
        <script src="{$server}/assets/js/require.min.js"></script>
        <script>
            requirejs.config({
                baseUrl: '/',
                waitSeconds: 0
            });
        </script>
        <link href="{$server}/assets/css/dashboard.css" rel="stylesheet" />
        <script src="{$server}/assets/js/dashboard.js"></script> 
    </head>
<body class="">
    <div class="page">
        <div class="flex-fill">
            {if $page != 'login' && $page != 'home'}{include file="header.tpl"}{/if}
            {block name=content}{/block}
        </div>
    </div>
</body>
{if $page != 'login'}{include file="footer.tpl"}{/if}
</html>
