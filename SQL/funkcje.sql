-- Mozliwosc oddania ksiazki oraz dodania ewentualnej uwagi co do jej stanu.
CREATE OR REPLACE FUNCTION projekt.zwroc_ksiazke(UZYTKOWNIK_ID INTEGER, KOPIA_ID INTEGER, data_zwrotu DATE, dodatkowa_oplata DECIMAL, uwaga VARCHAR)
RETURNS INTEGER AS
$$
BEGIN
    IF uwaga IS NOT NULL THEN
        INSERT INTO projekt.uwaga (opis, ID_KOPIA) VALUES (uwaga, KOPIA_ID);
    END IF;
	UPDATE projekt.wypozyczenie  SET data_oddania = data_zwrotu, doplata = dodatkowa_oplata
    WHERE ID_KOPIA = KOPIA_ID AND ID_UZYTKOWNIK = UZYTKOWNIK_ID;
    RETURN 0;
END;
$$
LANGUAGE plpgsql;

-- Funkcja sprawdzająca czy jest dostępna kopia danej książki, którą można zarezerwować
CREATE OR REPLACE FUNCTION projekt.czy_mozna_zarezerwowac(KSIAZKA_ID INTEGER)
RETURNS BOOLEAN AS
$$
DECLARE
    ilosc_wolnych_kopii INTEGER;
BEGIN
    ilosc_wolnych_kopii = (WITH cte AS (    
                   SELECT ID_KOPIA FROM projekt.kopia_ksiazki WHERE ID_KSIAZKA = KSIAZKA_ID
                   EXCEPT 
                   SELECT ID_KOPIA FROM projekt.rezerwacja)
                   SELECT COUNT(*) FROM cte);
    IF ilosc_wolnych_kopii > 0
    THEN RETURN true;
    END IF;
    RETURN false;

END;
$$
LANGUAGE plpgsql;

-- Funkcja pozwalająca na dodanie książki, wraz z jedną kopią
CREATE OR REPLACE FUNCTION projekt.dodaj_ksiazke(WYDAWCA_ID INTEGER, GATUNEK_ID INTEGER, tytul_nowy TEXT, jezyk_nowy TEXT, nr_isbn_nowy TEXT, data_publikacji_nowy DATE, opis_nowy TEXT, liczba_stron_nowy INTEGER, wydanie_nowy INTEGER)
RETURNS BOOLEAN AS
$$
DECLARE
    nowa_ksiazka INTEGER;
BEGIN
    INSERT INTO projekt.ksiazka (ID_WYDAWCA, ID_GATUNEK, tytul, jezyk, nr_isbn, data_wydania, opis, liczba_stron, wydanie) 
    VALUES (WYDAWCA_ID, GATUNEK_ID, tytul_nowy, jezyk_nowy, nr_isbn_nowy, data_publikacji_nowy, opis_nowy, liczba_stron_nowy, wydanie_nowy) RETURNING ID_KSIAZKA INTO nowa_ksiazka;
   
    INSERT INTO projekt.kopia_ksiazki (ID_KSIAZKA) VALUES (nowa_ksiazka);
    RETURN true;
END;
$$
LANGUAGE plpgsql;

-- Funkcja pozwalajaca na rezerwacje ksiazki, zwraca ID_KOPIA zarezerwowanej kopii
CREATE OR REPLACE FUNCTION projekt.rezerwuj_ksiazke(UZYTKOWNIK_ID INTEGER, KSIAZKA_ID INTEGER, data_rezerwacji DATE)
RETURNS INTEGER AS
$$
DECLARE
    id_rez_kopii INTEGER;
BEGIN
    id_rez_kopii = (WITH cte AS (    
                   SELECT ID_KOPIA FROM projekt.kopia_ksiazki WHERE ID_KSIAZKA = KSIAZKA_ID
                   EXCEPT 
                   SELECT ID_KOPIA FROM projekt.rezerwacja)
                   SELECT ID_KOPIA FROM cte LIMIT 1);
    IF id_rez_kopii IS NULL
    THEN RAISE EXCEPTION 'Nie można zarezerwować tej książki.';
    ELSE
        INSERT INTO projekt.rezerwacja VALUES (id_rez_kopii, UZYTKOWNIK_ID, data_rezerwacji);
        RETURN id_rez_kopii;
    END IF;
END;
$$
LANGUAGE plpgsql;

