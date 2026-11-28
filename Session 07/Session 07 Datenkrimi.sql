CREATE DATABASE IF NOT EXISTS eventstar_krimi
    CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE eventstar_krimi;

DROP TABLE IF EXISTS aenderungsprotokoll, anmeldungen, anmeldungen_referenz, mitarbeitende;

CREATE TABLE mitarbeitende (
    person_id INT PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    vorgesetzten_id INT NULL,
    FOREIGN KEY (vorgesetzten_id) REFERENCES mitarbeitende (person_id)
);
INSERT INTO mitarbeitende VALUES (1, 'Lea Fluss', NULL);
INSERT INTO mitarbeitende VALUES (2, 'Miro Tal', 1), (3, 'Noa Licht', 1), (4, 'Eli Moos', 2);

CREATE TABLE anmeldungen_referenz (
    anlass_id INT NOT NULL,
    teilnehmenden_id INT NOT NULL,
    betrag DECIMAL(7, 2) NOT NULL CHECK (betrag >= 0),
    PRIMARY KEY (anlass_id, teilnehmenden_id)
);
INSERT INTO anmeldungen_referenz VALUES (101, 201, 45.00), (101, 202, 0.00),
    (102, 203, 50.00), (104, 204, 25.00);

CREATE TABLE anmeldungen LIKE anmeldungen_referenz;
INSERT INTO anmeldungen SELECT * FROM anmeldungen_referenz;
UPDATE anmeldungen SET betrag = 40.00 WHERE anlass_id = 101 AND teilnehmenden_id = 201;
UPDATE anmeldungen SET betrag = 5.00 WHERE anlass_id = 101 AND teilnehmenden_id = 202;

CREATE TABLE aenderungsprotokoll (
    eintrag_id INT AUTO_INCREMENT PRIMARY KEY,
    zeitpunkt DATETIME NOT NULL,
    person_id INT NOT NULL,
    anlass_id INT NOT NULL,
    teilnehmenden_id INT NOT NULL,
    neuer_betrag DECIMAL(7, 2) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES mitarbeitende (person_id),
    FOREIGN KEY (anlass_id, teilnehmenden_id) REFERENCES anmeldungen (anlass_id, teilnehmenden_id)
);
INSERT INTO aenderungsprotokoll (zeitpunkt, person_id, anlass_id, teilnehmenden_id, neuer_betrag) VALUES
    ('2026-12-04 20:58:00', 2, 101, 201, 45.00),
    ('2026-12-04 21:00:00', 4, 101, 201, 45.00),
    ('2026-12-04 21:02:00', 3, 101, 201, 40.00),
    ('2026-12-04 21:04:00', 4, 102, 203, 50.00),
    ('2026-12-04 21:06:00', 3, 101, 202, 5.00),
    ('2026-12-04 21:08:00', 2, 104, 204, 25.00);
