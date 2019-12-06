<?php 

$servername = "localhost";
$username = "gagn";
$password = "pass123";
$dbname = "ProgressTracker_V6";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connection_error) {
	die("Connection failed: " . $conn->connect_error); 
}


?>
