<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "Udalo sie polaczyc z serwerem";
$imie = $_POST['imie'];
$nazwisko = $_POST['nazwisko'];
$data_urodzenia = $_POST['data_urodzenia'];
$email = $_POST['email'];
$miasto = $_POST['miasto'];
$ulica = $_POST['ulica'];
$nr_domu = $_POST['nr_domu'];
$kod = $_POST['kod'];

$query = "SELECT projekt.dodaj_uzytkownika_z_adresem('$imie','$nazwisko','$email', '$data_urodzenia', '$miasto', '$ulica', $nr_domu, '$kod')";
$result = pg_query($query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "\ndodano uzytkownika";

header("location: uzytkownicy.php");

?>

