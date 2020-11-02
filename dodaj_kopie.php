<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "Udalo sie polaczyc z serwerem";  
$id_ksiazka = $_POST['id_ksiazka'];
$ilosc = $_POST['ilosc'];

$dodaj_ksiazke_query = "SELECT projekt.dodaj_kopie($id_ksiazka, $ilosc)";
$result = pg_query($dodaj_ksiazke_query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "\ndodano kopie";
header("location: ksiazki.php");

?>

