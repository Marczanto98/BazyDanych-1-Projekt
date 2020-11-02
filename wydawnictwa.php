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
<h1 align="center">Wydawnictwa</h1>
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
<h3>Dodaj nowe wydawnictwo</h3>
	<form action="dodaj_wydawnictwo.php"method="post">
	Nazwa wydawnictwa: 
        <input type="text" name="nazwa_wydawnictwa" placeholder="..."/><br/><br/>
	<p></p><input type="submit" value="Dodaj"/>	
	</form>
<h3>Wydawnictwa w bazie:</h3>


<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
$query = 'SELECT * FROM projekt.wydawca';
$result = pg_query($query) or die('Nie udalo sie odczytac polecenia ' . pg_last_error());

echo "<table>\n";
echo "<tr><td>ID_WYDAWCA</td><td>Nazwa wydawnictwa</td></tr>";
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
</html>
