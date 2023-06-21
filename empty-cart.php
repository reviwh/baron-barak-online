<?php
include_once "connect.php";

$id = $_GET['id'];

$query = $db->query("DELETE FROM keranjang WHERE id_pelanggan='$id'");

if ($query) {
    $response['success'] = true;
} else {
    $response['success'] = false;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($response);
