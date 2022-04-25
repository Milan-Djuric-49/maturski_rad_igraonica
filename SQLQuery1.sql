CREATE DATABASE maturski_rad

USE maturski_rad

CREATE TABLE Korisnik(
id INT PRIMARY KEY IDENTITY(1,1),
ime NVARCHAR(50) NOT NULL,
prezime NVARCHAR(50) NOT NULL,
email NVARCHAR(50) NOT NULL,
password NVARCHAR(50) NOT NULL,
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

CREATE TABLE Radni_Dan(
id INT PRIMARY KEY IDENTITY(1,1),
dan NVARCHAR(50) NOT NULL,
)

INSERT INTO Radni_Dan(dan) VALUES 
('Ponedeljak'),
('Utorak'),
('Sreda'),
('Četvrtak'),
('Petak'),
('Subota'),
('Nedelja');

CREATE TABLE Animator2RadniDan(
id INT PRIMARY KEY IDENTITY(1,1),
animator_id INT FOREIGN KEY REFERENCES Animator(id) NOT NULL,
dan_id INT FOREIGN KEY REFERENCES Radni_Dan(id) NOT NULL,
)

CREATE TABLE Rezervacija(
id INT PRIMARY KEY IDENTITY(1,1),
korisnik_id INT FOREIGN KEY REFERENCES Korisnik(id) NOT NULL,
igraonica_id INT FOREIGN KEY REFERENCES Igraonica(id) NOT NULL,
animator_id INT FOREIGN KEY REFERENCES Animator(id) NOT NULL,
datum DATE NOT NULL,
)