<?php
include_once 'connect.php';

$username = isset($_POST['username']) ? $_POST['username'] : "";
$password = isset($_POST['password']) ? $_POST['password'] : "";

$query = $db->query("SELECT * FROM users WHERE username = '$username' AND password = PASSWORD('$password')");

if ($query->num_rows>0) {
    $result = $query->fetch_array();
    $response["username"] = $result["username"];
    $response["kategori"] = $result["kategori"];
    $query2 = $db->query("SELECT * FROM keranjang JOIN menu WHERE keranjang.id_menu=menu.id_menu AND id_pelanggan='$username'");
    if($query2->num_rows>0){
        $result2 = $query2->fetch_assoc();
        $response['empty_cart'] = false;
        $response['selected_barak'] = $result2['id_penjual'];
    } else {
        $response['empty_cart'] = true;
    }
    $response["success"] = true;
} else {
    $response["success"] = false;
}

$query->close();
$db->close();

header("Content-Type: application/json");
echo json_encode($response);
