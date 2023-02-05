<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$userid=$_POST['userid'];
$hsid = $_POST['hsid'];
$hsname = $_POST['hsname'];
$hsdesc = $_POST['hsdesc'];
$hsprice = $_POST['hsprice'];
$hsqty = $_POST['hsqty'];
if (isset($_POST['image'])) {
    $encoded_string = $_POST['image'];
}
$sqlupdate = "UPDATE 'tbl_products' SET 'hsname'='$hsname', 'hsdesc' ='$hsdesc',
'hsprice'='$hsprice','hsqty'='$hsqty', WHERE  'hsid' = '$hsid' AND 'userid'='$userid'";

try{
if ($conn->query($sqlupdate) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    if (!empty($encoded_string)) {
        $decoded_string = base64_decode($encoded_string);
        $path = '../assets/productimages/' . $hsid . '.png';
        $is_written = file_put_contents($path, $decoded_string);
    }
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}}
catch (Exception $e){
	$response = array('status' => 'failed', 'data' =>null);
	sendJsonResponse($response);
}
$conn->close();
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>