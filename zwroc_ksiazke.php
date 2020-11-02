<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "<p>Udalo sie polaczyc z serwerem</p>";

$id_uzytkownika = $_POST['id_uzytkownika'];
$id_kopii = $_POST['id_kopii'];
$data_zwrotu = $_POST['data_zwrotu'];
$doplata = $_POST['doplata'];
$uwagi = $_POST['uwagi'];


$query = "SELECT projekt.zwroc_ksiazke($id_uzytkownika, $id_kopii, '$data_zwrotu', $doplata, '$uwagi')";
$result = pg_query($query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "Zwrócono książkę";
header("location: zwroc.php");
?>
