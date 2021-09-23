<?php  
require 'vendor/autoload.php';  
use Ratchet\MessageComponentInterface;  
use Ratchet\ConnectionInterface;
require 'app/Chat.php';

// Run the server application through the WebSocket protocol on port 8080
$app = new Ratchet\App("192.168.2.18", 9001, '192.168.2.18');
$app->route('/', new Chat, array('*'));
$app->run();