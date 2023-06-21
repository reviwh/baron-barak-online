<?php
include_once "connect.php";

$id_keranjang = $_GET['id_keranjang'];

$query = $db->query("DELETE FROM keranjang WHERE id_keranjang=$id_keranjang");

if ($query) {
    $response['success'] = true;
} else {
    $response['success'] = false;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($response);
