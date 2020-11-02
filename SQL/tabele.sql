CREATE SCHEMA projekt;

--///////////////////////////

CREATE SEQUENCE projekt.gatunek_seq;

CREATE TABLE projekt.gatunek (
                ID_GATUNEK INTEGER NOT NULL DEFAULT nextval('projekt.gatunek_seq'),
                nazwa VARCHAR NOT NULL,
                opis VARCHAR NOT NULL,
                CONSTRAINT gatunek_pk PRIMARY KEY (ID_GATUNEK)
);

ALTER SEQUENCE projekt.gatunek_seq OWNED BY projekt.gatunek.ID_GATUNEK;

--///////////////////////////////

CREATE SEQUENCE projekt.wydawca_seq;

CREATE TABLE projekt.wydawca (
                ID_WYDAWCA INTEGER NOT NULL DEFAULT nextval('projekt.wydawca_seq'),
                nazwa VARCHAR NOT NULL,
                CONSTRAINT wydawca_pk_ PRIMARY KEY (ID_WYDAWCA)
);

ALTER SEQUENCE projekt.wydawca_seq OWNED BY projekt.wydawca.ID_WYDAWCA;

--///////////////////////////

CREATE SEQUENCE projekt.ksiazka_seq;

CREATE TABLE projekt.ksiazka (
                ID_KSIAZKA INTEGER NOT NULL DEFAULT nextval('projekt.ksiazka_seq'),
                ID_WYDAWCA INTEGER NOT NULL,
                ID_GATUNEK INTEGER NOT NULL,
                tytul VARCHAR NOT NULL,
                jezyk VARCHAR NOT NULL,
                data_wydania DATE NOT NULL,
                nr_isbn VARCHAR NOT NULL,
                opis VARCHAR,
                liczba_stron INTEGER NOT NULL,
                wydanie INTEGER NOT NULL,
                CONSTRAINT ksiazka_pk PRIMARY KEY (ID_KSIAZKA)
);

ALTER SEQUENCE projekt.ksiazka_seq OWNED BY projekt.ksiazka.ID_KSIAZKA;

--////////////////////////////

CREATE SEQUENCE projekt.autor_seq;

CREATE TABLE projekt.autor (
                ID_AUTOR INTEGER NOT NULL DEFAULT nextval('projekt.autor_seq'),
                imie VARCHAR NOT NULL,
                nazwisko VARCHAR NOT NULL,
                CONSTRAINT autor_pk PRIMARY KEY (ID_AUTOR)
);

ALTER SEQUENCE projekt.autor_seq OWNED BY projekt.autor.ID_AUTOR;

--/////////////////////////dodatkowa tabela nie bylo w diagramie erd

CREATE TABLE projekt.ksiazka_autor (
                ID_KSIAZKA INTEGER NOT NULL,
                ID_AUTOR INTEGER NOT NULL,
                CONSTRAINT ksiazka_autor_pk PRIMARY KEY (ID_KSIAZKA, ID_AUTOR)
);

--//////////////////////////

CREATE SEQUENCE projekt.kopia_seq;

CREATE TABLE projekt.kopia_ksiazki (
                ID_KOPIA INTEGER NOT NULL DEFAULT nextval('projekt.kopia_seq'),
                ID_KSIAZKA INTEGER NOT NULL,
                CONSTRAINT kopia_pk PRIMARY KEY (ID_KOPIA)
);

ALTER SEQUENCE projekt.kopia_seq OWNED BY projekt.kopia_ksiazki.ID_KOPIA;

--//////////////////////////

CREATE SEQUENCE projekt.uwaga_seq;

CREATE TABLE projekt.uwaga (
                ID_UWAGA INTEGER NOT NULL DEFAULT nextval('projekt.uwaga_seq'),
                ID_KOPIA INTEGER NOT NULL,
                opis VARCHAR NOT NULL,
                CONSTRAINT uwaga_pk PRIMARY KEY (ID_UWAGA)
);


ALTER SEQUENCE projekt.uwaga_seq OWNED BY projekt.uwaga.ID_UWAGA;

--////////////////////////

CREATE SEQUENCE projekt.uzytkownik_seq;

