<?php

use Slim\Factory\AppFactory;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

include '../db/db.php';
require __DIR__ . '/../vendor/autoload.php';
// Instantiate App
$app = AppFactory::create();

$app->addErrorMiddleware(true, true, true);
$app->options('/{routes:.+}', function ($request, $response, $args) {
    return $response;
});
$app->add(function ($request, $handler) {
    $response = $handler->handle($request);
    // Add CORS headers
    $response = $response
        ->withHeader('Access-Control-Allow-Origin', 'http://localhost:5173')
        // CORS origin
        ->withHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
        ->withHeader('Access-Control-Allow-Credentials', 'true');
    return $response;
});
// $app->add(ExampleBeforeMiddleware::class);
$app->get('/hello', function (Request $request, Response $response) {
    $response->getBody()->write('<h1 style="color:red;">Hello, World!</h1?');
    return $response;
});

// Register routes
$routes = require __DIR__ . '/../app/routes.php';
$routes($app);

$app->run();