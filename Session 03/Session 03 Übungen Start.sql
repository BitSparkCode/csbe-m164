-- Session 03: Lagerkisten und Ausgaben
CREATE DATABASE IF NOT EXISTS eventstar_uebung_03 CHARACTER SET utf8mb4;
USE eventstar_uebung_03;

DROP TABLE IF EXISTS ausgaben, lagerkisten;
CREATE TABLE lagerkisten (
    kisten_nr INT PRIMARY KEY,
    bezeichnung VARCHAR(40) NOT NULL
) ENGINE = InnoDB;
INSERT INTO lagerkisten VALUES (12, 'Kabel'), (24, 'Schilder');
