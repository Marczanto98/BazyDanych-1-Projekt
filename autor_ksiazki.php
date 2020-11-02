<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "Udalo sie polaczyc z serwerem"; 
$id_ksiazka = $_POST['id_ksiazka'];
$id_autor = $_POST['id_autor'];

$dodaj_ksiazke_query = "INSERT INTO projekt.ksiazka_autor VALUES ($id_ksiazka, $id_autor)";
$result = pg_query($dodaj_ksiazke_query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "\ndodano autora do ksiazki";

header("location: autorzy.php");
?>
