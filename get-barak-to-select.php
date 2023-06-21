<?php
include_once 'connect.php';

$query = $db->query("SELECT * FROM penjual");

$i = 0;
while ($row = $query->fetch_assoc()) {
    $select_all_meja = $db->query("SELECT COUNT(*) as jumlah_meja FROM meja WHERE id_penjual='$row[id_penjual]'");
    $select_all_meja_tersedia = $db->query("SELECT COUNT(*) as meja_tersedia FROM meja WHERE id_penjual='$row[id_penjual]' AND status_meja='Tersedia'");
    $data[$i]['id_penjual'] = $row['id_penjual'];
    $data[$i]['nama'] = $row['nama'];
    $data[$i]['jumlah_meja'] = $select_all_meja->fetch_object()->jumlah_meja;
    $data[$i]['meja_tersedia'] = $select_all_meja_tersedia->fetch_object()->meja_tersedia;
    $i++;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
?>
