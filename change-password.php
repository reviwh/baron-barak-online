<?php
include_once 'connect.php';
$username = $_GET['username'];
$old_password = $_POST['old_password'];
$new_password = $_POST['new_password'];

$query = $db->query("SELECT * FROM users WHERE username = '$username' AND password = PASSWORD('$old_password')");

if ($query->num_rows>0){
    $query2 = $db->query("UPDATE users SET password=PASSWORD('$new_password') WHERE username='$username'");
    if($query2){
        $response['success'] = true;
    } 
} else {
    $response['success'] = false;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($response);