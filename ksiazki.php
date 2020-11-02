<!DOCTYPE HTML>
<html lang="pl-PL">

<html>
<head>
   	<title>Biblioteka</title>
	<link href="https://fonts.googleapis.com/css?family=Lato&display=swap" rel="stylesheet">
	<meta http-equiv="content-type: text/html; charset=utf-8">
   	<link rel="StyleSheet" href="style.css" type="text/css">
	<title>Projekt Bazy Danych</title>
	
</head>
<body>
<header>
<h1 align="center">Książki</h1>
</header>
<div style="text-align: center">
	<div class="btn-group">
	<button type="button" class="button" onclick="window.location.href='ksiazki.php'">Książki</button>
	<button type="button" class="button" onclick="window.location.href='autorzy.php'">Autorzy</button>
	<button type="button" class="button" onclick="window.location.href='wypozycz.php'">Wypożycz</button>
	<button type="button" class="button" onclick="window.location.href='uzytkownicy.php'">Użytkownicy</button>
	<button type="button" class="button" onclick="window.location.href='rezerwuj.php'">Rezerwuj</button>
	<button type="button" class="button" onclick="window.location.href='zwroc.php'">Zwróć</button>
	<button type="button" class="button" onclick="window.location.href='widoki.php'">Widoki</button>
	<button type="button" class="button" onclick="window.location.href='wydawnictwa.php'">Wydawnictwa</button>
	<button type="button" class="button" onclick="window.location.href='statystyki.php'">Statystyki</button>
	</div>
</div>


      <form action="dodaj_ksiazke.php" method="post">
        <h3>Dodaj książkę</h3>
        <input type="number" name="id_wydawca" placeholder="nr_id wydawcy"/><br/><br/>
        <input type="number" name="id_gatunek" placeholder="nr_id gatunku"/><br/><br/>
        <input type="text" name="nazwa" placeholder="Nazwa książki"/><br/><br/>
        <input type="text" name="jezyk" placeholder="Język"/><br/><br/>
        <input type="text" name="nr_isbn" placeholder="Numer ISBN"/><br/><br/>
	<p>Data wydania:<p>
        <input type="date" name="data_wyd" placeholder="Data wydania"/><br/><br/>
        <input type="text" name="opis" placeholder="Opis"/><br/><br/>
        <input type="number" name="liczba_stron" placeholder="Liczba stron"/><br/><br/>
        <input type="number" name="wydanie" placeholder="Nr. Wydania"/><br/><br/>
	<!--<input type="text" name="autor1_imie" placeholder="autor1 imie"/><input type="text" name="autor1_nazwisko" placeholder="autor1 nazwisko"/><br/><br/>
         <input type="text" name="autor2_imie" placeholder="autor2 imie"/><input type="text" name="autor2_nazwisko" placeholder="autor2 nazwisko"/><br/><br/> -->
	<p></p><input type="submit" value="Dodaj"/>
  </form>

      <form action="dodaj_kopie.php" method="post">
        <h3>Dodaj kopię książki</h3>
      	<form action="dodaj_kopie.php" method="post">
	<input type="number" name="id_ksiazka" placeholder="nr_id ksiazki"/><br/><br/>
        <input type="number" name="ilosc" placeholder="ilość kopii"/><br/><br/>
	<p></p><input type="submit" value="Dodaj"/>

      </form>
<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
$query = 'SELECT ID_KSIAZKA, tytul FROM projekt.ksiazka';
$result = pg_query($query) or die('Nie udalo sie odczytac polecenia ' . pg_last_error());

echo "<table>\n";
echo "<tr><td>ID_KSIAZKA</td><td>Tytuł</td></tr>";
while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        echo "\t\t<td>$col_value</td>\n";
    }
    echo "\t</tr>\n";
}
echo "</table></center>\n";

?>




</body>
