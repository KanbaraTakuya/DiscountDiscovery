<?php
session_start();

// Load the configuration file containing your database credentials
require_once('config.inc.php');

// Connect to the database
$mysqli = new mysqli($database_host, $database_user, $database_pass, $group_dbnames[0]);

// Check for errors before doing anything else
if($mysqli -> connect_error) {
    die('Connect Error ('.$mysqli -> connect_errno.') '.$mysqli -> connect_error);
}


//Everything below is the same as login.php except the query we execute
$username = "";
$password = "";


//If the input is sent using POST, then try to get the username and password
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $username = test_input($_POST["username"]);
  $password = test_input($_POST["password"]);


  //If we found data from the POST request, attempt to create an account
  //We should return the user to the login page in either case
  $csuccess = createAccount($mysqli, $username, $password);
  $_SESSION['csuccess'] = $csuccess;
  header("Location: ./index.php");
}

//Used to prevent XSS attacks, in-built php functions
function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

function createAccount($db, $username, $password) {
  //Using an in-built php function, create the hashed password which we will store in the database
 $hashed_password = password_hash($password, PASSWORD_DEFAULT);

 //Create a prepared statement where we attempt to insert data into the database
 $stmt = $db->prepare("INSERT INTO user(username, password) VALUES (?, ?);");

 //Bind the username and hashed password to the prepared statement
 $stmt -> bind_param("ss", $username, $hashed_password);

 //Attempt to execute the statement, returns true if created account
 //returns false if the query failed for some reason
 return $stmt -> execute();
}
?>