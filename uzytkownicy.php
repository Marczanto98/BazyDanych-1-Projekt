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
<h1 align="center">Użytkownicy</h1>
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


<h3>Dodaj nowego użytkownika</h3>
      <form action="dodaj_uzytkownika.php" method="post">
        <input type="text" name="imie" placeholder="imie"/><br/><br/>
        <input type="text" name="nazwisko" placeholder="nazwisko"/><br/><br/>
	<p>Data urodzenia<p>        
	<input type="date" name="data_urodzenia" placeholder="Data urodzenia"/><br/><br/>
        <input type="text" name="email" placeholder="e_mail"/><br/><br/>
        <input type="text" name="miasto" placeholder="miasto"/><br/><br/>
	<input type="text" name="ulica" placeholder="ulica"/><br/><br/>
	<input type="number" name="nr_domu" placeholder="Numer domu"/><br/><br/>
	<input type="text" name="kod" placeholder="kod"/><br/><br/>
	<p></p><input type="submit" value="Dodaj"/>
  </form>

</body>
