<?php
include_once 'connect.php';

$id = $_GET['id'];

$query = $db->query("UPDATE reservasimakanan SET status='Selesai' WHERE id_meja='$id' AND status!='Selesai'");
$query = $db->query("UPDATE meja SET status_meja='Tersedia' WHERE id_meja='$id'");

if ($query) $response['success'] = true;
else $response['success'] = false;

$db->close();

header("Content-Type: application/json");
echo json_encode($response);
