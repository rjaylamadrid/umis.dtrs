<?php
use Phroute\Phroute\RouteCollector;
$router = new RouteCollector();

// Landing page
$router->any('/', function () {
    header ("location: /login");
});

// Authentication
$router->get('/login', ['Login','index']);
$router->post('/login', ['Login', 'do_action']);
$router->any('/logout', function () {
    session_destroy();
    header ("location: /login");
});

// FILTERS START
$router->filter('auth', function(){    
    if (!isset($_SESSION['user'])) {
        header ('location: /login');
        return false;
    }
});
$router->filter('is_admin', function(){
    if ($_SESSION['user']['type'] != "admin") {
        header ('location: /profile');
        return false;
    }
});
// FILTERS END

$router->group(['before' => 'auth'], function ($router) {
    $router->group(['before' => 'is_admin'], function ($router) {
        // ADMIN START:
        // Dashboard
        $router->get('/dashboard', ['Dashboard', 'index']);

        // Employees
        $router->group(["prefix" => "employees"], function ($router) {
            $router->get('/', ['Employees', 'index']);
            $router->get('/profile/{id}/{view}?', ['Employees', 'profile']);
            $router->get('/update/{id}/{view}?', ['Employees', 'update']);
            $router->post('/', ['Employees', 'do_action']);
        });

        // Attendance
        $router->group(["prefix" => "attendance"], function ($router) {
            $router->get('/', ['Attendance', 'index']);
            $router->post('/', ['Attendance', 'do_action']);
            $router->post('/print', ['Attendance', 'print_preview']);
        });

        // Settings
        $router->group(["prefix" => "settings"], function ($router) {
            $router->get("/", ["Settings", "index"]);
            $router->get("/{tab}", ["Settings", "tab"]);
        });

        // Request
        $router->group(["prefix" => "request"], function ($router) {
            $router->get("/", ["Request", "index"]);
        });
        // ADMIN END
    });
    
    // EMPLOYEE START
    $router->get('/profile/{view}?', ['Profile', 'index']);
    $router->get('/update/{view}?', ['Profile', 'update']);
    $router->get('/dtr', ['DTR', 'index']);
    $router->post('/dtr', ['DTR', 'do_action']);
    // EMPLOYEE END
});

$dispatcher = new Phroute\Phroute\Dispatcher($router->getData());
return $dispatcher->dispatch($_SERVER['REQUEST_METHOD'], parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));