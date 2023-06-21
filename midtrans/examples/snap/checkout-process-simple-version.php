<?php
// This is just for very basic implementation reference, in production, you should validate the incoming requests and implement your backend more securely.
// Please refer to this docs for snap popup:
// https://docs.midtrans.com/en/snap/integration-guide?id=integration-steps-overview

namespace Midtrans;

require_once dirname(__FILE__) . '/../../../connect.php';
require_once dirname(__FILE__) . '/../../Midtrans.php';
// Set Your server key
// can find in Merchant Portal -> Settings -> Access keys
Config::$serverKey = 'SB-Mid-server-VFZCN6SiCpkub0jhK0Ua3c-l';
Config::$clientKey = 'SB-Mid-client-V5SnSZpfdk1BozGc';
// get id
$id = $_GET['id'];
// non-relevant function only used for demo/example purpose
printExampleWarningMessage();

// Uncomment for production environment
// Config::$isProduction = true;
Config::$isSanitized = Config::$is3ds = true;

// Required
$transaction_details = array(
    'order_id' => 'O-' . rand(),
    'gross_amount' => $_GET['total'], // no decimal allowed for creditcard
);
// Optional
$item_details = array();

$query = $db->query("SELECT menu.id_menu AS id, nama_menu, harga, qty 
    FROM reservasimakanan JOIN menu  
    WHERE id_reservasi='$id' AND reservasimakanan.id_menu=menu.id_menu");
$i = 0;
while ($item = $query->fetch_assoc()) {
    $item_details[$i] = array(
        'id' => $item['id'],
        'price' => $item['harga'],
        'quantity' => $item['qty'],
        'name' => $item['nama_menu']
    );
    $i++;
}
// Optional
// get id_pelanggan
$id_pelanggan = $db->query("SELECT id_pelanggan FROM reservasimakanan WHERE id_reservasi='$id' LIMIT 1");
$id_pelanggan = $id_pelanggan->fetch_object()->id_pelanggan;
$query = $db->query("SELECT * FROM pelanggan WHERE id_pelanggan='$id_pelanggan'");
$data = $query->fetch_assoc();
$customer_details = array(
    'first_name'    => $data['nama'],
    'last_name'     => "",
    'email'         => $data['email'],
    'phone'         => $data['telepon'],
);
// Fill transaction details
$transaction = array(
    'transaction_details' => $transaction_details,
    'customer_details' => $customer_details,
    'item_details' => $item_details,
);

$snap_token = '';
try {
    $snap_token = Snap::getSnapToken($transaction);
} catch (\Exception $e) {
    echo $e->getMessage();
}
echo "snapToken = " . $snap_token;

function printExampleWarningMessage()
{
    if (strpos(Config::$serverKey, 'your ') != false) {
        echo "<code>";
        echo "<h4>Please set your server key from sandbox</h4>";
        echo "In file: " . __FILE__;
        echo "<br>";
        echo "<br>";
        echo htmlspecialchars('Config::$serverKey = \'<your server key>\';');
        die();
    }
}

?>

<!DOCTYPE html>
<html>

<body>
    <!-- TODO: Remove ".sandbox" from script src URL for production environment. Also input your client key in "data-client-key" -->
    <script src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="<?php echo Config::$clientKey; ?>"></script>
    <script type="text/javascript">
        window.onload = () => {
            snap.pay('<?php echo $snap_token ?>');
        }
    </script>
</body>

</html>