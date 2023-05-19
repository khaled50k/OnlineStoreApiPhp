<?php

// Database configuration
$dbHost = 'localhost';
$dbName = 'onlinestore';
$dbUser = 'root';
$dbPass = 'your_database_password';

try {
    // Create a new PDO instance and establish a database connection
    $pdo = new PDO("mysql:host=$dbHost;dbname=$dbName", $dbUser);
    
    // Set error mode to exception for better error handling
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    // If an exception occurs during database connection, output the error message and terminate the script
    die("Database connection failed: " . $e->getMessage());
}
