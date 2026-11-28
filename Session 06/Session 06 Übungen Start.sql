-- Session 06: Infokarten auswerten
CREATE DATABASE IF NOT EXISTS eventstar_uebung_06 CHARACTER SET utf8mb4;
USE eventstar_uebung_06;

DROP TABLE IF EXISTS infokarten;
CREATE TABLE infokarten (
    karten_nr INT PRIMARY KEY,
    bereich VARCHAR(25) NOT NULL,
    exemplare INT NOT NULL,
    notiz VARCHAR(40)
);
INSERT INTO infokarten VALUES
    (11, 'Programm', 30, NULL), (12, 'Anreise', 15, 'Bus'),
    (13, 'Programm', 20, 'Foyer'), (14, 'Info', 5, NULL);
