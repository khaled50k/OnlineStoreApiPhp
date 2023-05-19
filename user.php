<?php

include './db.php';
// require_once 'vendor/autoload.php';
// use Firebase\JWT\JWT;

header("Access-Control-Allow-Origin: *"); // Replace "*" with the appropriate origin URL
header("Access-Control-Allow-Methods: GET, POST, OPTIONS"); // Adjust the allowed methods as needed
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, GET");
header("Access-Control-Allow-Headers: Content-Type, Cookie");
header("Access-Control-Allow-Credentials: true");
header("Content-Type:application/json");


// // Handle preflight OPTIONS requests
// if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
//     // Return early for OPTIONS requests
//     exit();
// }
// // Rest of your code...
// function isAdmin($pdo)
// {
//     if (!isset($_SERVER['HTTP_COOKIE'])) {
//         // Handle case when the Cookie header is not set
//         return false;
//     }

//     $cookieHeader = $_SERVER['HTTP_COOKIE'];
//     $cookies = explode('; ', $cookieHeader);

//     $phpSessionId = '';
//     foreach ($cookies as $cookie) {
//         if (strpos($cookie, 'PHPSESSID=') === 0) {
//             $phpSessionId = substr($cookie, 10); // Extract the value after "PHPSESSID="
//             break;
//         }
//     }



//     // Check if the session cookie exists

//     // Set the session ID to the extracted PHP session ID
//     session_id($phpSessionId);

//     // Access session data
//     $userId = $_SESSION['user_id'] ?? null;
//     $role = $_SESSION['role'] ?? null;


//     $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
//     $stmt->execute([$userId]);
//     $user = $stmt->fetch();

//     if (!$user) {
//         return false;
//     }

//     return $role === 'admin';
// }
// function isAdminOrOwner($pdo, $userId)
// {
//     if (!isset($_SESSION['user_id']) && !isset($_SESSION['username'])) {

//         return false;
//     }



//     $headers = getallheaders();
//     $coockie = $headers['Cookie'];
//     // $cookieHeader = $_SERVER['HTTP_COOKIE'];

//     // // Parse the cookie header and populate the $_COOKIE array
//     // parse_str(str_replace('; ', '&', $headers), $_COOKIE);

//     // Check if the session is not already active
//     if (session_status() === PHP_SESSION_NONE) {
//         // Start the session
//         session_start();
//     }
//     // Check if the session cookie exists
//     if (!isset($coockie)) {
//         // Handle case when the session cookie is not present
//         return false;
//     } // Access session data
//     $id = $_SESSION['user_id'];
//     $role = $_SESSION['role'];
//     $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ? ");
//     $stmt->execute([$id]);
//     $user = $stmt->fetch();

//     if (!$user) {
//         return false;
//     }

//     return $role === 'admin' || $user['id'] == $userId;
// }
// // User Registration API endpoint
// if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_GET['action'] === 'register') {

//     $data = json_decode(file_get_contents('php://input'), true);

//     $username = $data['username'];
//     $email = $data['email'];
//     $password = $data['password'];
//     $role = $data['role'] ?? 'customer'; // Set default role to 'customer' if not provided
//     $status = $data['status'] ?? 'active'; // Set default status to 'active' if not provided

//     // Check if the username is already taken
//     $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
//     $stmt->execute([$username]);
//     $existingUser = $stmt->fetch();

//     if ($existingUser) {
//         $response = [
//             'message' => 'Username already taken.'
//         ];
//     } else {
//         // Check if the email is already registered
//         $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
//         $stmt->execute([$email]);
//         $existingUser = $stmt->fetch();

//         if ($existingUser) {
//             $response = [
//                 'message' => 'Email already registered.'
//             ];
//         } else {
//             // Hash the password
//             $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

//             // Insert the user into the database
//             $stmt = $pdo->prepare("INSERT INTO users (username, email, password, role, status) VALUES (?, ?, ?, ?, ?)");
//             $stmt->execute([$username, $email, $hashedPassword, $role, $status]);

//             // Set session variables for the newly registered user
//             $_SESSION['user_id'] = $pdo->lastInsertId();
//             $_SESSION['username'] = $username;
//             $_SESSION['email'] = $email;

//             $response = [
//                 'message' => 'Registration successful.',
//                 'user' => [
//                     'id' => $_SESSION['user_id'],
//                     'username' => $_SESSION['username'],
//                     'email' => $_SESSION['email']
//                 ]
//             ];
//         }
//     }

//     echo json_encode($response);
//     exit;
// }

// // User Login API endpoint
// if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_GET['action'] === 'login') {
//     $data = json_decode(file_get_contents('php://input'), true);

