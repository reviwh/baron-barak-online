<?php
$url = "localhost";
$username = "root";
$password = "";
$db_name = "desktop";
$db = new mysqli($url, $username, $password, $db_name);

if ($db->connect_error) {
    die("Connection failed: ".$db->connect_errno);
}
