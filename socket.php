<?php  
require 'vendor/autoload.php';  
use Ratchet\MessageComponentInterface;  
use Ratchet\ConnectionInterface;
require 'app/Chat.php';

// Run the server application through the WebSocket protocol on port 8080
$app = new Ratchet\App("10.99.68.144", 9001, '10.99.68.144');
$app->route('/', new Chat, array('*'));
$app->run();