//     $email = $data['email'];
//     $password = $data['password'];

//     $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
//     $stmt->execute([$email]);
//     $user = $stmt->fetch();

//     if ($user && password_verify($password, $user['password'])) {
//         $_SESSION['user_id'] = $user['id'];
//         $_SESSION['username'] = $user['username'];
//         $_SESSION['email'] = $user['email'];
//         $_SESSION['role'] = $user['role'];
//         $_SESSION['status'] = $user['status'];

//         $response = [
//             'message' => 'Login successful.',
//             'user' => [
//                 'id' => $user['id'],
//                 'username' => $user['username'],
//                 'email' => $user['email']
//             ],

//         ];
//     } else {
//         $response = [
//             'message' => 'Invalid email or password.'
//         ];
//     }

//     echo json_encode($response);
//     exit;
// }

// // Get User Details API endpoint
// if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'user-details') {
//     $userId = $_GET['userId'];
//     if (!isAdminOrOwner($pdo, $userId)) {
//         http_response_code(401);

//         echo json_encode(['message' => 'Unauthorized access.']);
//         exit;
//     }

//     if (!isset($_SESSION['user_id']) && !isset($_SESSION['username'])) {
//         $response = [
//             'message' => 'User not logged in.'
//         ];
//         http_response_code(401);
//         echo json_encode($response);
//         exit;
//     }


//     if (isset($_GET['userId'])) {
//         $userId = $_GET['userId'];

//         $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ? ");
//         $stmt->execute([$userId]);
//         $user = $stmt->fetch();

//         if ($user) {
//             $response = [
//                 'id' => $user['id'],
//                 'username' => $user['username'],
//                 'email' => $user['email'],
//                 'role' => $user['role'],
//                 'status' => $user['status'],
//             ];
//         } else {
//             $response = [
//                 'message' => 'User not found.'
//             ];
//             http_response_code(402);
//             echo json_encode($response);
//             exit;
//         }

//         echo json_encode($response);
//         exit;
//     }
//     $response = [
//         'message' => 'Check username and userId.'
//     ];
//     http_response_code(403);
//     echo json_encode($response);
//     exit;
// }

// // API endpoint to handle user logout

// // if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_GET['action'] === 'logout') {
// //     // Check if the user is logged in
// //     if (!isset($_SESSION['user_id'])) {
// //         $response = ['message' => 'User not logged in.'];
// //         echo json_encode($response);
// //         exit;
// //     }

// //     // Destroy the session
// //     session_destroy();

// //     // Return a success response
// //     $response = ['message' => 'Logout successful.'];
// //     echo json_encode($response);
// //     exit;
// // }

// // API endpoint to get users (admin only)
// if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_GET['action'] === 'get-users') {
//     // Check if the user is logged in as admin

//     if (!isAdmin($pdo)) {
//         http_response_code(401);
//         echo json_encode(['message' => 'Unauthorized access.']);
//         exit;
//     }

//     $stmt = $pdo->query("SELECT * FROM users");
//     $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

//     echo json_encode($users);
//     exit;
// }

// // API endpoint to update user details (admin and the user who created the account)
// if ($_SERVER['REQUEST_METHOD'] === 'PUT' && $_GET['action'] === 'update-user') {
//     $userId = $_GET['userId'];

//     // Check if the user is logged in as admin or the user who created the account
//     if (!isAdminOrOwner($pdo, $userId)) {
//         http_response_code(401);
//         echo json_encode(['message' => 'Unauthorized access.']);
//         exit;
//     }

//     // Retrieve request payload
//     $data = json_decode(file_get_contents('php://input'), true);


//     $role = $data['role'] ?? 'customer'; // Set default role to 'customer' if not provided
//     $status = $data['status'] ?? 'active';

//     // Build the SQL statement and parameter values
//     $sql = "UPDATE users SET  role = ?, status = ?";
//     $params = [$role, $status];

//     // Check if the username is provided and update it if it exists in the request data
//     if (isset($data['username'])) {
//         $sql .= ", username = ?";
//         $params[] = $data['username'];
//     }
//     if (isset($data['email'])) {
//         $sql .= ", email = ?";
//         $params[] = $data['email'];
//     }

//     // Add the WHERE clause for the specific user ID
//     $sql .= " WHERE id = ?";
//     $params[] = $userId;

//     // Perform the update in the database, assuming you have appropriate error handling and validation in place
//     $stmt = $pdo->prepare($sql);
//     $stmt->execute($params);

//     echo json_encode(['message' => 'User updated successfully.']);
//     exit;

// }