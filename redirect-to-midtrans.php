<?php
include_once 'connect.php';

$id_pelanggan = $_GET['id'];
$id_meja = $_GET['id_meja'];

$query = $db->query("SELECT id_reservasi, id_menu, qty FROM reservasimakanan 
    WHERE id_pelanggan='$id_pelanggan' AND id_meja='$id_meja' AND status='Dibayar'");
if($query->num_rows>0){
    $total = 0;
    while ($menu = $query->fetch_assoc()) {
        $get_harga = $db->query("SELECT harga FROM menu WHERE id_menu=$menu[id_menu]");
        $total += intval($get_harga->fetch_object()->harga) * intval($menu['qty']);
        $id_reservasi = $menu['id_reservasi'];
    }
    header("Location: ./midtrans/examples/snap/checkout-process-simple-version.php?id=$id_reservasi&total=$total");
} else {
    echo $db->error;
}

