CREATE DATABASE maturski_rad

USE maturski_rad

CREATE TABLE Korisnik(
id INT PRIMARY KEY IDENTITY(1,1),
ime NVARCHAR(50) NOT NULL,
prezime NVARCHAR(50) NOT NULL,
email NVARCHAR(50) NOT NULL,
password NVARCHAR(50) NOT NULL,
uloga INT NOT NULL CHECK (uloga = 0 OR uloga = 1),
)

CREATE TABLE Igraonica(
id INT PRIMARY KEY IDENTITY(1,1),
adresa NVARCHAR(100) NOT NULL,
kapacitet INT NOT NULL,
)

CREATE TABLE Animator(
id INT PRIMARY KEY IDENTITY(1,1),
ime NVARCHAR(50) NOT NULL,
prezime NVARCHAR(50) NOT NULL,
)

CREATE TABLE AnimatorRadniDan(
id INT PRIMARY KEY IDENTITY(1,1),
animator_id INT FOREIGN KEY REFERENCES Animator(id) NOT NULL,
dan INT NOT NULL,
)

CREATE TABLE Rezervacija(
id INT PRIMARY KEY IDENTITY(1,1),
korisnik_id INT FOREIGN KEY REFERENCES Korisnik(id) NOT NULL,
igraonica_id INT FOREIGN KEY REFERENCES Igraonica(id) NOT NULL,
animator_id INT FOREIGN KEY REFERENCES Animator(id),
datum DATE NOT NULL,
odobrena INT DEFAULT 0 NOT NULL,
)

/*
Procedure
*/
/* Korisnik */
CREATE PROCEDURE Dodaj_Korisnik @ime NVARCHAR(50), @prezime NVARCHAR(50), @email NVARCHAR(50), @password NVARCHAR(50), @uloga INT
AS
BEGIN
INSERT INTO Korisnik(ime, prezime, email, password, uloga)
VALUES(@ime, @prezime, @email, @password, @uloga)
END

CREATE PROCEDURE Obrisi_Korinsik @id INT
AS
BEGIN
DELETE FROM Korisnik
WHERE id = @id
END

CREATE PROCEDURE Izmeni_Korisnik @id INT, @ime NVARCHAR(50), @prezime NVARCHAR(50), @email NVARCHAR(50), @password NVARCHAR(50), @uloga INT
AS
BEGIN
UPDATE Korisnik
SET ime = @ime, prezime = @prezime, email = @email, password = @password, uloga = @uloga
WHERE id = @id
END

/* Igraonica */
CREATE PROCEDURE Dodaj_Igraonica @adresa NVARCHAR(100), @kapacitet INT
AS
BEGIN
INSERT INTO Igraonica(adresa, kapacitet)
VALUES (@adresa, @kapacitet)
END

CREATE PROCEDURE Obrisi_Igraonica @id INT
AS
BEGIN
DELETE FROM Igraonica
WHERE id = @id
END

CREATE PROCEDURE Izmeni_Igraonica @id INT, @adresa NVARCHAR(100), @kapacitet INT
AS
BEGIN
UPDATE Igraonica
SET adresa = @adresa, kapacitet = @kapacitet
WHERE id = @id
END 

/* Animator */
CREATE PROCEDURE Dodaj_Animator @ime NVARCHAR(50), @prezime NVARCHAR(50)
AS
BEGIN
INSERT INTO Animator(ime, prezime)
VALUES(@ime, @prezime)
END

CREATE PROCEDURE Obrisi_Animator @id INT
AS
BEGIN
DELETE FROM Animator
WHERE id = @id
END

CREATE PROCEDURE Izmeni_Animator @id INT, @ime NVARCHAR(50), @prezime NVARCHAR(50)
AS
BEGIN
UPDATE Animator
SET ime = @ime, prezime = @prezime
WHERE id = @id
END

