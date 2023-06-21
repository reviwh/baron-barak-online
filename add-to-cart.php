<?php
include_once "connect.php";

$id_menu = $_POST['id_menu'];
$qty = intval($_POST['qty']);
$id_pelanggan = $_POST['id_pelanggan'];

$query = $db->query("SELECT * FROM keranjang WHERE id_menu=$id_menu AND id_pelanggan='$id_pelanggan'");
if ($query->num_rows>0) {
    $data = $query->fetch_array();
    $qty = intval($data['qty']) + $qty;
    $query = $db->query("UPDATE keranjang SET qty=$qty WHERE id_keranjang=$data[id_keranjang]");
    if ($query) {
        $response['success'] = true;
    } else {
        $response['success'] = false;
    }
} else {
    $query = $db->query("INSERT INTO keranjang(id_menu, qty, id_pelanggan) VALUES ($id_menu, $qty, '$id_pelanggan')");
    if ($query) {
        $response['success'] = true;
    } else {
        $response['success'] = false;
    }
}

$db->close();

header("Content-Type: application/json");
echo json_encode($response);
