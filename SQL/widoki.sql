CREATE VIEW projekt.rezerwacje AS
SELECT ks.ID_KSIAZKA, rezer.ID_KOPIA, rezer.ID_UZYTKOWNIK, ks.tytul, uz.imie, uz.nazwisko, rezer.data_rezerwacji
FROM projekt.rezerwacja rezer 
JOIN projekt.kopia_ksiazki ko USING (ID_KOPIA)
JOIN projekt.ksiazka  ks USING (ID_KSIAZKA)
JOIN projekt.uzytkownik uz USING (ID_UZYTKOWNIK);

CREATE VIEW projekt.wypozyczenia AS
SELECT wypoz.id_kopia, wypoz.id_uzytkownik, ks.tytul, uz.imie, uz.nazwisko, wypoz.data_wypozyczenia, wypoz.plan_data_oddania, wypoz.data_oddania, wypoz.doplata
FROM projekt.wypozyczenie wypoz 
JOIN projekt.kopia_ksiazki ko USING (ID_KOPIA)
JOIN projekt.ksiazka ks USING (ID_KSIAZKA)
JOIN projekt.uzytkownik uz USING (ID_UZYTKOWNIK);

CREATE VIEW projekt.ksiazki AS 
SELECT ks.id_wydawca, wyd.nazwa AS wydawca_nazwa,
ks.ID_GATUNEK, gat.nazwa AS gatunek_nazwa,
aut.imie, aut.nazwisko AS autor_ide, 
ks.tytul, ks.nr_isbn, ks.data_wydania, ks.opis, ks.liczba_stron, wydanie
FROM projekt.ksiazka ks
JOIN projekt.gatunek gat USING (ID_GATUNEK)
JOIN projekt.wydawca wyd USING (ID_WYDAWCA)
JOIN projekt.ksiazka_autor ks_aut USING(ID_KSIAZKA)
JOIN projekt.autor aut USING (ID_AUTOR);

CREATE VIEW projekt.autorzy_ksiazek AS
SELECT aut.ID_AUTOR, aut.imie, aut.nazwisko, ks.ID_KSIAZKA, ks.tytul 
FROM projekt.ksiazka ks
JOIN projekt.ksiazka_autor USING (ID_KSIAZKA)
JOIN projekt.autor aut USING (ID_AUTOR);

CREATE VIEW projekt.uszkodzone AS
SELECT kop.ID_KOPIA, ks.tytul, uw.opis
FROM projekt.ksiazka ks
JOIN projekt.kopia_ksiazki kop USING (ID_KSIAZKA)
JOIN projekt.uwaga uw USING (ID_KOPIA);

CREATE VIEW projekt.uzytkownicy AS
SELECT uz.ID_UZYTKOWNIK, uz.imie, uz.nazwisko, uz.mail, uz.data_urodzenia, adr.miasto, adr.ulica, adr.nr_domu, adr.kod_pocztowy
FROM projekt.uzytkownik uz
JOIN projekt.adres adr USING(ID_UZYTKOWNIK);