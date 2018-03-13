<?php
    $username = $POST['uname'];
    $email = $POST['email'];
    $password = $POST['psw'];
    $repeat_password = $['psw-repeat'];
    

    $username = stripcslashes[$username];
    $email = stripcslashes[$email];
    $password = stripcslashes[$password];
    $repeat_password = stripcslashes[$repeat_password];
    $username = mysql_real_escape_string($username);
    $email = mysql_real_escape_string($email);
    $password = mysql_real_escape_string($password);
    $repeat_password = mysql_real_escape_string($repeat_password);

    // connect to the server and select database



?>
