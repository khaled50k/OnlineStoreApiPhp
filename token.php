<?php
require_once 'vendor/autoload.php';
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

include './db/db.php';
// Generate Token
$key = 'Klas3__234';
function generateToken($userId, $username, $role)
{
    global $pdo;
    global $key;
    
    $exp = time() + (30 * 24 * 60 * 60);
    $payload = [
        'id' => $userId,
        'username' => $username,
        'role' => $role,
        'iat' => time(),
        'exp' => $exp // Token expires in 30 days
    ];
    
    $jwt = JWT::encode($payload, $key, 'HS256');
    
    // Store the token in the tokens table
    $stmt = $pdo->prepare("INSERT INTO tokens (user_id, token, expiration_date) VALUES (?, ?, ?)");
    $stmt->execute([$userId, $jwt, date('Y-m-d H:i:s', $exp)]);
    
    return [
        'token' => $jwt,
        'exp' => $exp
    ];
}

// Update Token
function updateToken($userId, $username, $role, $iat, $exp)
{
    global $key;

    $payload = [
        'id' => $userId,
        'username' => $username,
        'role' => $role,
        'iat' => $iat,
        'exp' => $exp // Token expires in 30 days
    ];

    $jwt = JWT::encode($payload, $key, 'HS256');

    return [
        'token' => $jwt,
        'exp' => $exp
    ];
}
// Verify Token
// function verifyToken($token)
// {
//     global $key;
//     try {
//         $decoded = JWT::decode($token, new Key($key, 'HS256'), ['HS256']);
//         return (array) $decoded;
//     } catch (Exception $e) {
//         echo $e;

//     }
// }
function verifyToken($token)
{
    global $pdo;
    global $key;

    $stmt = $pdo->prepare("SELECT * FROM tokens WHERE token = ?");
    $stmt->execute([$token]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($result['revoked'] === 0 && $result['expiration_date'] > time()) {
      
        try {
            $decoded = JWT::decode($token, new Key($key, 'HS256'), ['HS256']);
        
            return (array) $decoded;
        } catch (Exception $e) {
            echo $e;
        }
    }

    return false;
}
function revokeToken($useId)
{
    global $pdo;
    
    // Update the 'revoked' column to mark the token as revoked
    $stmt = $pdo->prepare("UPDATE tokens SET revoked = 1 WHERE user_id = ?");
    $stmt->execute([$useId]);
    if ($stmt->rowCount() > 0) {
        return true; // Token successfully revoked
    } else {
        return false; // Token not found or already revoked
    }
}

// Generate and print the token

?>