-- Funkcja sprawdzajaca czy mozliwa jest zamiana rezerwacji na wypozyczenie
CREATE OR REPLACE FUNCTION projekt.czy_mozna_zamienic_rezerwacje_na_wypozyczenie(KOPIA_ID INTEGER)
RETURNS BOOLEAN AS
$$
BEGIN
    IF EXISTS (SELECT * FROM projekt.wypozyczenie wyp
            WHERE wyp.ID_KOPIA = KOPIA_ID AND wyp.data_oddania IS NULL)
    THEN RETURN false;
    END IF;
    RETURN true;
END;
$$
LANGUAGE plpgsql;

-- Funkcja zamieniajaca rezerwacje na wypozyczenie
CREATE OR REPLACE FUNCTION projekt.zamien_rezerwacje_na_wypozyczenie(KOPIA_ID INTEGER, UZYTKOWNIK_ID INTEGER, wypozyczono_dnia DATE, zakladany_zwrot DATE)
RETURNS BOOLEAN AS
$$
BEGIN
    IF EXISTS (SELECT * FROM projekt.wypozyczenie wyp
            WHERE wyp.id_kopia = kopia_id AND wyp.data_oddania IS NULL)
    THEN RAISE EXCEPTION 'Nie można zamienic na wypożyczenie';
    END IF;
   
    DELETE FROM projekt.rezerwacja WHERE ID_KOPIA = KOPIA_ID;

    INSERT INTO projekt.wypozyczenie (ID_KOPIA, ID_UZYTKOWNIK, data_wypozyczenia, plan_data_oddania, doplata)
    VALUES (KOPIA_ID, UZYTKOWNIK_ID, wypozyczono_dnia, zakladany_zwrot, 0);

    RETURN TRUE;
END;
$$
LANGUAGE plpgsql;

-- Funkcja sprawdzajaca czy jest mozliwosc wypozyczenia ksiazki
CREATE OR REPLACE FUNCTION projekt.czy_mozna_wypozyczyc(KSIAZKA_ID INTEGER)
RETURNS BOOLEAN AS
$$
BEGIN
IF EXISTS
(WITH nie_oddane
AS (SELECT ID_KOPIA FROM projekt.wypozyczenie WHERE data_oddania IS NULL),
bez_rezerwacji 
AS (SELECT ko.ID_KOPIA FROM projekt.ksiazka k
JOIN projekt.kopia_ksiazki ko USING(ID_KSIAZKA) 
WHERE ID_KSIAZKA = KSIAZKA_ID AND ID_KOPIA NOT IN (SELECT ID_KOPIA FROM projekt.rezerwacja))
SELECT * FROM bez_rezerwacji WHERE ID_KOPIA NOT IN (SELECT * FROM nie_oddane))
THEN RETURN true;
END IF;
RETURN false;
END;
$$
LANGUAGE plpgsql;

-- Funkcja wypożyczająca książkę
CREATE OR REPLACE FUNCTION projekt.wypozycz(KSIAZKA_ID INTEGER, UZYTKOWNIK_ID INTEGER, wypozyczono_dnia DATE, zakladany_zwrot DATE)
RETURNS INTEGER AS
$$
DECLARE
    ID_WYP_KOPI INTEGER;
BEGIN
    ID_WYP_KOPI = (WITH nie_oddane
AS (SELECT ID_KOPIA FROM projekt.wypozyczenie WHERE data_oddania IS NULL),
bez_rezerwacji 
AS (SELECT ko.ID_KOPIA FROM projekt.ksiazka ks
JOIN projekt.kopia_ksiazki ko USING(ID_KSIAZKA) 
WHERE ID_KSIAZKA = KSIAZKA_ID AND ID_KOPIA NOT IN (SELECT ID_KOPIA FROM projekt.rezerwacja))
SELECT * FROM bez_rezerwacji WHERE ID_KOPIA NOT IN (SELECT * FROM nie_oddane) LIMIT 1);
IF ID_WYP_KOPI = NULL
THEN RAISE EXCEPTION 'Nie można wypożyczyć książki';
ELSE 
    INSERT INTO projekt.wypozyczenie  (ID_KOPIA, ID_UZYTKOWNIK, data_wypozyczenia, plan_data_oddania, doplata) 
    VALUES     (ID_WYP_KOPI, UZYTKOWNIK_ID, wypozyczono_dnia, zakladany_zwrot, 0);
END IF;
RETURN ID_WYP_KOPI;
END;
$$
LANGUAGE plpgsql;

--Funkcja zwraca dane uzytkownika z najwieksza liczba wypozyczen
CREATE OR REPLACE FUNCTION projekt.uzytkownik_z_najwiecej_wypozyczen()
RETURNS VARCHAR AS
$$
DECLARE
    wynik RECORD;
