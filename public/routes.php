<?php
use Phroute\Phroute\RouteCollector;
$router = new RouteCollector();

// Landing page
$router->any('/', ['Login','index']);

// Authentication
$router->get('/login', ['Login','index']);
$router->post('/login/type', 'Login@change_type');
$router->post('/login', ['Login', 'do_login']);
$router->get('/logout', function () {
    session_destroy();
    header ("location: login");
});

// Dashboard
$router->get('/dashboard', ['Dashboard', 'index']);

// Employees
$router->get('/employees', ['Employees', 'index']);

$dispatcher = new Phroute\Phroute\Dispatcher($router->getData());
$response = $dispatcher->dispatch($_SERVER['REQUEST_METHOD'], parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
    
// Print out the value returned from the dispatched function
echo $response;