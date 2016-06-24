<?php

$response = array();
require_once('db_connect.php');
$db = new DB_CONNECT();

$nombre = ($_GET["nombre"]);
$desayuno = ($_GET["desayuno"]);
$almuerzo = ($_GET["almuerzo"]);
$cena = ($_GET["cena"]);
$merienda = ($_GET["merienda"]);
$id = ($_GET["id"]);
$result = mysql_query("UPDATE `dieta` SET `nombre` = $nombre,`desayuno` = '$desayuno', `almuerzo` = '$almuerzo', `cena` = '$cena', `merienda`= '$merienda' WHERE `id` = '$id'") or die(mysql_error());
?>

//UPDATE  `sql3122679`.`dieta` SET  `merienda` =  'Chocolatina' WHERE  `dieta`.`id` =  '2';
--http://www.lityerses.comuf.com/connect/dieta_create.php?nombre=Dieta%20Domingo&desayuno=Calentado&almuerzo=Pasta&cena=Fruta&merienda=galletas&id=10