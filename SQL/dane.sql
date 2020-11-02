--Przykladowe inserty danych

--uzytkownicy
INSERT INTO projekt.uzytkownik (imie, nazwisko, mail, data_urodzenia) VALUES 
('Marek', 'Nowak', 'marek-now@gmailcom', '1998-07-31'), 
('Grzegorz', 'Brzęczyszczykiewicz','grzegorz-brzeczyszczykiweicz@gmailcom', '1980-06-22'),
('Antoni', 'Niewielki', 'antoni-niewielki@gmailcom','1987-05-03'),
('Paulina', 'Kurczak','paulina-kurczak@gmailcom', '1992-11-19');

--adresy
INSERT INTO projekt.adres (ID_UZYTKOWNIK, miasto, ulica, nr_domu, kod_pocztowy) VALUES 
(1, 'Krakow', 'Raymonta', '249', '32-600'),
(2, 'Kielce', 'Sienkiewicza', '2137', '13-463'),
(3, 'Radom', 'Kielecka', '21', '22-626'),
(4, 'Sosnowiec', 'Radomska', '876', '62-470');

--gatunki
INSERT INTO projekt.gatunek (nazwa, opis) VALUES 
('Epika', 'Epika - rodzaj literacki, w którym przedstawione są zdarzenia zmyślone lub prawdziwe. Opowiada je narrator opisujący postacie bohaterów. Zdarzenia składają się na fabułę utworu. Może ona zawierać jeden (nowela) lub kilka wątków. Wątek to układ wydarzeń związanych z określoną postacią lub zagadnieniem. Moment szczytowego napięcia w akcji poprzedzający jej rozwiązanie i decydujący o rozwoju wydarzeń to punkt kulminacyjny. Utwory epickie najczęściej pisane są prozą.'),
('Liryka', 'Liryka, utwór którego treścią są osobiste uczucia, nastroje i refleksje autora. Utwory liryczne to - najprościej rzecz ujmując - po prostu wiersze. W liryce - osoba, która wypowiada się, nazywana jest podmiotem lirycznym lub określana mianem "ja" lirycznego. To po prostu ten ktoś, kto otwiera przed nami swój świat wewnętrzny i w formie monologu mówi o swoich przeżyciach, wzruszeniach, doznaniach, dzieli się z nami swoją refleksją.'),
('Dramat', 'Dramat - rodzaj literacki obejmujący utwory przeznaczone do wystawienia na scenie.');

--autorzy
INSERT INTO projekt.autor (imie, nazwisko) VALUES
('Andrzej', 'Sapkowski'),
('George', 'Martin'),
('Bolesław', 'Leśmian'),
('Juliusz', 'Słowacki');

--wydawcy
INSERT INTO projekt.wydawca (nazwa) VALUES
('Dragon'),
('Filia'),
('Zysk i S-ka'),
('SuperNowa');

--ksiazki
INSERT INTO projekt.ksiazka (ID_WYDAWCA, ID_GATUNEK, tytul, jezyk, data_wydania, nr_isbn,  opis, liczba_stron, wydanie) VALUES
(4, 1, 'Wiedzmin. Tom 1. Ostatnie Życzenie', 'polski', '2014-05-05', '9788375781878', 'Przygody Wiedzmina Geralta z Rivii', 345, 3),
(4, 1, 'Wiedzmin. Tom 2. Miecz przeznaczenia', 'polski', '2014-05-05', '9777775781878', 'Przygody Wiedzmina Geralta z Rivii', 320, 3),
(3, 1, 'Ogien i krew, czesc 1', 'polski', '2018-04-15', '54328375781878', 'Opowieść o dynastii Targaryenów.', 456, 5),
(2, 2, 'Liryki najpiekniejsze', 'polski', '2012-11-15', '54328375786666', 'Kolekcja najpiękniejszych utworów Bolesława Leśmiana.', 60, 11),
(1, 3, 'Balladyna', 'polski', '2019-01-15', '54111115786666', 'Opowieść o dwóch siostrach, Alinie i Balladynie, o zbrodni i o karze za nią.	', 160, 12);

--autorzy_ksiazek
INSERT INTO projekt.ksiazka_autor VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4);

--kopie_ksiazka
INSERT INTO projekt.kopia_ksiazki  (ID_KSIAZKA) VALUES
(1), (1), (1), (1), (2), (2), (2), (3), (3), (3), (3), (4), (4), (5), (5);

--uwagi
INSERT INTO projekt.uwaga (opis, ID_KOPIA) VALUES 
('Wyrwana strona 67', 1),
('Zaplamiona okładka', 3),
('Plamy na stronach 20-25', 4),
('Książka jest popisana długopisem na stronie 40', 6);

--wypozyczenia
INSERT INTO projekt.wypozyczenie VALUES
(1, 1, '2020-01-01', '2020-02-01', null, 0),
(2, 2, '2020-01-10', '2020-02-10', null, 0),
(4, 2, '2020-01-05', '2020-02-05', null, 0),
(6, 3, '2020-01-03', '2020-02-03', null, 0);

--rezerwacje
INSERT INTO projekt.rezerwacja VALUES 
(7, 4, '2020-02-01');