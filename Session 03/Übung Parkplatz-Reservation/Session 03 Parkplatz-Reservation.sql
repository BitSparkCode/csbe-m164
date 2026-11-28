-- Parkplatz-Reservationssystem: Referentielle Integrität (MySQL 8.4)
-- Schritt für Schritt ausführen (Ctrl+Enter auf der jeweiligen Anweisung).
-- Anweisungen mit «Erwartet: Fehler» scheitern absichtlich.

DROP DATABASE IF EXISTS parkplatz_reservation;
CREATE DATABASE parkplatz_reservation CHARACTER SET utf8mb4;
USE parkplatz_reservation;

-- 1. Elterntabellen: Personen und Parkplätze
-- PK = UNIQUE + NOT NULL
CREATE TABLE personen (
    id   INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE parkplaetze (
    id       INT PRIMARY KEY,
    standort VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

INSERT INTO personen (id, name) VALUES (1, 'Maier'), (2, 'Huber');
INSERT INTO parkplaetze (id, standort) VALUES (1, 'Ibis 1'), (2, 'Strasse 1');

SELECT * FROM personen;
SELECT * FROM parkplaetze;

-- 2. Primärschlüssel testen
-- Erwartet: Fehler, Person 1 gibt es schon
INSERT INTO personen (id, name) VALUES (1, 'Muster');
-- Erwartet: Fehler, ID darf nicht NULL sein
INSERT INTO personen (id, name) VALUES (NULL, 'Muster');

-- 3. Reservationen: Kindtabelle mit zwei Fremdschlüsseln
-- FK: Wert muss als PK in der Elterntabelle existieren oder NULL sein
CREATE TABLE reservationen (
    id           INT PRIMARY KEY,
    datum        DATE NOT NULL,
    person_id    INT NULL,
    parkplatz_id INT NULL,
    CONSTRAINT fk_reservation_person    FOREIGN KEY (person_id)    REFERENCES personen (id),
    CONSTRAINT fk_reservation_parkplatz FOREIGN KEY (parkplatz_id) REFERENCES parkplaetze (id)
) ENGINE = InnoDB;

INSERT INTO reservationen (id, datum, person_id, parkplatz_id)
VALUES (1, '2026-11-28', 1, 1),
       (2, '2026-11-28', 2, 2);

-- Wer hat welchen Parkplatz?
SELECT r.id, r.datum, p.name, pp.standort
FROM reservationen r
JOIN personen p     ON p.id  = r.person_id
JOIN parkplaetze pp ON pp.id = r.parkplatz_id;

-- 4. Reservation auf einen Parkplatz, den es nicht gibt
-- Erwartet: Fehler, Parkplatz 3 existiert nicht
INSERT INTO reservationen (id, datum, person_id, parkplatz_id)
VALUES (3, '2026-11-29', 1, 3);

-- 5. FK darf NULL sein
-- Funktioniert: Reservation ist erfasst, Parkplatz wird später zugeteilt
INSERT INTO reservationen (id, datum, person_id, parkplatz_id)
VALUES (3, '2026-11-29', 1, NULL);
SELECT * FROM reservationen;

-- 6. Person oder Parkplatz entfernen, der noch reserviert ist
-- Erwartet: Fehler, Huber hat noch Reservation 2
DELETE FROM personen WHERE id = 2;
-- Erwartet: Fehler, Parkplatz 2 ist noch reserviert und kann nicht umnummeriert werden
UPDATE parkplaetze SET id = 20 WHERE id = 2;

-- 7. Richtige Reihenfolge: zuerst Reservation, dann Person
DELETE FROM reservationen WHERE person_id = 2;
DELETE FROM personen WHERE id = 2;
SELECT * FROM personen;

-- 8. Regeln anzeigen
SHOW CREATE TABLE reservationen;
SELECT constraint_name, table_name, column_name,
       referenced_table_name, referenced_column_name
FROM information_schema.key_column_usage
WHERE table_schema = 'parkplatz_reservation'
  AND referenced_table_name IS NOT NULL;

-- Bonus: Parkplatz aufheben, Reservationen bleiben ohne Parkplatz bestehen
ALTER TABLE reservationen DROP FOREIGN KEY fk_reservation_parkplatz;
ALTER TABLE reservationen
    ADD CONSTRAINT fk_reservation_parkplatz
    FOREIGN KEY (parkplatz_id) REFERENCES parkplaetze (id)
    ON DELETE SET NULL;
DELETE FROM parkplaetze WHERE id = 1;
SELECT * FROM reservationen;   -- Reservation 1 hat jetzt parkplatz_id NULL
