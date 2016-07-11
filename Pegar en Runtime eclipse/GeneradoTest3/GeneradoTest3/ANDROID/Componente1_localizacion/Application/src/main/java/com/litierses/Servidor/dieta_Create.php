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
$result = mysql_query("INSERT INTO `dieta` (`nombre` ,`desayuno` ,`almuerzo` ,`cena` ,`merienda` ,`id`)VALUES ('$nombre',  '$desayuno',  '$almuerzo',  '$cena',  '$merienda',  '$id')") or die(mysql_error());
?>


--http://www.lityerses.comuf.com/connect/dieta_create.php?nombre=Dieta%20Domingo&desayuno=Calentado&almuerzo=Pasta&cena=Fruta&merienda=galletas&id=10