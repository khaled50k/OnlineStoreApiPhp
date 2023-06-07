<?php
use Slim\App;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Routing\RouteCollectorProxy;
use Rakit\Validation\Validator;



require __DIR__ . '/../app/Middleware/AuthMiddleware.php';
use App\Middleware\AuthMiddleware;

require('../vendor/autoload.php');


return function (App $app) use ($pdo) {

    $app->group('/auth', function ($app) use ($pdo) {


        $app->post('/login', function (Request $request, Response $response) use ($pdo) {
            $requestBody = json_decode($request->getBody()->getContents(), true);
            $email = $requestBody['email'];
            $password = $requestBody['password'];

            $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ? ");
            $stmt->execute([$email]);
            $user = $stmt->fetch();
            if ($user['status'] === 'inactive') {
                $response = $response->withHeader('Content-Type', 'application/json');
                $message = [
                    'message' => 'Your account is inactive.',
                ];
                $responseBody = json_encode($message);
                $response->withStatus(401);
                $response->getBody()->write($responseBody);
                return $response;
            }

            if ($user && $user['deleted'] === 1) {

                $response = $response->withHeader('Content-Type', 'application/json');

                $message = [
                    'message' => 'Your account is deleted.',
                ];
                $responseBody = json_encode($message);
                $response->withStatus(401);
                $response->getBody()->write($responseBody);
                return $response;

            }

            if ($user && password_verify($password, $user['password'])) {
                // ... your existing code ...

                $id = $user['id'];
                $username = $user['username'];
                $role = $user['role'];
                $res = generateToken($id, $username, $role);
                $response = $response->withHeader('Set-Cookie', 'PHPSESSION=' . $res['token'] . '; Path= /' . '; expires=' . gmdate('D, d M Y H:i:s \G\M\T', $res['exp']));
                $message = [
                    'message' => 'Login successful.',
                ];
                $response = $response->withHeader('Content-Type', 'application/json');
                $responseBody = json_encode($message);

                return $response;
            } else {
                $response = $response->withHeader('Content-Type', 'application/json');

                $message = [
                    'message' => 'Invalid email or password',
                ];
                $responseBody = json_encode($message);
                $response = $response->withStatus(401); // Update the status code to 401
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
            $validator = new Validator;
            $validation = $validator->validate($requestBody, [
                'username' => 'required|min:4',
                'email' => 'required|email',
                'password' => 'required|min:6 ',
            ]);

            $validation->validate();
            if ($validation->fails()) {
                $errors = $validation->errors()->firstOfAll();
                // Handle validation errors
                $responseBody = json_encode(['errors' => $errors]);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;

            }
            //     // Check if the username is already taken
            $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
            $stmt->execute([$username]);
            $existingUser = $stmt->fetch();
            if ($existingUser) {
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $message = [
                    'errors' => ['username' => 'Username already taken.'],
                ];
                $responseBody = json_encode($message);
                $response->withStatus(401);
                $response->getBody()->write($responseBody);
                return $response;
            }
            $response = $response->withHeader('Content-Type', 'application/json');

            $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
            $stmt->execute([$email]);
            $existingUser = $stmt->fetch();
            $response = $response->withStatus(400);
            if ($existingUser) {
                $message = [
                    'errors' => ['email' => 'Email already taken.'],
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
        $app->post('/logout/{user_id}', function (Request $request, Response $response) use ($pdo) {
            $userId = $request->getAttribute('userId');

            if (revokeToken($userId)) {

                $message = [
                    'message' => 'Logout successfully'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response->getBody()->write($responseBody);
                return $response;
            }

            $message = [
                'error' => 'Logout error'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAuthorization::class);
    });
    $app->group('/user', function ($app) use ($pdo) {

        // Route for getting all users (for admin only)
        $app->get('/', function (Request $request, Response $response) use ($pdo) {

            $stmt = $pdo->query("SELECT * FROM users WHERE  deleted = 0 ");
            $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $responseBody = json_encode($users);
            $response->getBody()->write($responseBody);
            $response = $response->withHeader('Content-Type', 'application/json');

            return $response;

        })->add(verifyTokenAndAdmin::class);

        $app->get('/userdetails', function (Request $request, Response $response) use ($pdo) {
            $responseBody = json_encode($request->getAttribute('user'));
            $response->getBody()->write($responseBody);
            $response = $response->withHeader('Content-Type', 'application/json');

            return $response;

        })->add(userDataByToken::class);

        $app->get('/{user_id}', function (Request $request, Response $response, $args) use ($pdo) {
            $userId = $args['user_id'];
            $stmt = $pdo->prepare("SELECT * FROM users WHERE   deleted = 0 AND id = ? ");
            $stmt->execute([$userId]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$user) {
                $message = [
                    'message' => 'User not found'
                ];
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
        $app->put('/', function (Request $request, Response $response, $next) use ($pdo) {
            try {

                $isUser = $request->getAttribute('isUser');

                $requestBody = json_decode($request->getBody()->getContents(), true);
                $email = $requestBody['email'];
                $password = $requestBody['password'];
                $username = $requestBody['username'];
                $role = $requestBody['role'] ?? 'customer';
                $status = $requestBody['status'] ?? 'active';
                $validator = new Validator;
                $validation = $validator->validate($requestBody, [
                    'username' => 'required|min:4',
                    'email' => 'required|email',
                    'password' => 'required|min:6 ',
                ]);

                $validation->validate();
                if ($validation->fails()) {
                    $errors = $validation->errors()->firstOfAll();
                    // Handle validation errors
                    $responseBody = json_encode(['errors' => $errors]);
                    $response = $response->withHeader('Content-Type', 'application/json');
                    $response = $response->withStatus(400);
                    $response->getBody()->write($responseBody);
                    return $response;

                }
                $userId = $request->getAttribute('userId');
                $existingDataStmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
                $existingDataStmt->execute([$userId]);
                $existingData = $existingDataStmt->fetch(PDO::FETCH_ASSOC);

                // Check if 'a' new password is provided in the request body
                if (isset($requestBody['password']) && !empty($requestBody['password'])) {
                    // Update the password
                    $requestBody['password'] = password_hash($requestBody['password'], PASSWORD_DEFAULT);
                } else {
                    // Retain the existing password from the database
                    $requestBody['password'] = $existingData['password'];
                }

                // Remove the userId from the updated data
                unset($requestBody['id']);

                // Perform validation
                $errors = [];

                if (isset($requestBody['username']) && empty($requestBody['username'])) {
                    $errors['username'] = 'Username is required';
                } else if (isset($requestBody['username']) && !preg_match('/^[a-zA-Z]+$/', $requestBody['username'])) {
                    $errors['username'] = 'Username should only contain letters';
                }

                if (isset($requestBody['email']) && empty($requestBody['email'])) {
                    $errors['email'] = 'Email is required';
                } elseif (isset($requestBody['email']) && !filter_var($requestBody['email'], FILTER_VALIDATE_EMAIL)) {
                    $errors['email'] = 'Invalid email format';
                }

                if (isset($requestBody['password']) && strlen($requestBody['password']) < 6) {
                    $errors['password'] = 'Password should be at least 6 characters long';
                }

                if (!empty($errors)) {
                    // Handle validation errors
                    $responseBody = json_encode(['errors' => $errors]);
                    $response = $response->withHeader('Content-Type', 'application/json');
                    $response = $response->withStatus(400);
                    $response->getBody()->write($responseBody);
                    return $response;
                }

                // Construct the update statement
                $updateStmt = 'UPDATE users SET ';
                $params = [];
                foreach ($requestBody as $key => $value) {
                    $updateStmt .= $key . ' = :' . $key . ', ';
                    $params[$key] = $value;
                }
                $updateStmt = rtrim($updateStmt, ', ') . ' WHERE id = :id';
                $params['id'] = $userId;

                // Prepare and execute the update statement
                $stmt = $pdo->prepare($updateStmt);
                $stmt->execute($params);

                if ($stmt->rowCount() > 0) {
                    revokeToken($userId);
                    if ($isUser) {
                        # code...
                        $res = generateToken($userId, $requestBody['username'], $requestBody['role']);

                        $response = $response->withHeader('Set-Cookie', 'PHPSESSION=' . $res['token'] . '; Path= /' . '; expires=' . gmdate('D, d M Y H:i:s \G\M\T', $res['exp']));

                    }
                    $message = [
                        'message' => 'User updated successfully'
                    ];
                    $responseBody = json_encode($message);
                    $response = $response->withHeader('Content-Type', 'application/json');
                    $response->getBody()->write($responseBody);
                    return $response;
                }

                $message = [
                    'errors' => ['username' => 'User update failed'],
                ];
                $responseBody = json_encode($message);

                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(404);
                $response->getBody()->write($responseBody);
                return $response;

            } catch (PDOException $exception) {
                // Handle any database-related errors
                $responseBody = json_encode(['errors' => 'Database error']);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(500);
                $response->getBody()->write($responseBody);
                return $response;
            }
        })->add(verifyTokenAndAuthorization::class);

        $app->delete('/', function (Request $request, Response $response, $next) use ($pdo) {
            $userId = $request->getAttribute('userId');

            // Get the cart ID of the user
            $stmt = $pdo->prepare("SELECT id FROM carts WHERE user_id = :user_id");
            $stmt->execute(['user_id' => $userId]);
            $cartId = $stmt->fetchColumn();

            // Return the item product quantity to the product stock
            $stmt = $pdo->prepare("UPDATE products p
                                   JOIN cart_items ci ON p.id = ci.product_id
                                   SET p.stock = p.stock + ci.quantity
                                   WHERE ci.cart_id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);

            // Delete the user's cart items
            $stmt = $pdo->prepare("DELETE FROM cart_items WHERE cart_id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);

            // Delete the user's cart
            $stmt = $pdo->prepare("DELETE FROM carts WHERE id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);

            // Delete the user
            $stmt = $pdo->prepare("UPDATE users SET deleted = 1 WHERE id = :user_id");
            $stmt->execute(['user_id' => $userId]);


            revokeToken($userId);
            if ($stmt->rowCount() > 0) {
                $message = [
                    'message' => 'User deleted successfully'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response->getBody()->write($responseBody);
                return $response;
            }

            $message = [
                'message' => 'User not found or deletion failed'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(404);
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAuthorization::class);


        // Add more routes for the users endpoint
    });
    $app->group(('/category'), function ($app) use ($pdo) {

        $app->post('/', function (Request $request, Response $response, $next) use ($pdo) {
            $requestBody = json_decode($request->getBody()->getContents(), true);
            $validator = new Validator;
            // Define validation rules
            $validation = $validator->validate($requestBody, [
                'title' => 'required|min:3',
                'description' => 'required',
                'images' => 'required|array',
            ]);

            $validation->validate();


            if ($validation->fails()) {
                $errors = $validation->errors()->firstOfAll();
                // Handle validation errors
                $responseBody = json_encode(['errors' => $errors]);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;

            }

            $stmt = $pdo->prepare("INSERT INTO categories (title, description,images) VALUES (:title, :description,:images)");
            $stmt->execute([
                'title' => $requestBody['title'],
                'description' => $requestBody['description'],
                'images' => json_encode($requestBody['images']),
            ]);
            if ($stmt->rowCount() > 0) {
                $message = [
                    'message' => 'Category created successfully'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response->getBody()->write($responseBody);
                return $response;
            }

            $message = [
                'message' => 'Failed to create category'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(500);
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAdmin::class);
        $app->put('/{id}', function (Request $request, Response $response, $args) use ($pdo) {
            $requestBody = json_decode($request->getBody()->getContents(), true);
            $validator = new Validator;

            // Define validation rules
            $validation = $validator->validate($requestBody, [
                'title' => 'required|min:3',
                'description' => 'required',
                'images' => 'required|array',
                'images.*.url' => 'required|url',
            ]);

            $validation->validate();

            if ($validation->fails()) {
                $errors = $validation->errors()->firstOfAll();
                // Handle validation errors
                $responseBody = json_encode(['errors' => $errors]);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;
            }

            $id = $args['id'];

            $stmt = $pdo->prepare("UPDATE categories SET title = :title, description = :description, images = :images WHERE id = :id");
            $stmt->execute([
                'id' => $id,
                'title' => $requestBody['title'],
                'description' => $requestBody['description'],
                'images' => json_encode($requestBody['images']),
            ]);

            if ($stmt->rowCount() > 0) {
                $message = [
                    'message' => 'Category updated successfully'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response->getBody()->write($responseBody);
                return $response;
            }

            $message = [
                'errors' => ['category' => 'Failed to update category']
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(500);
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAdmin::class);


        $app->delete('/{id}', function (Request $request, Response $response, $args) use ($pdo) {
            $id = $args['id'];

            // Validate ID parameter
            if (!$id) {
                $message = [
                    'message' => 'Category ID is required'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;
            }

            try {
                $pdo->beginTransaction();

                $stmt = $pdo->prepare("DELETE FROM product_categories WHERE category_id = :category_id");
                $stmt->execute([
                    'category_id' => $id,
                ]);

                $stmt = $pdo->prepare("DELETE FROM categories WHERE id = :id");
                $stmt->execute([
                    'id' => $id,
                ]);

                if ($stmt->rowCount() > 0) {
                    $pdo->commit();
                    $message = [
                        'message' => 'Category deleted successfully'
                    ];
                    $responseBody = json_encode($message);
                    $response = $response->withHeader('Content-Type', 'application/json');
                    $response->getBody()->write($responseBody);
                    return $response;
                } else {
                    $pdo->rollBack();
                    $message = [
                        'message' => 'Failed to delete category'
                    ];
                    $responseBody = json_encode($message);
                    $response = $response->withHeader('Content-Type', 'application/json');
                    $response = $response->withStatus(500);
                    $response->getBody()->write($responseBody);
                    return $response;
                }
            } catch (Exception $e) {
                $pdo->rollBack();
                $message = [
                    'message' => 'An error occurred while deleting the category'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(500);
                $response->getBody()->write($responseBody);
                return $response;
            }
        })->add(verifyTokenAndAdmin::class);


        $app->get('/', function (Request $request, Response $response) use ($pdo) {
            $stmt = $pdo->query("SELECT * FROM categories");
            $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($categories as &$category) {
                $category['images'] = json_decode($category['images']);
            }
            $responseBody = json_encode($categories);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        });
        $app->get('/{id}', function (Request $request, Response $response, $args) use ($pdo) {
            $id = $args['id'];

            $stmt = $pdo->prepare("SELECT * FROM categories WHERE id = :id");
            $stmt->execute(['id' => $id]);
            $category = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($category) {
                $category['images'] = json_decode($category['images']);
                $responseBody = json_encode($category);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response->getBody()->write($responseBody);
                return $response;
            }

            $message = [
                'message' => 'Category not found'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(404);
            $response->getBody()->write($responseBody);
            return $response;
        });


    });
    $app->group(('/product'), function ($app) use ($pdo) {

        $app->post('/', function (Request $request, Response $response, $next) use ($pdo) {
            $requestBody = json_decode($request->getBody()->getContents(), true);
            $validator = new Validator;
            $validation = $validator->validate($requestBody, [
                'title' => 'required|min:3',
                'description' => 'required',
                'discount' => 'required|numeric|min:0',
                'stock' => 'required|numeric|min:0',
                'price' => 'required|numeric|min:0',
                'categories' => 'required|array|min:1',
                'categories.*.id' => 'required|numeric',
                'images' => 'required|array|min:1',
                'images.*.url' => 'required|url',
            ]);

            if ($validation->fails()) {
                $errors = $validation->errors()->firstOfAll();
                $responseBody = json_encode(['errors' => $errors]);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;
            }

            $stmt = $pdo->prepare("INSERT INTO products (title, description, images, price, discount, stock) 
                                   VALUES (:title, :description, :images, :price, :discount, :stock)");

            $stmt->execute([
                'title' => $requestBody['title'],
                'description' => $requestBody['description'],
                'images' => json_encode($requestBody['images']),
                'price' => $requestBody['price'],
                'discount' => $requestBody['discount'],
                'stock' => $requestBody['stock']
            ]);

            if ($stmt->rowCount() > 0) {
                $productID = $pdo->lastInsertId();

                // Insert the categories
                $categories = $requestBody['categories'];
                $stmt = $pdo->prepare("INSERT INTO product_categories (product_id, category_id) VALUES (:product_id, :category_id)");
                foreach ($categories as $category) {
                    $stmt->execute(['product_id' => $productID, 'category_id' => $category['id']]);
                }

                $message = [
                    'message' => 'Product created successfully'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response->getBody()->write($responseBody);
                return $response;
            }

            $message = [
                'message' => 'Failed to create product'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(500);
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAdmin::class);


        $app->put('/{id}', function (Request $request, Response $response, $args) use ($pdo) {
            $id = $args['id'];
            $requestBody = json_decode($request->getBody()->getContents(), true);
            $validator = new Validator;
            // Define validation rules
            $validation = $validator->validate($requestBody, [
                'title' => 'required|min:3',
                'description' => 'required',
                'discount' => 'required|numeric|min:0',
                'stock' => 'required|numeric|min:0',
                'price' => 'required|numeric|min:0',
                'categories' => 'required|array|min:1',
                'categories.*.id' => 'required|numeric',
                'images' => 'required|array|min:1',
                'images.*.url' => 'required|url',
            ]);
            $validation->validate();

            if ($validation->fails()) {
                $errors = $validation->errors()->firstOfAll();
                $responseBody = json_encode(['errors' => $errors]);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;
            }

            // Fetch the existing product data
            $stmt = $pdo->prepare("SELECT * FROM products WHERE id = :id");
            $stmt->execute(['id' => $id]);
            $product = $stmt->fetch(PDO::FETCH_ASSOC);

            // Update the columns only if they are present in the request and have changed
            $updateData = [];
            if (isset($requestBody['title']) && $requestBody['title'] !== $product['title']) {
                $updateData['title'] = $requestBody['title'];
            }
            if (isset($requestBody['description']) && $requestBody['description'] !== $product['description']) {
                $updateData['description'] = $requestBody['description'];
            }
            if (isset($requestBody['images']) && $requestBody['images'] !== $product['images']) {
                $updateData['images'] = json_encode($requestBody['images']);
            }
            if (isset($requestBody['price']) && $requestBody['price'] !== $product['price']) {
                $updateData['price'] = $requestBody['price'];
            }
            if (isset($requestBody['discount']) && $requestBody['discount'] !== $product['discount']) {
                $updateData['discount'] = $requestBody['discount'];
            }
            if (isset($requestBody['stock']) && $requestBody['stock'] !== $product['stock']) {
                $updateData['stock'] = $requestBody['stock'];
            }

            // Update the product if any changes are detected
            if (!empty($updateData)) {
                // Create a string of column placeholders for the update query
                $placeholders = implode(', ', array_map(fn($column) => "$column = :$column", array_keys($updateData)));

                // Add the 'id' column to the update data array
                $updateData['id'] = $id;

                // Prepare and execute the update query
                $stmt = $pdo->prepare("UPDATE products SET $placeholders WHERE id = :id");
                $stmt->execute($updateData);
            }

            // Update the categories if provided
            if (isset($requestBody['categories']) && is_array($requestBody['categories'])) {
                // Delete existing categories for the product
                $stmt = $pdo->prepare("DELETE FROM product_categories WHERE product_id = :id");
                $stmt->execute(['id' => $id]);

                // Insert the updated categories
                $categories = $requestBody['categories'];
                $stmt = $pdo->prepare("INSERT INTO product_categories (product_id, category_id) VALUES (:product_id, :category_id)");
                foreach ($categories as $category) {
                    $stmt->execute(['product_id' => $id, 'category_id' => $category['id']]);
                }
            }

            $message = [
                'message' => 'Product updated successfully'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAdmin::class);


        $app->delete('/{id}', function (Request $request, Response $response, $args) use ($pdo) {
            $id = $args['id'];

            if (!$id) {
                $message = [
                    'message' => 'Product ID is required'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;
            }
            $stmt = $pdo->prepare("DELETE FROM product_categories WHERE product_id = :product_id");
            $stmt->execute([
                'product_id' => $id,
            ]);

            if ($stmt->rowCount() > 0) {
                $stmt = $pdo->prepare("DELETE FROM products WHERE id = :id");
                $stmt->execute([
                    'id' => $id,
                ]);
                if ($stmt->rowCount() > 0) {

                    $message = [
                        'message' => 'Product deleted successfully'
                    ];
                    $responseBody = json_encode($message);
                    $response = $response->withHeader('Content-Type', 'application/json');
                    $response->getBody()->write($responseBody);
                    return $response;
                }
                $message = [
                    'message' => 'Failed to delete product'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(500);
                $response->getBody()->write($responseBody);
                return $response;
            }



            $message = [
                'message' => 'Failed to delete product'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(500);
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAdmin::class);

        $app->get('/', function (Request $request, Response $response) use ($pdo) {
            $stmt = $pdo->prepare("SELECT p.*, c.title AS category_title, c.id AS category_id
                          FROM products p
                          LEFT JOIN product_categories pc ON p.id = pc.product_id
                          LEFT JOIN categories c ON pc.category_id = c.id");
            $stmt->execute();
            $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Process the result and format it as needed
            $formattedProducts = [];
            foreach ($products as $product) {
                $productId = $product['id'];
                $categoryTitle = $product['category_title'];
                $categoryId = $product['category_id'];

                // If the product doesn't exist in the formattedProducts array, add it
                if (!isset($formattedProducts[$productId])) {
                    $formattedProducts[$productId] = [
                        'id' => $productId,
                        'title' => $product['title'],
                        'description' => $product['description'],
                        'images' => json_decode($product['images'], true),
                        'price' => $product['price'],
                        'discount' => $product['discount'],
                        'stock' => $product['stock'],
                        'categories' => []
                    ];
                }

                // If a category title is associated with the product, add it to the categories array
                if ($categoryTitle) {
                    $formattedProducts[$productId]['categories'][] = [
                        'title' => $categoryTitle,
                        'id' => $categoryId
                    ];
                }
            }

            // Convert the array of formatted products to JSON and return the response
            $responseBody = json_encode(array_values($formattedProducts));
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        });
        $app->get('/{id}', function (Request $request, Response $response, $args) use ($pdo) {
            $id = $args['id'];

            $stmt = $pdo->prepare("SELECT p.*, GROUP_CONCAT(c.title) AS category_titles
                                  FROM products p
                                  LEFT JOIN product_categories pc ON p.id = pc.product_id
                                  LEFT JOIN categories c ON pc.category_id = c.id
                                  WHERE p.id = :id
                                  GROUP BY p.id");
            $stmt->execute(['id' => $id]);
            $product = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($product) {
                $productId = $product['id'];

                $formattedProduct = [
                    'id' => $productId,
                    'title' => $product['title'],
                    'description' => $product['description'],
                    'images' => json_decode($product['images'], true),
                    'price' => $product['price'],
                    'discount' => $product['discount'],
                    'stock' => $product['stock'],
                    'categories' => explode(',', $product['category_titles']),
                ];

                // Convert the formatted product to JSON and return the response
                $responseBody = json_encode($formattedProduct);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response->getBody()->write($responseBody);
                return $response;
            }

            // Product not found
            $message = [
                'message' => 'Product not found'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(404);
            $response->getBody()->write($responseBody);
            return $response;

        });
    });
    $app->group(('/cart'), function ($app) use ($pdo) {

        $app->post('/', function (Request $request, Response $response, $next) use ($pdo) {
            $requestBody = json_decode($request->getBody()->getContents(), true);
            $validator = new Validator;
            $validation = $validator->validate($requestBody, [
                'user_id' => 'required|numeric',
                'items' => 'required|array',
                'items.*.product_id' => 'required|numeric',
                'items.*.quantity' => 'required|numeric',
            ]);
            $userId = $requestBody['user_id'];
            $items = $requestBody['items'];

            if ($validation->fails()) {
                $errors = $validation->errors()->firstOfAll();
                $responseBody = json_encode(['errors' => $errors]);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;
            }


            // Check if the user already has a cart
            $stmt = $pdo->prepare("SELECT id FROM carts WHERE user_id = :user_id");
            $stmt->execute(['user_id' => $userId]);
            $cartId = $stmt->fetchColumn();

            // If the user doesn't have a cart, create a new cart for the user
            if (!$cartId) {
                $stmt = $pdo->prepare("INSERT INTO carts (user_id) VALUES (:user_id)");
                $stmt->execute(['user_id' => $userId]);
                $cartId = $pdo->lastInsertId();
            }

            // Iterate over each item in the cart
            foreach ($items as $item) {
                $productId = $item['product_id'];
                $quantity = $item['quantity'];

                // Check if the product exists
                $stmt = $pdo->prepare("SELECT stock FROM products WHERE id = :product_id");
                $stmt->execute(['product_id' => $productId]);
                $productStock = $stmt->fetchColumn();

                if ($productStock === false) {
                    // Return an error response if the product doesn't exist
                    $message = [
                        'error' => 'Product ' . $productId . ' does not exist'
                    ];
                    $responseBody = json_encode($message);
                    $response = $response->withHeader('Content-Type', 'application/json');
                    $response = $response->withStatus(400);
                    $response->getBody()->write($responseBody);
                    return $response;
                }

                // Retrieve the current quantity of the product in the cart
                $stmt = $pdo->prepare("SELECT quantity FROM cart_items WHERE cart_id = :cart_id AND product_id = :product_id");
                $stmt->execute(['cart_id' => $cartId, 'product_id' => $productId]);
                $existingQuantity = $stmt->fetchColumn();

                if ($existingQuantity) {
                    // If the product is already in the cart, increase the quantity
                    $newquantity = $existingQuantity + $quantity;
                    // Update the quantity in the cart_items table
                    $stmt = $pdo->prepare("UPDATE cart_items SET quantity = :new_quantity 
                                           WHERE cart_id = :cart_id AND product_id = :product_id");
                    $stmt->execute([
                        'new_quantity' => $newquantity,
                        'cart_id' => $cartId,
                        'product_id' => $productId
                    ]);
                } else {
                    // If the product is not in the cart, add it
                    $stmt = $pdo->prepare("INSERT INTO cart_items (cart_id, user_id, product_id, quantity) 
                               VALUES (:cart_id, :user_id, :product_id, :quantity)");
                    $stmt->execute([
                        'cart_id' => $cartId,
                        'user_id' => $userId,
                        'product_id' => $productId,
                        'quantity' => $quantity
                    ]);
                }

                // Update the product's stock
                $newStock = $productStock - $quantity;

                if ($newStock < 0) {
                    // Return an error response if the product stock is insufficient
                    $message = [
                        'error' => 'Insufficient stock for product ' . $productId
                    ];
                    $responseBody = json_encode($message);
                    $response = $response->withHeader('Content-Type', 'application/json');
                    $response = $response->withStatus(400);
                    $response->getBody()->write($responseBody);
                    return $response;
                }

                $stmt = $pdo->prepare("UPDATE products SET stock = :new_stock WHERE id = :product_id");
                $stmt->execute([
                    'new_stock' => $newStock,
                    'product_id' => $productId
                ]);
            }

            // Return a success response
            $message = [
                'message' => 'Cart items added successfully'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAuthorization::class);

        $app->put('/{cart_id}', function (Request $request, Response $response, $args) use ($pdo) {
            $cartId = $args['cart_id'];
            $requestBody = json_decode($request->getBody()->getContents(), true);

            // Validate the request body
            $validator = new Validator;
            $validation = $validator->validate($requestBody, [
                // 'items' => 'required|array',
            ]);
            $items = $requestBody['items'];
            if ($validation->fails()) {
                $errors = $validation->errors()->firstOfAll();
                $responseBody = json_encode(['errors' => $errors]);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(400);
                $response->getBody()->write($responseBody);
                return $response;
            }

            // Begin transaction
            $pdo->beginTransaction();

            try {
                // Iterate over each item in the cart
                foreach ($items as $item) {
                    $productId = $item['product_id'];
                    $quantity = $item['quantity'];

                    // Check if the product exists
                    $stmt = $pdo->prepare("SELECT COUNT(*) FROM products WHERE id = :product_id");
                    $stmt->execute(['product_id' => $productId]);
                    $productExists = $stmt->fetchColumn();

                    if (!$productExists) {
                        // Rollback the transaction and return an error response if the product doesn't exist
                        $pdo->rollBack();
                        $message = [
                            'error' => 'Product ' . $productId . ' does not exist'
                        ];
                        $responseBody = json_encode($message);
                        $response = $response->withHeader('Content-Type', 'application/json');
                        $response = $response->withStatus(400);
                        $response->getBody()->write($responseBody);
                        return $response;
                    }

                    // Retrieve the current quantity of the cart item from the database
                    $stmt = $pdo->prepare("SELECT quantity FROM cart_items WHERE cart_id = :cart_id AND product_id = :product_id");
                    $stmt->execute(['cart_id' => $cartId, 'product_id' => $productId]);
                    $currentQuantity = $stmt->fetchColumn();

                    // Retrieve the current stock of the product from the database
                    $stmt = $pdo->prepare("SELECT stock FROM products WHERE id = :product_id");
                    $stmt->execute(['product_id' => $productId]);
                    $currentStock = $stmt->fetchColumn();
                    // -20 -40=-60+160
// -20

                    // 160 -20
// 20 -40 = -20
// 20
                    // Calculate the difference between the new quantity and the current quantity
                    $quantityDiff = -$currentQuantity + $quantity;

                    if ($quantityDiff > $currentStock) {
                        // Rollback the transaction and return an error response if the requested quantity exceeds the current stock
                        $pdo->rollBack();
                        $message = [
                            'error' => 'Insufficient stock for product ' . $productId
                        ];
                        $responseBody = json_encode($message);
                        $response = $response->withHeader('Content-Type', 'application/json');
                        $response = $response->withStatus(400);
                        $response->getBody()->write($responseBody);
                        return $response;
                    }

                    $newStock = $currentStock - $quantityDiff;

                    // Update the quantity in the cart_items table
                    $stmt = $pdo->prepare("UPDATE cart_items SET quantity = :quantity WHERE cart_id = :cart_id AND product_id = :product_id");
                    $stmt->execute([
                        'quantity' => $quantity,
                        'cart_id' => $cartId,
                        'product_id' => $productId
                    ]);

                    // Update the stock in the products table
                    $stmt = $pdo->prepare("UPDATE products SET stock = :new_stock WHERE id = :product_id");
                    $stmt->execute([
                        'new_stock' => $newStock,
                        'product_id' => $productId
                    ]);
                }

                // Commit the transaction
                $pdo->commit();

                // Return a success response
                $message = [
                    'message' => 'Cart items updated successfully'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response->getBody()->write($responseBody);
                return $response;
            } catch (PDOException $e) {
                // Rollback the transaction and return an error response if an exception occurs
                $pdo->rollBack();
                $message = [
                    'error' => $e->getMessage()
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(500);
                $response->getBody()->write($responseBody);
                return $response;
            }
        })->add(verifyTokenAndAuthorization::class);
        // $app->put('/{id}', function (Request $request, Response $response, $args) use ($pdo, $validator) {
        //     $requestBody = json_decode($request->getBody()->getContents(), true);
        //     $queryParams = $request->getQueryParams();
        //     $queryParams['id'] = $requestBody['id'];
        //     $id = $args['id'];
        //     $validator = new Validator;
        //     $validation = $validator->validate($requestBody, [
        //         'items' => 'required|array',
        //     ]);
        //     $items = $requestBody['items'];

        //     if ($validation->fails()) {
        //         $errors = $validation->errors()->firstOfAll();
        //         $responseBody = json_encode(['errors' => $errors]);
        //         $response = $response->withHeader('Content-Type', 'application/json');
        //         $response = $response->withStatus(400);
        //         $response->getBody()->write($responseBody);
        //         return $response;
        //     }

        //     // Begin transaction
        //     $pdo->beginTransaction();

        //     try {
        //         // Iterate over each item in the cart
        //         foreach ($items as $item) {
        //             $productId = $item['product_id'];
        //             $quantity = $item['quantity'];

        //             // Check if the product exists
        //             $stmt = $pdo->prepare("SELECT COUNT(*) FROM products WHERE id = :product_id");
        //             $stmt->execute(['product_id' => $productId]);
        //             $productExists = $stmt->fetchColumn();

        //             if (!$productExists) {
        //                 // Rollback the transaction and return an error response if the product doesn't exist
        //                 $pdo->rollBack();
        //                 $message = [
        //                     'message' => 'Product ' . $productId . ' does not exist'
        //                 ];
        //                 $responseBody = json_encode($message);
        //                 $response = $response->withHeader('Content-Type', 'application/json');
        //                 $response = $response->withStatus(400);
        //                 $response->getBody()->write($responseBody);
        //                 return $response;
        //             }

        //             // Retrieve the current quantity of the cart item from the database
        //             $stmt = $pdo->prepare("SELECT quantity FROM cart_items WHERE id = :id");
        //             $stmt->execute(['id' => $id]);
        //             $currentQuantity = $stmt->fetchColumn();

        //             // Retrieve the current stock of the product from the database
        //             $stmt = $pdo->prepare("SELECT stock FROM products WHERE id = :product_id");
        //             $stmt->execute(['product_id' => $productId]);
        //             $currentStock = $stmt->fetchColumn();

        //             // Calculate the difference between the new quantity and the current quantity
        //             $quantityDiff = $quantity - $currentQuantity;

        //             if ($quantityDiff > $currentStock) {
        //                 // Rollback the transaction and return an error response if the requested quantity exceeds the current stock
        //                 $pdo->rollBack();
        //                 $message = [
        //                     'message' => 'Insufficient stock for product ' . $productId
        //                 ];
        //                 $responseBody = json_encode($message);
        //                 $response = $response->withHeader('Content-Type', 'application/json');
        //                 $response = $response->withStatus(400);
        //                 $response->getBody()->write($responseBody);
        //                 return $response;
        //             }

        //             // Update the quantity in the cart_items table
        //             $stmt = $pdo->prepare("UPDATE cart_items SET quantity = :quantity WHERE id = :id");
        //             $stmt->execute([
        //                 'quantity' => $quantity,
        //                 'id' => $id
        //             ]);

        //             // Calculate the new stock for the product
        //             $newStock = $currentStock + $quantityDiff;

        //             // Update the stock in the products table
        //             $stmt = $pdo->prepare("UPDATE products SET stock = :new_stock WHERE id = :product_id");
        //             $stmt->execute([
        //                 'new_stock' => $newStock,
        //                 'product_id' => $productId
        //             ]);
        //         }

        //         // Commit the transaction
        //         $pdo->commit();

        //         // Return a success response
        //         $message = [
        //             'message' => 'Cart items updated successfully'
        //         ];
        //         $responseBody = json_encode($message);
        //         $response = $response->withHeader('Content-Type', 'application/json');
        //         $response->getBody()->write($responseBody);
        //         return $response;
        //     } catch (PDOException $e) {
        //         // Rollback the transaction and return an error response if an exception occurs
        //         $pdo->rollBack();
        //         $message = [
        //             'error' => $e->getMessage()
        //         ];
        //         $responseBody = json_encode($message);
        //         $response = $response->withHeader('Content-Type', 'application/json');
        //         $response = $response->withStatus(500);
        //         $response->getBody()->write($responseBody);
        //         return $response;
        //     }
        // })->add(verifyTokenAndAuthorization::class);

        $app->delete('/{cart_id}', function (Request $request, Response $response, $args) use ($pdo) {
            $cartId = $args['cart_id'];

            // Check if the cart exists
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM carts WHERE id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);
            $cartExists = (int) $stmt->fetchColumn();

            if ($cartExists === 0) {
                // Return an error response if the cart does not exist
                $message = [
                    'error' => 'Cart does not exist'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(404);
                $response->getBody()->write($responseBody);
                return $response;
            }

            // Retrieve the cart items and their quantities
            $stmt = $pdo->prepare("SELECT product_id, quantity FROM cart_items WHERE cart_id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);
            $cartItems = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Delete the cart and its associated cart_items from the database
            $stmt = $pdo->prepare("DELETE FROM cart_items WHERE cart_id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);

            $stmt = $pdo->prepare("DELETE FROM carts WHERE id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);

            // Return the quantities of cart items back to the product stock
            foreach ($cartItems as $cartItem) {
                $productId = $cartItem['product_id'];
                $quantity = $cartItem['quantity'];

                $stmt = $pdo->prepare("UPDATE products SET stock = stock + :quantity WHERE id = :product_id");
                $stmt->execute([
                    'quantity' => $quantity,
                    'product_id' => $productId
                ]);
            }

            // Return a success response
            $message = [
                'message' => 'Cart and associated items deleted successfully'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAuthorization::class);
        $app->delete('/cart_item/{cart_item_id}', function (Request $request, Response $response, $args) use ($pdo) {
            $cartItemId = $args['cart_item_id'];

            // Check if the cart item exists
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM cart_items WHERE id = :cart_item_id");
            $stmt->execute(['cart_item_id' => $cartItemId]);
            $cartItemExists = (int) $stmt->fetchColumn();

            if ($cartItemExists === 0) {
                // Return an error response if the cart item does not exist
                $message = [
                    'error' => 'Cart item does not exist'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(404);
                $response->getBody()->write($responseBody);
                return $response;
            }

            // Retrieve the cart item details
            $stmt = $pdo->prepare("SELECT product_id, quantity, cart_id FROM cart_items WHERE id = :cart_item_id");
            $stmt->execute(['cart_item_id' => $cartItemId]);
            $cartItem = $stmt->fetch(PDO::FETCH_ASSOC);

            $productId = $cartItem['product_id'];
            $quantity = $cartItem['quantity'];
            $cartId = $cartItem['cart_id'];

            // Delete the cart item from the database
            $stmt = $pdo->prepare("DELETE FROM cart_items WHERE id = :cart_item_id");
            $stmt->execute(['cart_item_id' => $cartItemId]);

            // Return the quantity of the cart item back to the product stock
            $stmt = $pdo->prepare("UPDATE products SET stock = stock + :quantity WHERE id = :product_id");
            $stmt->execute([
                'quantity' => $quantity,
                'product_id' => $productId
            ]);

            // Return a success response
            $message = [
                'message' => 'Cart item deleted successfully'
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAuthorization::class);

        $app->get('/', function (Request $request, Response $response) use ($pdo) {
            // Retrieve all carts
            $stmt = $pdo->prepare("SELECT * FROM carts");
            $stmt->execute();
            $carts = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Create an empty array to hold the grouped carts
            $groupedCarts = [];

            // Iterate over each cart
            foreach ($carts as $cart) {
                $cartId = $cart['id'];

                // Retrieve the cart items for the current cart
                $stmt = $pdo->prepare("SELECT ci.quantity, p.title,ci.id as item_id,p.images as product_images, p.description as product_description, ci.id as cart_item_id, p.id as product_id, p.price, p.discount
                                       FROM cart_items ci
                                       INNER JOIN products p ON ci.product_id = p.id
                                       WHERE ci.cart_id = :cart_id");
                $stmt->execute(['cart_id' => $cartId]);
                $cartItems = $stmt->fetchAll(PDO::FETCH_ASSOC);

                // Assign the cart items to the current cart
                foreach ($cartItems as &$item) {
                    $item['product_images'] = json_decode($item['product_images'], true);
                }
                $cart['items'] = $cartItems;

                // Calculate the total amount and total price for each item in the current cart
                $totalAmount = 0;
                $totalDiscount = 0;
                foreach ($cartItems as &$item) {
                    $subtotal = $item['quantity'] * $item['price'] * (1 - $item['discount'] / 100);
                    $totalAmount += $subtotal;
                    $totalDiscount += ($subtotal * $item['discount'] / 100);
                    $item['total_price'] = $subtotal;
                }
                unset($item); // Unset the reference to the last item

                $cart['total_amount'] = $totalAmount;
                $cart['total_discount'] = $totalDiscount;

                // Group the cart by user_id
                $userId = $cart['user_id'];
                if (!isset($groupedCarts[$userId])) {
                    $groupedCarts[$userId] = [];
                }
                $groupedCarts[$userId] = $cart;
            }

            // Create the response JSON
            $responseCarts = [];
            foreach ($groupedCarts as $userId => $carts) {
                $responseCarts['cart'] = $carts;
            }

            $responseBody = json_encode(['carts' => $responseCarts]);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAuthorization::class);


        $app->get('/user/{user_id}', function (Request $request, Response $response, $args) use ($pdo) {
            $userId = $args['user_id'];


            // Retrieve carts for the specified user ID
            $stmt = $pdo->prepare("SELECT * FROM carts WHERE user_id = :user_id");
            $stmt->execute(['user_id' => $userId]);
            $carts = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Create an empty array to hold the grouped carts
            $groupedCarts = [];

            // Iterate over each cart
            foreach ($carts as $cart) {
                $cartId = $cart['id'];

                // Retrieve the cart items for the current cart
                $stmt = $pdo->prepare("SELECT ci.quantity, p.title, ci.id as item_id, p.images as product_images, p.description as product_description, ci.id as cart_item_id, p.id as product_id, p.price, p.discount
                               FROM cart_items ci
                               INNER JOIN products p ON ci.product_id = p.id
                               WHERE ci.cart_id = :cart_id");
                $stmt->execute(['cart_id' => $cartId]);
                $cartItems = $stmt->fetchAll(PDO::FETCH_ASSOC);

                // Assign the cart items to the current cart
                foreach ($cartItems as &$item) {
                    $item['product_images'] = json_decode($item['product_images'], true);
                }
                $cart['items'] = $cartItems;

                // Calculate the total amount and total price for each item in the current cart
                $totalAmount = 0;
                $totalDiscount = 0;
                foreach ($cartItems as &$item) {
                    $subtotal = $item['quantity'] * $item['price'] * (1 - $item['discount'] / 100);
                    $totalAmount += $subtotal;
                    $totalDiscount += ($subtotal * $item['discount'] / 100);
                    $item['total_price'] = $subtotal;
                }
                unset($item); // Unset the reference to the last item

                $cart['total_amount'] = $totalAmount;
                $cart['total_discount'] = $totalDiscount;

                // Group the cart by user_id
                if (!isset($groupedCarts[$userId])) {
                    $groupedCarts[$userId] = [];
                }
                $groupedCarts[$userId] = $cart;
            }

            // Create the response JSON
            $responseCarts = [];
            foreach ($groupedCarts as $userId => $carts) {
                $responseCarts = $carts;
            }

            $responseBody = json_encode(['cart' => $responseCarts]);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAuthorization::class);
        $app->get('/cart/{cart_id}', function (Request $request, Response $response, $args) use ($pdo) {
            $cartId = $args['cart_id'];

            // Retrieve the cart by its ID
            $stmt = $pdo->prepare("SELECT * FROM carts WHERE id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);
            $cart = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$cart) {
                // Return an error response if the cart doesn't exist
                $message = [
                    'error' => 'Cart does not exist'
                ];
                $responseBody = json_encode($message);
                $response = $response->withHeader('Content-Type', 'application/json');
                $response = $response->withStatus(404);
                $response->getBody()->write($responseBody);
                return $response;
            }

            // Retrieve the cart items for the current cart
            $stmt = $pdo->prepare("SELECT ci.quantity, p.title,ci.id as cart_item_id ,p.id  as product_id
                                   FROM cart_items ci
                                   INNER JOIN products p ON ci.product_id = p.id
                                   WHERE ci.cart_id = :cart_id");
            $stmt->execute(['cart_id' => $cartId]);
            $cartItems = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Assign the cart items to the cart
            $cart['items'] = $cartItems;

            // Create the response JSON
            $responseBody = json_encode(['cart' => $cart]);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response->getBody()->write($responseBody);
            return $response;
        })->add(verifyTokenAndAuthorization::class);

    });

    $app->post('/upload', function ($request, $response) {
        try {
            $uploadedFiles = $request->getUploadedFiles();
            if (!isset($uploadedFiles['image'])) {
                throw new Exception('No file uploaded.');
            }

            $uploadedFile = $uploadedFiles['image'];

            if ($uploadedFile->getError() !== UPLOAD_ERR_OK) {
                throw new Exception('Error uploading file.');
            }

            $directory = 'C:\xampp\htdocs\e-commerce-php\app\upload';
            $filename = moveUploadedFile($directory, $uploadedFile);

            $message = [
                'filename' => $filename
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(200);
            $response->getBody()->write($responseBody);
            return $response;
        } catch (Exception $e) {
            $message = [
                'error' => $e->getMessage()
            ];
            $responseBody = json_encode($message);
            $response = $response->withHeader('Content-Type', 'application/json');
            $response = $response->withStatus(400);
            $response->getBody()->write($responseBody);
            return $response;
        }
    })->add(verifyTokenAndAdmin::class);


    // Helper function to move the uploaded file to a specific directory
    function moveUploadedFile($directory, $uploadedFile)
    {
        // Get the file extension from the uploaded file
        $extension = pathinfo($uploadedFile->getClientFilename(), PATHINFO_EXTENSION);
    
        // Generate a unique filename using random bytes
        $basename = bin2hex(random_bytes(8));
    
        // Create the final filename by combining the basename and extension
        $filename = sprintf('%s.%0.8s', $basename, $extension);
    
        // Move the uploaded file to the specified directory with the new filename
        $uploadedFile->moveTo($directory . DIRECTORY_SEPARATOR . $filename);
    
        // Return the URL of the uploaded file
        return "http://localhost/e-commerce-php/app/upload/$filename";
    };
    

};