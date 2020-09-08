<?php
set_time_limit(60);
date_default_timezone_set('Asia/Manila');
session_start();
error_reporting(E_ALL ^ E_NOTICE);

require_once __DIR__ . '/../vendor/autoload.php';
require_once 'routes.php';