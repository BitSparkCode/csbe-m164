-- Session 05: Preisimport kontrollieren
CREATE DATABASE IF NOT EXISTS eventstar_uebung_05 CHARACTER SET utf8mb4;
USE eventstar_uebung_05;

DROP TABLE IF EXISTS rohpreise, mietpreise;
CREATE TABLE rohpreise (
    zeile INT PRIMARY KEY,
    code CHAR(3) NOT NULL,
    preis_text VARCHAR(12) NOT NULL
);
CREATE TABLE mietpreise (
    code CHAR(3) PRIMARY KEY,
    preis DECIMAL(6,2) NOT NULL
);
INSERT INTO rohpreise VALUES
    (1, 'L10', '3.50'), (2, 'L20', 'offen'), (3, 'L30', '8.00');
