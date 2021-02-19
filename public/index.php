<?php
set_time_limit(60);
date_default_timezone_set('Asia/Manila');
session_start();
require dirname(__DIR__) . '/vendor/autoload.php';
shell_exec('nohup php '. dirname(__DIR__) . '/app/Chat.php 2>&1 > /dev/null &');
error_reporting(E_ALL ^ E_NOTICE);

require_once __DIR__ . '/../vendor/autoload.php';
require_once 'routes.php';
