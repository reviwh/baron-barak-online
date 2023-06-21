<?php
include_once 'connect.php';

$id_menu = $_GET['id'];

$query = $db->query("SELECT * FROM `menu` JOIN penjual WHERE menu.id_penjual = penjual.id_penjual AND id_menu = $id_menu");

$data = array();

while ($row = $query->fetch_assoc()) {
    $data['id_menu'] = $row['id_menu'];
    $data['nama_menu'] = $row['nama_menu'];
    $data['harga'] = $row['harga'];
    $data['menu_image'] = base64_encode($row['menu_image']);
    $data['id_penjual'] = $row['id_penjual'];
    $data['nama'] = $row['nama'];
    $data['qty'] = "null";
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
?>
