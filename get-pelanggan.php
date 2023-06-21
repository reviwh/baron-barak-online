<?php
include_once 'connect.php';

$id = $_GET['id'];
$query = $db->query("SELECT * FROM `pelanggan` WHERE id_pelanggan='$id'");

while ($row = $query->fetch_assoc()) {
    $data['nama'] = $row['nama'];
    $data['jurusan'] = $row['jurusan'];
    $data['prodi'] = $row['prodi'];
    $data['profile_image'] = base64_encode($row['profile_image']);
    $data['telepon'] = $row['telepon'];
    $data['email'] = $row['email'];
}

$db->close();

header("Content-Type: application/json");
echo json_encode($data);
?>
