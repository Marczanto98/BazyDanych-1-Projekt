<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "<p>Udalo sie polaczyc z serwerem</p>"; 

$id_kopia = $_POST['id_kopia'];
$id_uzytkownik = $_POST['id_uzytkownik'];
$data_wypozyczenia = $_POST['data_wypozyczenia'];
$data_oddania_planowo = $_POST['data_oddania_planowo'];

$query1 = "SELECT projekt.czy_mozna_zamienic_rezerwacje_na_wypozyczenie($id_kopia)";
$result1 = pg_query($query1) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());

$czy_mozna;
while ($line = pg_fetch_array($result1, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        $czy_mozna = $col_value;
    }
    echo "\t</tr>\n";
}


if($czy_mozna  == 't'){
//jesli mozna to wypozyczamy
$dodaj_wypozyczenie_query = "SELECT projekt.zamien_rezerwacje_na_wypozyczenie($id_kopia, $id_uzytkownik, '$data_wypozyczenia', '$data_oddania_planowo' )";
$result = pg_query($dodaj_wypozyczenie_query) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
echo "Dodano wypozyczenie";
header("location: rezerwuj.php");
}
else{
echo "Nie można wypożyczyć książki o ID_KOPIA = ".$id_kopia;
}


?>
