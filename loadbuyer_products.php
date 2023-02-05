<?php
error_reporting(0);
if(!isset($_GET)){
	$response=array('status'=>'failed', 'data' =>null);
	sendJsonResponse($response);
	die();
}
$userid=$_GET['userid'];
include_once("dbconnect.php");
$sqlloadBuyerProducts = "SELECT * FROM tbl_product INNER JOIN tbl_users ON
tbl_product.userid = tbl_users.user_id ORDER BY tbl_product.hsdate DESC";
$result = $conn->query($sqlloadBuyerProducts);
if ($result->num_rows > 0) {
    $productsarray["products"] = array();
while ($row = $result->fetch_assoc()) {
        $hslist = array();
        $hslist['hsid'] = $row['hsid'];
        $hslist['userid'] = $row['userid'];
		$hslist['hsname'] = $row['hsname'];
        $hslist['hsdesc'] = $row['hsdesc'];
        $hslist['hsprice'] = $row['hsprice'];
        $hslist['hsqty'] = $row['hsqty'];
        $hslist['hsstate'] = $row['hsstate'];
        $hslist['hsloc'] = $row['hsloc'];
        $hslist['hslat'] = $row['hslat'];
        $hslist['hslong'] = $row['hslong'];
        $hslist['hsdate'] = $row['hsdate'];
        array_push($product["product"],$hslist);
    }
    $response = array('status' => 'success', 'data' => $product);
    sendJsonResponse($response);
	}else{
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
