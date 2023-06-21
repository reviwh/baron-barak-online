<?php
include_once 'connect.php';

$id_penjual = $_GET['id_penjual'];
$id_menu = $_GET['id_menu'];
$query = $db->query(
    "SELECT * FROM `menu` JOIN penjual 
    WHERE menu.id_penjual = penjual.id_penjual AND menu.id_penjual='$id_penjual' AND id_menu <> $id_menu 
    ORDER BY RAND() LIMIT 4;"
);

$data = array();

$i = 0;
while ($row = $query->fetch_assoc()) {
    $data[$i]['id_menu'] = $row['id_menu'];
    $data[$i]['nama_menu'] = $row['nama_menu'];
    $data[$i]['harga'] = $row['harga'];
    $data[$i]['menu_image'] = base64_encode($row['menu_image']);
    $data[$i]['id_penjual'] = $row['id_penjual'];
    $data[$i]['nama'] = $row['nama'];
    $data[$i]['qty'] = "null";
    $i++;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
// echo 'test';
