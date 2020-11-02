<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "<p>Udalo sie polaczyc z serwerem</p>"; 

$id_ksiazka = $_POST['id_ksiazka'];
$id_uzytkownik = $_POST['id_uzytkownik'];
$data_rezerwacji = $_POST['data_rezerwacji'];

$query = "SELECT projekt.czy_mozna_zarezerwowac($id_ksiazka)";
$result = pg_query($query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());

$czy_mozna;
while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        $czy_mozna = $col_value;
    }
    echo "\t</tr>\n";
}


if($czy_mozna  == 't'){
//jesli mozna to rezerwuje
$dodaj_wypozyczenie_query = "SELECT projekt.rezerwuj_ksiazke($id_ksiazka, $id_uzytkownik, '$data_rezerwacji')";
$result = pg_query($dodaj_wypozyczenie_query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "Dodano rezerwacje";
header("location: rezerwuj.php");
}
else{
echo "Nie można zarezerwowac książki o ID = ".$id_ksiazka;
}


?>

