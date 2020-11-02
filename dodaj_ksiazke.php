<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "Udalo sie polaczyc z serwerem";  
$id_wydawca = $_POST['id_wydawca'];
$id_gatunek = $_POST['id_gatunek'];
$nazwa = $_POST['nazwa'];
$jezyk = $_POST['jezyk'];
$nr_isbn = $_POST['nr_isbn'];
$data_wyd = $_POST['data_wyd'];
$opis = $_POST['opis'];
$liczba_stron = $_POST['liczba_stron'];
$wydanie = $_POST['wydanie'];
$autor1_imie = $_POST['autor1_imie'];
$autor1_nazwisko = $_POST['autor1_nazwisko'];
$autor2_imie = $_POST['autor2_imie'];
$autor2_nazwisko = $_POST['autor2_nazwisko'];

$dodaj_ksiazke_query = "SELECT projekt.dodaj_ksiazke($id_wydawca, $id_gatunek,'$nazwa','$jezyk','$nr_isbn', '$data_wyd', '$opis', $liczba_stron, $wydanie)";
$result = pg_query($dodaj_ksiazke_query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "\ndodano ksiazke";

//$dodaj_autora_query = "INSERT INTO projekt.autor (imie, nazwisko) VALUES ('$autor1_imie', '$autor1_nazwisko')";
//$result2 = pg_query($dodaj_autora_query) or die('Nie udalo sie odczytac polecenia 2' . pg_last_error());
//echo "\ndodano autora"

//$nr_id_ksiazki_query = "SELECT ksiazka.ID_KSIAZKA FROM projekt.ksiazka ORDER BY ID_KSIAZKA DESC LIMIT 1;";
//$result2 = pg_query($nr_id_ksiazki_query) or die('Nie udalo sie odczytac polecenia 3' . pg_last_error());

//echo 'liczba = '.$result2;
header("location: ksiazki.php");

?>

