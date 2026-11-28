-- Parkplatz-Reservation: Normalisierung (MySQL 8.4)
-- Vor dem Ausführen in Workbench ein leeres Übungsschema als Standard wählen.

-- Tabellen anlegen
CREATE TABLE personen (
    person_nr INT PRIMARY KEY,
    personenname VARCHAR(50) NOT NULL,
    telefon VARCHAR(20) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE fahrzeuge (
    kennzeichen VARCHAR(12) PRIMARY KEY,
    person_nr INT NOT NULL,
    FOREIGN KEY (person_nr) REFERENCES personen (person_nr)
) ENGINE = InnoDB;

CREATE TABLE standorte (
    standort_nr INT PRIMARY KEY,
    standort VARCHAR(50) NOT NULL,
    adresse VARCHAR(80) NOT NULL,
    tagespreis DECIMAL(6,2) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE parkplaetze (
    parkplatz_nr CHAR(3) PRIMARY KEY,
    standort_nr INT NOT NULL,
    FOREIGN KEY (standort_nr) REFERENCES standorte (standort_nr)
) ENGINE = InnoDB;

CREATE TABLE reservationen (
    reservationsnr INT PRIMARY KEY,
    datum DATE NOT NULL,
    person_nr INT NOT NULL,
    parkplatz_nr CHAR(3) NOT NULL,
    UNIQUE (parkplatz_nr, datum),
    FOREIGN KEY (person_nr) REFERENCES personen (person_nr),
    FOREIGN KEY (parkplatz_nr) REFERENCES parkplaetze (parkplatz_nr)
) ENGINE = InnoDB;

-- Beispieldaten einfügen
INSERT INTO personen (person_nr, personenname, telefon) VALUES
    (1, 'Maier', '031 555 01 01'),
    (2, 'Huber', '031 555 02 02');

INSERT INTO fahrzeuge (kennzeichen, person_nr) VALUES
    ('BE12345', 1),
    ('BE45678', 1),
    ('BE98765', 2);

INSERT INTO standorte (standort_nr, standort, adresse, tagespreis) VALUES
    (10, 'Ibis', 'Ibisweg 1, Bern', 8.50),
    (20, 'Stadtpark', 'Parkstrasse 1, Bern', 11.00);

INSERT INTO parkplaetze (parkplatz_nr, standort_nr) VALUES
    ('A01', 10),
    ('A02', 10),
    ('B01', 20);

INSERT INTO reservationen (reservationsnr, datum, person_nr, parkplatz_nr) VALUES
    (101, '2027-01-14', 1, 'A01'),
    (102, '2027-01-15', 1, 'A02'),
    (103, '2027-01-14', 2, 'B01');

-- Daten mit JOIN kontrollieren
SELECT r.reservationsnr, r.datum, p.personenname, v.kennzeichen,
       pp.parkplatz_nr, s.standort, s.tagespreis
FROM reservationen AS r
JOIN personen AS p ON p.person_nr = r.person_nr
JOIN parkplaetze AS pp ON pp.parkplatz_nr = r.parkplatz_nr
JOIN standorte AS s ON s.standort_nr = pp.standort_nr
LEFT JOIN fahrzeuge AS v ON v.person_nr = p.person_nr
ORDER BY r.reservationsnr, v.kennzeichen;
