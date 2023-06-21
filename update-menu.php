<?php
include_once "connect.php";

$nama_menu = $_POST['nama_menu'];
$harga = $_POST['harga'];
$menu_image = $_POST['menu_image']==""? null : file_get_contents($_POST['menu_image']);
$id_menu = $_GET['id_menu'];

if($menu_image!=null){
    $query = $db->prepare("UPDATE menu SET nama_menu = ?, harga = ?, menu_image = ? WHERE id_menu=?");
    $query->bind_param("sisi", $nama_menu, $harga, $menu_image, $id_menu);
    $query->execute();
} else {
    $query = $db->prepare("UPDATE menu SET nama_menu = ?, harga = ? WHERE id_menu=?");
    $query->bind_param("sii", $nama_menu, $harga, $id_menu);
    $query->execute();
}

if ($query->errno) $response['success'] = false;
else $response['success'] = true;

$query->close();
$db->close();

header("Content-Type: application/json");
echo json_encode($response);
