<?php
include_once "connect.php";

$nama_menu = $_POST['nama_menu'];
$harga = $_POST['harga'];
$menu_image = $_POST['menu_image']!=""?file_get_contents($_POST['menu_image']):base64_decode('iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAWhJREFUaEPtWdsNwjAMPDaBTWASYBJgEmAS2AQ2AZ1EJIjycGS3DWB/u8k97ChOZ/jymH05fjiBqR10B3p3YA9gDWA+EdA7gAOAU27/UgltABwnAh5vu82RKBG4AFh2QoBOLFJYSgQenYAPMJJYncCILrkDI4qd3ModcAeUCngJKQVUf+4OqCVULuAOKAVUf+4OqCVULtCNAxxMOKJyYGqJLgisAFxfqDlv7xoYDEaA4x5nVg7/nKNzweGcoEPQBc7c0rF1MAJB1VAWqRcMqs68OErfxLmDEHgvCW5IQLdo5+xA/sqjA5J+MCeQUzV+jolJpkpM0g+mBGqqhicZCfjgXK0fTAnUgLGUeMKwuaVR6wczArnSkQIt5dGF3ElmRoAAWELWUXt/NSVgDV6ynhOQqDRkzv850NPzevbk++kfHDzWeE/hLVN6Y7TuAR7X5+gW+7GH/6W0lrx1PXegVTHrfHfAWtHW9Z5/4kkxvEWZygAAAABJRU5ErkJggg==');
$id_penjual = $_GET['id_penjual'];

$query = $db->prepare("INSERT INTO menu (nama_menu, harga, menu_image, id_penjual) 
VALUES(?,?,?,?)");
$query->bind_param("siss", $nama_menu, $harga, $menu_image, $id_penjual);
$query->execute();
if ($query->errno) $response['success'] = false;
else $response['success'] = true;
$query->close();
$db->close();

header("Content-Type: application/json");
echo json_encode($response);
