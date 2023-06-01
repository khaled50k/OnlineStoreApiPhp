<?php

use Slim\Factory\AppFactory;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

// require __DIR__ . '/../app/Middleware/AuthMiddleware.php';
// use App\Middleware\AuthMiddleware;

include '../db/db.php';
require __DIR__ . '/../vendor/autoload.php';
// include '../token.php';
// Instantiate App
$app = AppFactory::create();
// $app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true);
$app->options('/{routes:.+}', function ($request, $response, $args) {
    return $response;
});
$app->add(function ($request, $handler) {
    $response = $handler->handle($request);

    // Add CORS headers
    $response = $response
        ->withHeader('Access-Control-Allow-Origin', 'http://localhost:5173')
        ->withHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
        ->withHeader('Access-Control-Allow-Credentials', 'true');
    return $response;
});
// $app->add(ExampleBeforeMiddleware::class);
$app->get('/', function (Request $request, Response $response) {
    $response->getBody()->write('Hello, World!');
    return $response;
});

// Register routes
$routes = require __DIR__ . '/../app/routes.php';
$routes($app);

$app->run();