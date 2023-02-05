<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$userid = $_POST['userid'];
$hsname = $_POST['hsname'];
$hsdesc = $_POST['hsdesc'];
$hsprice = $_POST['hsprice'];
$hsqty = $_POST['hsqty'];
$hsstate = $_POST['hsstate'];
$hslocality = $_POST['hslocality'];
$hslat = $_POST['lat'];
$hslong = $_POST['long'];
$image=$_POST['image'];

$sqlinsert = "INSERT INTO tbl_products
(userid,hsname,hsdesc,hsprice,hsqty,hsstate,hslocality,hslat,hslong)
VALUES('$userid','$hsname','$hsdesc','$hsprice','$hsqty','$hsstate','$hslocality','$lat', '$long')";
try{
if ($conn->query($sqlinsert) === TRUE) {
	$decoded_string = base64_decode($image);
    $filename = mysqli_insert_id($conn);
    $path = '../assets/productimages/'.$filename.'.png';
    file_put_contents($path, $decoded_string);
	
    $response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
}
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