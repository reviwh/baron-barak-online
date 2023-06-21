<?php
include_once 'connect.php';
setlocale(LC_TIME, 'id_ID');

$id = $_GET['id'];

// Validate and sanitize the $id variable if necessary

$query = $db->query(
    "SELECT nama AS nama_pelanggan,  id_meja, tanggal, nama_menu, qty, harga  
    FROM `reservasimakanan` JOIN pelanggan JOIN menu 
    WHERE reservasimakanan.id_menu=menu.id_menu AND reservasimakanan.id_pelanggan=pelanggan.id_pelanggan AND id_meja='$id' AND status!='Selesai'"
);

$data = array();
$data['total'] = 0;

while ($row = $query->fetch_assoc()) {
    $data[] = array(
        'id_menu' => "null",
        'nama_menu' => $row['nama_menu'],
        'nama' => "null",
        'menu_image' =>"null",
        'id_penjual' =>"null",
        'qty' => $row['qty'],
        'harga' => $row['harga']
    );
    $data['total'] += intval($row['harga'])*intval($row['qty']);
    $data['nama_pelanggan'] = $row['nama_pelanggan'];
    $data['id_meja'] = $row['id_meja'];
    $data['tanggal'] = strftime('%A / %e %B %Y', strtotime($row['tanggal']));
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
