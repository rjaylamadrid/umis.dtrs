<?php  
require 'vendor/autoload.php';  
use Ratchet\MessageComponentInterface;  
use Ratchet\ConnectionInterface;

require 'app/Chat.php';

// Run the server application through the WebSocket protocol on port 8080
$app = new Ratchet\App("www.dtrs.com", 9001, '192.168.1.11', $loop);
$app->route('/', new Chat, array('*'));
$app->run();