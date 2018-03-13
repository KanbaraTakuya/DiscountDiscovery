<?php
    $username = $POST['uname'];
    $password = $POST['psw'];

    $username = stripcslashes[$username];
    $password = stripcslashes[$password];
    $username = mysql_real_escape_string($username);
    $password = mysql_real_escape_string($password);

    // connect to the server and select database



?>