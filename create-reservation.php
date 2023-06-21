<?php
include_once "connect.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // get data from post method
    $data = json_decode(file_get_contents('php://input'), true);

    // get id_reservasi
    $id_reservasi = $db->query("SELECT SUBSTR(MAX(id_reservasi),-4) AS id FROM `reservasimakanan`");
    $id_reservasi = 'O-' . str_pad(intval($id_reservasi->fetch_object()->id + 1), 4, "0", STR_PAD_LEFT);
    $id_pelanggan = $data['id_pelanggan'];
    $id_meja = $data['id_meja'];
    $total = intval($data['total']);
    $status = "Dibayar";

    for ($i = 0; isset($data[$i]); $i++) {
        $id_menu = intval($data[$i]['id_menu']);
        $qty = intval($data[$i]['qty']);
        $query = $db->prepare("INSERT INTO `reservasimakanan` (`id_reservasi`, `id_pelanggan`, `id_meja`, `id_menu`, `qty`, `status`) 
            VALUES(?,?,?,?,?,?)");
        $query->bind_param("sssiis", $id_reservasi, $id_pelanggan, $id_meja, $id_menu, $qty, $status);
        $query->execute();
        if ($query->errno) {
            $response['success'] = false;
            break;
        } else $response['success'] = true;
        $query->close();
    }

    // Set status_meja to Tidak Tersedia
    $query = $db->query("UPDATE meja SET status_meja='Tidak Tersedia' WHERE id_meja='$id_meja'");
    
    // Get id_penjual
    $query = $db->query("SELECT id_penjual FROM menu WHERE id_menu=$id_menu");
    $id_penjual = $query->fetch_object()->id_penjual;

    // Increase penjual's saldo
    $query = $db->query("UPDATE penjual SET saldo=saldo+$total WHERE id_penjual='$id_penjual'");

    $db->close();

    header("Content-Type: application/json");
    echo json_encode($response);
} else {
    // Return an error response if the request method is not POST
    $response = [
        'success' => false,
        'message' => 'Invalid request method.'
    ];

    echo json_encode($response);
}
