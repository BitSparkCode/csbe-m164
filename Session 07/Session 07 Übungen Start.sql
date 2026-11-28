-- Session 07: Materialstationen verbinden
CREATE DATABASE IF NOT EXISTS eventstar_uebung_07 CHARACTER SET utf8mb4;
USE eventstar_uebung_07;

DROP TABLE IF EXISTS ausleihen, materialstationen;
CREATE TABLE materialstationen (
    station_nr INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL
) ENGINE = InnoDB;
CREATE TABLE ausleihen (
    ausleihe_nr INT PRIMARY KEY,
    station_nr INT NOT NULL,
    stueck INT NOT NULL,
    FOREIGN KEY (station_nr) REFERENCES materialstationen (station_nr)
) ENGINE = InnoDB;
INSERT INTO materialstationen VALUES (1, 'West'), (2, 'Sued'), (3, 'Nord');
INSERT INTO ausleihen VALUES (71, 1, 2), (72, 1, 4), (73, 2, 1);
