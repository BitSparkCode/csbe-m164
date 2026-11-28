-- Session 08: Versandpakete erfassen
CREATE DATABASE IF NOT EXISTS eventstar_uebung_08 CHARACTER SET utf8mb4;
USE eventstar_uebung_08;

DROP TABLE IF EXISTS pakete, packorte;
CREATE TABLE packorte (
    ort_nr INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL
) ENGINE = InnoDB;
INSERT INTO packorte VALUES (1, 'Halle'), (2, 'Rampe');
