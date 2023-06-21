<?php
include_once 'connect.php';

$id = $_GET['id'];
$pemilik = $_POST['pemilik'];
$no_telp = $_POST['no_telp'];
$alamat = $_POST['alamat'];
$rek_bri = $_POST['rek_bri'];

$query = $db->prepare("UPDATE penjual SET pemilik = ?, no_telp = ?, alamat = ?, rek_bri=? WHERE id_penjual=?");
$query->bind_param("sssss", $pemilik, $no_telp, $alamat, $rek_bri, $id);
$query->execute();

if ($query->errno) $response['success'] = false;
else $response['success'] = true;

$query->close();
$db->close();

header("Content-Type: application/json");
echo json_encode($response);