CREATE TABLE projekt.uzytkownik (
                ID_UZYTKOWNIK INTEGER NOT NULL DEFAULT nextval('projekt.uzytkownik_seq'),
                imie VARCHAR NOT NULL,
                nazwisko VARCHAR NOT NULL,
                mail VARCHAR NOT NULL,
                data_urodzenia DATE NOT NULL,
                CONSTRAINT uzytkownik_pk PRIMARY KEY (ID_UZYTKOWNIK)
);

ALTER SEQUENCE projekt.uzytkownik_seq OWNED BY projekt.uzytkownik.ID_UZYTKOWNIK;

--/////////////////////////

CREATE TABLE projekt.rezerwacja (
                ID_KOPIA INTEGER NOT NULL,
                ID_UZYTKOWNIK INTEGER NOT NULL,
                data_rezerwacji DATE NOT NULL,
                CONSTRAINT rezerwacja_pk PRIMARY KEY (ID_KOPIA, ID_UZYTKOWNIK)
);

--///////////////////////

CREATE SEQUENCE projekt.adres_seq;

CREATE TABLE projekt.adres (
                ID_ADRES INTEGER NOT NULL DEFAULT nextval('projekt.adres_seq'),
                ID_UZYTKOWNIK INTEGER NOT NULL,
                miasto VARCHAR,
                ulica VARCHAR,
                nr_domu VARCHAR,
                kod_pocztowy VARCHAR,
                CONSTRAINT adres_pk PRIMARY KEY (ID_ADRES)
);

ALTER SEQUENCE projekt.adres_seq OWNED BY projekt.adres.ID_ADRES;

--////////////////////////

CREATE TABLE projekt.wypozyczenie (
                ID_KOPIA INTEGER NOT NULL,
                ID_UZYTKOWNIK INTEGER NOT NULL,
                data_wypozyczenia DATE NOT NULL,
                plan_data_oddania DATE NOT NULL,
                data_oddania DATE,
                doplata NUMERIC,
                CONSTRAINT wypozyczenie_pk PRIMARY KEY (ID_KOPIA, ID_UZYTKOWNIK)
);

--////////////////////////

ALTER TABLE projekt.ksiazka ADD CONSTRAINT wydawca_ksiazka_fk
FOREIGN KEY (ID_WYDAWCA)
REFERENCES projekt.wydawca (ID_WYDAWCA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.kopia_ksiazki ADD CONSTRAINT ksiazka_kopia_fk
FOREIGN KEY (ID_KSIAZKA)
REFERENCES projekt.ksiazka (ID_KSIAZKA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.ksiazka_autor ADD CONSTRAINT ksiazka_ksiazka_autor_fk
FOREIGN KEY (ID_KSIAZKA)
REFERENCES projekt.ksiazka (ID_KSIAZKA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.ksiazka_autor ADD CONSTRAINT autor_ksiazka_autor_fk
FOREIGN KEY (ID_AUTOR)
REFERENCES projekt.autor (ID_AUTOR)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.wypozyczenie ADD CONSTRAINT kopia_wypozycznie_fk
FOREIGN KEY (ID_KOPIA)
REFERENCES projekt.kopia_ksiazki (ID_KOPIA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.rezerwacja ADD CONSTRAINT kopia_rezerwacja_fk
FOREIGN KEY (ID_KOPIA)
REFERENCES projekt.kopia_ksiazki (ID_KOPIA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.uwaga ADD CONSTRAINT kopia_uwaga_fk
FOREIGN KEY (ID_KOPIA)
REFERENCES projekt.kopia_ksiazki (ID_KOPIA)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.wypozyczenie ADD CONSTRAINT uzytkownik_wypozycznie_fk
FOREIGN KEY (ID_UZYTKOWNIK)
REFERENCES projekt.uzytkownik (ID_UZYTKOWNIK)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.adres ADD CONSTRAINT uzytkownik_adres_fk
FOREIGN KEY (ID_UZYTKOWNIK)
REFERENCES projekt.uzytkownik (ID_UZYTKOWNIK)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.rezerwacja ADD CONSTRAINT uzytkownik_rezerwacja_fk
FOREIGN KEY (ID_UZYTKOWNIK)
REFERENCES projekt.uzytkownik (ID_UZYTKOWNIK)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;