<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "Udalo sie polaczyc z serwerem"; 
$imie_autora = $_POST['imie_autora'];
$nazwisko_autora = $_POST['nazwisko_autora'];

$dodaj_ksiazke_query = "INSERT INTO projekt.autor (imie, nazwisko) VALUES ('$imie_autora', '$nazwisko_autora')";
$result = pg_query($dodaj_ksiazke_query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "\ndodano nowego autora";

header("location: autorzy.php");
?>
