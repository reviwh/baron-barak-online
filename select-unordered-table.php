<?php
include_once 'connect.php';

$id = $_GET['id'];
$query = $db->query("SELECT * FROM meja WHERE id_penjual = '$id' AND status_meja='Tersedia' ORDER BY id_meja;");

$data = array();
$i = 0;
while ($row = $query->fetch_assoc()) {
    $data[$i]['id_meja'] = $row['id_meja'];
    $i++;
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
?>