/* AnimatorRadniDan */
CREATE PROCEDURE Dodaj_AnimatorRadniDan @animator_id INT, @dan INT
AS
BEGIN
INSERT INTO AnimatorRadniDan(animator_id, dan)
VALUES(@animator_id, @dan)
END

CREATE PROCEDURE Obrisi_AnimatorRadniDan @id INT
AS
BEGIN
DELETE FROM AnimatorRadniDan
WHERE id = @id
END

CREATE PROCEDURE Izmeni_AnimatorRadniDan @id INT, @animator_id INT, @dan INT
AS
BEGIN
UPDATE AnimatorRadniDan
SET animator_id = @animator_id, dan = @dan
WHERE id = @id
END

/* Rezervacija */
CREATE PROCEDURE Dodaj_Rezervacija @korisnik_id INT, @igraonica_id INT, @animator_id INT, @datum DATE, @odobrena INT
AS
BEGIN
INSERT INTO Rezervacija(korisnik_id, igraonica_id, animator_id, datum, odobrena)
VALUES(@korisnik_id, @igraonica_id, @animator_id, @datum, @odobrena)
END

CREATE PROCEDURE Obrisi_Rezervacija @id INT
AS
BEGIN
DELETE FROM Rezervacija
WHERE id = @id
END

CREATE PROCEDURE Izmeni_Rezervacija @id INT, @korisnik_id INT, @igraonica_id INT, @animator_id INT, @datum DATE, @odobrena INT
AS
BEGIN
UPDATE Rezervacija
SET korisnik_id = @korisnik_id, igraonica_id = @igraonica_id, animator_id = @animator_id, datum = @datum, odobrena = @odobrena
WHERE id = @id
END

CREATE PROCEDURE Odobri_Rezervacija @id INT, @animator_id INT
AS
BEGIN
UPDATE Rezervacija
SET animator_id = @animator_id, odobrena = 1
WHERE id = @id
END

/*Popunjavanje baze*/

EXEC Dodaj_Korisnik @ime = "Milan", @prezime = "Djuric", @email = "milan@gmail.com", @password = "123", @uloga = 1
EXEC Dodaj_Korisnik "Pera", "Peric", "pera@gmail.com", "123", 0
EXEC Dodaj_Korisnik "Marko", "Jovic", "marko@gmail.com", "123", 0

EXEC Dodaj_Igraonica "Cara Dusana 1", 123
EXEC Dodaj_Igraonica "Pozeska 13", 60

EXEC Dodaj_Animator "Place", "Holder"
EXEC Dodaj_Animator "Mika", "Mikic"
EXEC Dodaj_Animator "Zika", "Zikic"

EXEC Dodaj_AnimatorRadniDan 1, 1
EXEC Dodaj_AnimatorRadniDan 1, 2
EXEC Dodaj_AnimatorRadniDan 1, 3
EXEC Dodaj_AnimatorRadniDan 1, 4
EXEC Dodaj_AnimatorRadniDan 2, 5
EXEC Dodaj_AnimatorRadniDan 2, 6
EXEC Dodaj_AnimatorRadniDan 2, 7

EXEC Dodaj_Rezervacija 3, 1, 1, '2022-05-10', 1
EXEC Dodaj_Rezervacija 3, 1, 1, '2022-05-13', 1
EXEC Dodaj_Rezervacija 3, 1, 1, '2022-05-14', 1

EXEC Dodaj_Rezervacija 3, 1, 1, '2022-05-16', 0
EXEC Dodaj_Rezervacija 3, 1, 1, '2022-05-16', 0
EXEC Dodaj_Rezervacija 3, 1, 1, '2022-05-16', 0
EXEC Dodaj_Rezervacija 3, 1, 1, '2022-05-16', 0

/*Koji animatori rade x dana*/
/*SELECT Animator.id, ime + ' ' + prezime as naziv FROM Animator
JOIN AnimatorRadniDan ON animator_id = Animator.id
WHERE dan = X*/ 