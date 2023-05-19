<?php
use Slim\App;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Routing\RouteCollectorProxy;
use Slim\Validation\Validation;
use Slim\Validation\Validator;

require __DIR__ . '/../app/Middleware/AuthMiddleware.php';
use App\Middleware\AuthMiddleware;

return function (App $app) use ($pdo) {

    $app->group('/auth', function ($app) use ($pdo) {


        $app->post('/login', function (Request $request, Response $response) use ($pdo) {
            $requestBody = json_decode($request->getBody()->getContents(), true);
            $email = $requestBody['email'];
            $password = $requestBody['password'];

            $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
            $stmt->execute([$email]);
            $user = $stmt->fetch();


            if ($user && password_verify($password, $user['password'])) {
                $id = $user['id'];
                $username = $user['username'];
                $role = $user['role'];
                $res = generateToken($id, $username, $role);
                $response = $response->withHeader('Set-Cookie', 'SESSION=' . $res['token'] . '; Path= /' . '; HttpOnly' . '; expires=' . gmdate('D, d M Y H:i:s \G\M\T', $res['exp']));
                $message = [
                    'message' => 'Login successful.',
                ];
                $responseBody = json_encode($message);
                $response->withStatus(401);
                $response->getBody()->write($responseBody);
                return $response;
            } else {
                $message = [
                    'message' => 'Invalid email or password',
                ];
                $responseBody = json_encode($message);
                $response->withStatus(401);
                $response->getBody()->write($responseBody);
                return $response;
            }
        });


        $app->post('/register', function (Request $request, Response $response) use ($pdo) {
            $requestBody = json_decode($request->getBody()->getContents(), true);
            $email = $requestBody['email'];
            $password = $requestBody['password'];
            $username = $requestBody['username'];
            $role = $requestBody['role'] ?? 'customer';
            $status = $requestBody['status'] ?? 'active';
            //     // Check if the username is already taken
            $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
            $stmt->execute([$username]);
            $existingUser = $stmt->fetch();
            if ($existingUser) {
                $message = [
                    'message' => 'Username already taken.',
                ];
                $responseBody = json_encode($message);
                $response->withStatus(401);
                $response->getBody()->write($responseBody);
                return $response;
            }

            $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
            $stmt->execute([$email]);
            $existingUser = $stmt->fetch();

            if ($existingUser) {
                $message = [
                    'message' => 'Email already taken.',
                ];
                $responseBody = json_encode($message);
                $response->withStatus(409);
                $response->getBody()->write($responseBody);
                return $response;

            }
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare("INSERT INTO users (username, email, password, role, status) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$username, $email, $hashedPassword, $role, $status]);

            $response->getBody()->write("Registration successful.");
            $response = $response->withStatus(200);
            return $response;
        });
    });
    $app->group('/user', function ($app) use ($pdo, ) {

        // Route for getting all users (for admin only)
        $app->get('/', function (Request $request, Response $response, $next) use ($pdo) {

            $stmt = $pdo->query("SELECT * FROM users");
            $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $responseBody = json_encode($users);
            $response->getBody()->write($responseBody);


        })->add(verifyTokenAndAdmin::class);
        $app->get('/find', function (Request $request, Response $response, $next) use ($pdo) {


            $userId = $request->getAttribute('userId');
            $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
            $stmt->execute([$userId]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$user) {
                $message = [
                    'message' => 'User not found'];
                $responseBody = json_encode($message);
    
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(404);
                $response->getBody()->write($responseBody);
                return $response;
            }
               // Set headers to indicate JSON response
               $response = $response->withHeader('Content-Type', 'application/json');
               $responseBody = json_encode($user);
               $response->getBody()->write($responseBody);
               return $response;

        })->add(verifyTokenAndAuthorization::class);




        // Add more routes for the users endpoint
    });


};