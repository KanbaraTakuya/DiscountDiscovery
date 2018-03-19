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

//Variables to store the username and password from user input
$username = $password = "";

//Retrieve the data from the post request, sent from the last page
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  //Verify the inputs, prevent XSS
  $username = test_input($_POST["username"]);
  $password = test_input($_POST["password"]);
}

//Used to prevent XSS attacks, everything below are in-built to php
function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

//Perform an SQL query, find the password and userID based on the username
function checkLogin($db, $username, $password) {
 $query = "SELECT id, password FROM user WHERE username=?";

 //Using prepared statements to prevent SQL Injection
 if ($stmt = $db->prepare($query)) {
   //In the query, the ? allows us to insert the username in its place
   //bind_param is used to prevent SQL Injection from the user input
   $stmt -> bind_param("s", $username);

   //Perform the query
   if ($stmt->execute()) {
     //Store the result locally and bind the result to the two variables
     $stmt->store_result();
     $stmt->bind_result($uid, $pass);

     //While the statement still has data in the result set, (should only ever be one result)
     //verify the password using php in-built function
     while ($stmt->fetch()) {
       if(password_verify($password, $pass)) {
         //If the password is valid, return the user id
         return $uid;
       }
     }
     //Destory the locally held data
     $stmt->free_result();
   }
  }
 return false;
}

//Used to set the session variables if the login is valid
function login($db, $username, $password) {
  $userid = checkLogin($db, $username, $password);
  if ($userid) {
    //Set the php session variables
    $_SESSION['user_id'] = $userid;
    $_SESSION['username'] = $username;
    return true;
  }
  return false;
}

//Only try to login if the user a session if not started
if (!isset($_SESSION['user_id'])) {

  //Try to login using the provided credentials
  if (login($mysqli, $username, $password)) {
    // echo $username;
    // echo $password;
    //In order to access this data from other pages, just write some php inside the standard tags
    //that echos the code --> $_SESSION['user_id']
    //We have two stored variables so far, 'user_id' and 'username'
    $_SESSION['lsuccess'] = True;
    header("Location: ./profile.html");
  } else {
    $_SESSION['lsuccess'] = False;
    header("Location: ./index.php");
  }
} else {
  $_SESSION['lsuccess'] = True;
  header("Location: ./profile.html");
}

// Close the connection to the database
$mysqli -> close();
?>