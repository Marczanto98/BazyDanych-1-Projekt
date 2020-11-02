<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "Udalo sie polaczyc z serwerem"; 
$nazwa_wydawnictwa = $_POST['nazwa_wydawnictwa'];


$query = "INSERT INTO projekt.wydawca (nazwa) VALUES('$nazwa_wydawnictwa')";
$result = pg_query($query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "\ndodano nowe wydawnictwo";

header("location: wydawnictwa.php");
?>
