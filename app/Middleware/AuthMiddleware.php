<?php

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;
use Slim\Routing\RouteContext;


include '../token.php';

class verifyTokenAndAdmin
{
    public function __invoke(Request $request, RequestHandler $handler): Response
    {
        $cookies = $request->getCookieParams();
        $token = $cookies['SESSION'] ?? null;

        if (!$token) {
            $response = new Response();
            $message = [
                'message' => 'You are not authenticated.',
            ];
            $responseBody = json_encode($message);

            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(401);
            $response->getBody()->write($responseBody);
            return $response;
        }
        $res = verifyToken($token);
        if (!$res) {
            $response = new Response();
            $message = [
                'message' => 'You are not Authorized.',
            ];
            $responseBody = json_encode($message);

            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(401);
            $response->getBody()->write($responseBody);
            return $response;
        }
        if ($res['role'] === 'admin') {
            return $handler->handle($request);

        }
        $response = new Response();
        $message = [
            'message' => 'You are not Authorized.',
        ];
        $responseBody = json_encode($message);

        $response = $response->withHeader('Content-Type', 'application/json');
        $response = $response->withStatus(401);
        $response->getBody()->write($responseBody);
        return $response;

    }
}
class verifyTokenAndAuthorization
{
    public function __invoke(Request $request, RequestHandler $handler): Response
    {
        $routeContext = RouteContext::fromRequest($request);
        $route = $routeContext->getRoute();
        $args = $route->getArguments();
        $cookies = $request->getCookieParams();
        $token = $cookies['SESSION'] ?? null;
        $queryParams = $request->getQueryParams();
        $userId = $queryParams['userid'] ?$queryParams['userid'] :$args['user_id'];
   echo $userId;

        if (!$token) {
            $response = new Response();
            $message = [
                'message' => 'You are not authenticated.',
            ];
            $responseBody = json_encode($message);

            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(401);
            $response->getBody()->write($responseBody);
            return $response;
        }
        $res = verifyToken($token);
        if (!$res) {
            $response = new Response();
            $message = [
                'message' => 'You are not Authorized.',
            ];
            $responseBody = json_encode($message);

            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(401);
            $response->getBody()->write($responseBody);
            return $response;
        }
        if ($res['role'] === 'admin' || $res['id'] == $userId) {

            $request = $request->withAttribute('userId', $userId);
            $response = $handler->handle($request);
            return $response;
        }
        $response = new Response();
        $message = [
            'message' => 'You are not Authorized.',
        ];
        $responseBody = json_encode($message);

        $response = $response->withHeader('Content-Type', 'application/json');
        $response = $response->withStatus(401);
        $response->getBody()->write($responseBody);
        return $response;

    }
}