<?php
require_once 'vendor/autoload.php';
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
// Generate Token
$key ='Klas3__234';
function generateToken($userId, $username, $role)
{
    global $key;
    $exp=time() + (30 * 24 * 60 * 60);
    $payload = [
        'id' => $userId,
        'username' => $username,
        'role' => $role,
        'iat' => time(),
        'exp' =>  $exp// Token expires in 30 days
    ];

    $jwt = JWT::encode($payload, $key, 'HS256');
  
    return [
        'token' => $jwt,
        'exp' => $exp
    ];
}

// Verify Token
function verifyToken($token)
{
    global $key;
    try {
        $decoded = JWT::decode($token, new Key($key, 'HS256'), ['HS256']);
        return (array) $decoded;
    } catch (Exception $e) {
        echo $e;
       
    }
}

// Generate and print the token

?>