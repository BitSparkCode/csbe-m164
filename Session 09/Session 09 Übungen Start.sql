-- Session 09: Zählstand prüfen
CREATE DATABASE IF NOT EXISTS eventstar_uebung_09 CHARACTER SET utf8mb4;
USE eventstar_uebung_09;

DROP TABLE IF EXISTS zaehlungen, garderoben;
CREATE TABLE garderoben (
    garderobe_nr INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL
) ENGINE = InnoDB;
CREATE TABLE zaehlungen (
    zaehlung_nr INT PRIMARY KEY,
    garderobe_nr INT NOT NULL,
    belegte_faecher INT NOT NULL CHECK (belegte_faecher >= 0),
    FOREIGN KEY (garderobe_nr) REFERENCES garderoben (garderobe_nr)
) ENGINE = InnoDB;
INSERT INTO garderoben VALUES (1, 'Halle'), (2, 'Foyer');
INSERT INTO zaehlungen VALUES (91, 1, 7), (92, 2, 3);
