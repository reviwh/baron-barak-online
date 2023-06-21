<?php
include_once 'connect.php';

$id = $_GET['id'];
$query = $db->query("SELECT * FROM `penjual` WHERE id_penjual='$id'");

while ($row = $query->fetch_assoc()) {
    $data['id'] = $row['id_penjual'];
    $data['nama'] = $row['nama'];
    $data['pemilik'] = $row['pemilik'];
    $data['no_telp'] = $row['no_telp'];
    $data['alamat'] = $row['alamat'];
    $data['rek_bri'] = $row['rek_bri'];
    $data['saldo'] = $row['saldo'];
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
?>
