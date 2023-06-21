<?php
include_once "connect.php";

$id_keranjang = $_POST['id_keranjang'];
$qty = intval($_POST['qty']);

$query = $db->query("UPDATE keranjang SET qty=$qty WHERE id_keranjang=$id_keranjang");

if ($query) {
    $response['success'] = true;
} else {
    $response['success'] = false;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($response);
