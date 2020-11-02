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

<h1 align="center">Statystyki</h1>
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
<h3>Statystyki</h3>
<?php
$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
$query1 = "SELECT projekt.uzytkownik_z_najwiecej_wypozyczen()";
$result1 = pg_query($query1) or die('Nie udalo sie odczytac polecenia 1' . pg_last_error());
$zmienna1 = pg_fetch_row($result1);
echo "<p>Użytkownik z największą liczbą wypożyczonych książek: ".$zmienna1[0]."</p>";

$query2 = "SELECT projekt.uzytkownik_z_najwiecej_niezwroconych_ksiazek()";
$result2 = pg_query($query2) or die('Nie udalo sie odczytac polecenia 2' . pg_last_error());
$zmienna2 = pg_fetch_row($result2);
echo "<p>Użytkownik z największą liczbą niezwróconych książek: ".$zmienna2[0]."</p>";

$query3 = "SELECT projekt.najczesciej_wybierana_ksiazka()";
$result3 = pg_query($query3) or die('Nie udalo sie odczytac polecenia 3' . pg_last_error());
$zmienna3 = pg_fetch_row($result3);
echo "<p>Najczęściej wybierana książka: ".$zmienna3[0]."</p>";

$query4 = "SELECT projekt.najczesciej_wybierany_autor()";
$result4 = pg_query($query4) or die('Nie udalo sie odczytac polecenia 4' . pg_last_error());
$zmienna4 = pg_fetch_row($result4);
echo "<p>Najczęściej wybierany autor: ".$zmienna4[0]."</p>";


?>

</header>