BEGIN
    SELECT u.imie, u.nazwisko, COUNT(*) AS ile INTO wynik FROM projekt.uzytkownik u
    JOIN projekt.wypozyczenia w USING (ID_UZYTKOWNIK)
    GROUP BY u.imie, u.nazwisko ORDER BY 3 DESC LIMIT 1;
RETURN wynik.imie || ' ' || wynik.nazwisko || ' (' || wynik.ile || ')';
END;
$$
LANGUAGE plpgsql;


--Funkcja zwraca dane uzytkownika z najwieksza liczba nieoddanych ksiazek 
CREATE OR REPLACE FUNCTION projekt.uzytkownik_z_najwiecej_niezwroconych_ksiazek()
RETURNS VARCHAR AS
$$
DECLARE
    wynik RECORD;
BEGIN
    SELECT u.imie, u.nazwisko, COUNT(*) AS ile INTO wynik FROM projekt.uzytkownik u
    JOIN projekt.wypozyczenia w USING (ID_UZYTKOWNIK)
    WHERE w.data_oddania IS NULL AND w.data_wypozyczenia BETWEEN '1900-01-01' AND '2100-01-01'
    GROUP BY u.imie, u.nazwisko ORDER BY 3 DESC LIMIT 1;
RETURN wynik.imie || ' ' || wynik.nazwisko || ' (' || wynik.ile || ')';
END;
$$
LANGUAGE plpgsql;

--Funkcja zwraca tytul ksiazki ktora byla wypozyczana najczesciej 
CREATE OR REPLACE FUNCTION projekt.najczesciej_wybierana_ksiazka()
RETURNS VARCHAR AS
$$
DECLARE
    wynik RECORD;
BEGIN
    SELECT k.tytul, COUNT(*) AS ilosc INTO wynik FROM 
    projekt.wypozyczenie w 
    JOIN projekt.kopia_ksiazki ko USING (ID_KOPIA) 
    JOIN projekt.ksiazka k USING (ID_KSIAZKA)
    GROUP BY k.tytul
    ORDER BY 2 DESC LIMIT 1;
    RETURN wynik.tytul || ' (' ||  wynik.ilosc || ')';
END;
$$
LANGUAGE plpgsql;

--Funkcja zwraca imie i nazwisko autora ktorego ksiazki byly wybierane najczesciej 
CREATE OR REPLACE FUNCTION projekt.najczesciej_wybierany_autor()
RETURNS VARCHAR AS
$$
DECLARE
    wynik RECORD;
BEGIN
   SELECT a.imie, a.nazwisko, COUNT(*) AS ilosc INTO wynik FROM 
    projekt.wypozyczenie w 
    JOIN projekt.kopia_ksiazki ko USING (ID_KOPIA) 
    JOIN projekt.ksiazka k USING (ID_KSIAZKA)
    JOIN projekt.ksiazka_autor ka USING (ID_KSIAZKA)
    JOIN projekt.autor a USING (ID_AUTOR)
    GROUP BY a.imie, a.nazwisko
    ORDER BY 3 DESC LIMIT 1;
    RETURN wynik.imie || ' ' || wynik.nazwisko || ' (' || wynik.ilosc || ')';
END;
$$
LANGUAGE plpgsql;


--Funkcja pozwala na dodanie użytkownika wraz z 1 adsresem
CREATE OR REPLACE FUNCTION projekt.dodaj_uzytkownika_z_adresem(imie_n TEXT, nazwisko_n TEXT, email_n TEXT, data_ur DATE, miasto_n TEXT, ulica_n TEXT, nr_domu_n INTEGER, kod_n TEXT)
RETURNS BOOLEAN AS
$$
DECLARE
    nowy_uz INTEGER;
BEGIN
    INSERT INTO projekt.uzytkownik (imie, nazwisko, mail, data_urodzenia) 
    VALUES (imie_n, nazwisko_n, email_n, data_ur) RETURNING ID_UZYTKOWNIK INTO nowy_uz ;

    INSERT INTO projekt.adres(ID_UZYTKOWNIK, miasto, ulica, nr_domu, kod_pocztowy) 
    VALUES (nowy_uz, miasto_n, ulica_n, nr_domu_n, kod_n);
    RETURN true;
END;
$$
LANGUAGE plpgsql;


--Funkcja dodaje wybrana liczbe kopii danej książki
CREATE OR REPLACE FUNCTION projekt.dodaj_kopie(KSIAZKA_ID INTEGER, ilosc INTEGER)
RETURNS BOOLEAN AS
$$
BEGIN
    FOR i IN 1..ilosc LOOP
    INSERT INTO projekt.kopia_ksiazki (ID_KSIAZKA) VALUES (KSIAZKA_ID);
    END LOOP;
    RETURN true;
END;
$$
LANGUAGE plpgsql;