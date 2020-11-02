<!DOCTYPE HTML>
<html>
<head>
    <title>Uszkodzone książki</title>
    <meta http-equiv="content-type: text/html; charset=utf-8">
    <link rel="stylesheet" href="style.css">
</head>
<body>
<?php

$con=pg_connect("host=localhost dbname=u7nowakm user=u7nowakm password=7nowakm")
			or die ("Nie mozna polaczyc sie z serwerem\n"); 
echo "Udalo sie polaczyc z serwerem";  
$query = 'SELECT * FROM projekt.uszkodzone';
$result = pg_query($query) or die('Nie udalo sie odczytac polecenia ' . pg_last_error());

echo "<center><p>Uszkodzone książki</p>";
echo "<table>\n";
echo "<tr><td>ID_KOPIA</td><td>Tytuł książki</td><td>Treść uwagi</td></tr>";
while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        echo "\t\t<td>$col_value</td>\n";
    }
    echo "\t</tr>\n";
}
echo "</table></center>\n";
?>
   <body>
      <button onclick="window.location.href = 'widoki.php';">Powrót</button>
   </body>


</body>
