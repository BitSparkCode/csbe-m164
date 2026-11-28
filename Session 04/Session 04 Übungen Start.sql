-- Session 04: Materialbestand ändern
CREATE DATABASE IF NOT EXISTS eventstar_uebung_04 CHARACTER SET utf8mb4;
USE eventstar_uebung_04;

DROP TABLE IF EXISTS materialbestand;
CREATE TABLE materialbestand (
    artikel_nr INT PRIMARY KEY,
    artikel VARCHAR(40) NOT NULL,
    anzahl INT NOT NULL
) ENGINE = InnoDB;
INSERT INTO materialbestand VALUES (41, 'Adapter', 6), (42, 'Leihkabel', 9);
