<?php
include_once 'connect.php';

$id = $_GET['id'];
$query = $db->query("SELECT * FROM meja WHERE id_penjual = '$id' AND status_meja='Tidak Tersedia' ORDER BY id_meja;");

$data = array();
$i = 0;
while ($row = $query->fetch_assoc()) {
    $data[$i]['id_meja'] = $row['id_meja'];
    $data[$i]['id_penjual'] = $row['id_penjual'];
    $data[$i]['status_meja'] = $row['status_meja'];
    $i++;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
?>
