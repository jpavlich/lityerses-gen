<?php

$response = array();
require_once('db_connect.php');
$db = new DB_CONNECT();

$id = ($_GET["id"]);
$result = mysql_query("DELETE FROM `dieta` WHERE `dieta`.`id` = '$id'") or die(mysql_error());
?>

--http://lityerses.comuf.com/connect/dieta_Delete.php?id=4