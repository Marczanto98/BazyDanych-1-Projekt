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
<h1 align="center">Zwrot wypożyczonych książek</h1>
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
<h3>Zwrot</h3>
      <form action="zwroc_ksiazke.php" method="post">
	<input type="number" name="id_uzytkownika" placeholder="nr_id uzytkownika"/><br/><br/>
       	<input type="number" name="id_kopii" placeholder="nr_id kopii"/><br/><br/>
	<p>Data zwrotu</p>
        <input type="date" name="data_zwrotu" placeholder="Data zwrotu"/><br/><br/>
       	<input type="number" name="doplata" placeholder="doplata"/><br/><br/>
        <input type="text" name="uwagi" placeholder="uwagi"/><br/><br/>
	<p></p><input type="submit" value="Zwróć"/>
	</form>
</body>
