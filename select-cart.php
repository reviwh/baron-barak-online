<?php
include_once "connect.php";

$id_pelanggan = $_GET['id_pelanggan'];

$query = $db->query("SELECT * FROM keranjang JOIN menu WHERE keranjang.id_menu=menu.id_menu AND id_pelanggan = '$id_pelanggan'");

$data = array();

$i = 0;
if ($query->num_rows>0) {
    while ($row = $query->fetch_assoc()) {
        $data[$i]['id_keranjang'] = $row['id_keranjang'];
        $data[$i]['id_menu'] = $row['id_menu'];
        $data[$i]['qty'] = $row['qty'];
        $data[$i]['harga'] = $row['harga'];
        $data[$i]['nama_menu'] = $row['nama_menu'];
        $data[$i]['image'] = base64_encode($row['menu_image']);
        $data[$i]['id_pelanggan'] = $row['id_pelanggan'];
        $data[$i]['id_penjual'] = $row['id_penjual'];
        $i++;
    }
} else {
    $data = null;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
