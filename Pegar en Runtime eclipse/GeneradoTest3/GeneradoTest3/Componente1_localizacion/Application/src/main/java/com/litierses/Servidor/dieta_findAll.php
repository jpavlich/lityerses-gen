<?php

/*
 * Following code will list all the products
 */

// array for JSON response
$response = array();

// include db connect class

require_once('db_connect.php');
//http://lityersesbd.comli.com/connect/get_all_dieta.php



// connecting to db
$db = new DB_CONNECT();

// get all products from products table
$result = mysql_query("SELECT * FROM dieta") or die(mysql_error());

// check for empty result
if (mysql_num_rows($result) > 0) {
    // looping through all results
    // products node
    $response["dieta"] = array();

    while ($row = mysql_fetch_array($result)) {
        // temp user array
        $product = array();
        $product["id"] = $row["id"];
        $product["desayuno"] = $row["desayuno"];
		$product["almuerzo"] = $row["almuerzo"];
		$product["cena"] = $row["cena"];
		$product["merienda"] = $row["merienda"];
		$product["nombre"] = $row["nombre"];

        // push single product into final response array
        array_push($response["dieta"], $product);
    }
    // success
    $response["success"] = 1;

    // echoing JSON response
    echo json_encode($response);
} else {
    // no products found
    $response["success"] = 0;
    $response["message"] = "No products found";

    // echo no users JSON
    echo json_encode($response);
}
?>