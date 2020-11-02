--walidacja wprowadzania adresu e-mail
CREATE OR REPLACE FUNCTION projekt.walidacja_mail()
RETURNS TRIGGER AS 
$$
BEGIN
IF  NEW.mail NOT LIKE '%_@__%.__%'
THEN RAISE EXCEPTION 'Niepoprawny adres e-mail.';
END IF;
RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER walidator_email
BEFORE INSERT OR UPDATE ON projekt.uzytkownik
FOR EACH ROW EXECUTE PROCEDURE projekt.walidacja_mail(); 

--/////////////////////
--walidacja danych uzytkownika
CREATE OR REPLACE FUNCTION projekt.walidacja_uzytkownik()
RETURNS TRIGGER AS 
$$
BEGIN
IF length(NEW.imie) < 2
THEN RAISE EXCEPTION 'Zbyt krótkie imię.';
ELSIF length(NEW.nazwisko) < 2
THEN RAISE EXCEPTION 'Zbyt krótkie nazwisko';
ELSIF NEW.data_urodzenia >= NOW()
THEN RAISE EXCEPTION 'Niepoprawna data urodzenia';
END IF;
RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER walidator_uzytkownika
BEFORE INSERT OR UPDATE ON projekt.uzytkownik
FOR EACH ROW EXECUTE PROCEDURE projekt.walidacja_uzytkownik();


--//////////////////////////////////////
--walidacja danych ksiazki
CREATE OR REPLACE FUNCTION projekt.walidacja_ksiazke()
RETURNS TRIGGER AS 
$$
BEGIN
IF length(NEW.tytul) < 2
THEN RAISE EXCEPTION 'Tytuł zbyt krótki.';
ELSIF NEW.liczba_stron <= 0
THEN RAISE EXCEPTION 'Książka musi mieć przynajmniej jedną stronę.';
ELSIF NEW.wydanie <= 0
THEN RAISE EXCEPTION 'Numer wydania musi być wiekszy od zera.';
END IF;
RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER walidator_ksiazki
BEFORE INSERT OR UPDATE ON projekt.ksiazka
FOR EACH ROW EXECUTE PROCEDURE projekt.walidacja_ksiazke(); 

--/////////////////////////
--walidacja danych wypozyczenia
CREATE OR REPLACE FUNCTION projekt.walidacja_wypozyczenie()
RETURNS TRIGGER AS 
$$
BEGIN
IF NEW.data_wypozyczenia > NOW()
THEN RAISE EXCEPTION 'Nie można wypożyczyć w przyszłość.';
ELSIF NEW.plan_data_oddania < NEW.data_wypozyczenia
THEN RAISE EXCEPTION 'Nie można oddać przed wypożyczeniem.';
ELSIF NEW.data_oddania < NEW.data_wypozyczenia
THEN RAISE EXCEPTION 'Nie można oddać przed wypożyczeniem.';
ELSIF NEW.doplata < 0
THEN RAISE EXCEPTION 'Opłata nie może być mniejsza od 0.';
END IF;
RETURN NEW;
END
$$
LANGUAGE plpgsql;


CREATE TRIGGER walidator_wypozyczenia
BEFORE INSERT OR UPDATE ON projekt.wypozyczenie
FOR EACH ROW EXECUTE PROCEDURE projekt.walidacja_wypozyczenie(); 