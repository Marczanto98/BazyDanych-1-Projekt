<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "<p>Udalo sie polaczyc z serwerem</p>"; 

$id_ksiazka = $_POST['id_ksiazka'];
$id_uzytkownik = $_POST['id_uzytkownik'];
$data_wypozyczenia = $_POST['data_wypozyczenia'];
$data_oddania_planowo = $_POST['data_oddania_planowo'];

$dodaj_ksiazke_query = "SELECT projekt.czy_mozna_wypozyczyc($id_ksiazka)";
$result = pg_query($dodaj_ksiazke_query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());

$czy_mozna;
while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        $czy_mozna = $col_value;
    }
    echo "\t</tr>\n";
}


if($czy_mozna  == 't'){
//jesli mozna to wypozyczamy
$dodaj_wypozyczenie_query = "SELECT projekt.wypozycz($id_ksiazka, $id_uzytkownik, '$data_wypozyczenia', '$data_oddania_planowo' )";
$result = pg_query($dodaj_wypozyczenie_query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "Dodano wypozyczenie";
header("location: wypozycz.php");
}
else{
echo "Nie można wypożyczyć książki o ID = ".$id_ksiazka;
}


?>

