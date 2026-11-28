CREATE DATABASE IF NOT EXISTS eventstar_04;
USE eventstar_04;

DROP TABLE IF EXISTS anmeldungen, veranstaltungen;
DROP TABLE IF EXISTS teilnehmende, raeume, mitarbeitende;

CREATE TABLE raeume (
    raum_id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE,
    kapazitaet SMALLINT UNSIGNED NOT NULL CHECK (kapazitaet > 0)
) ENGINE = InnoDB;
CREATE TABLE mitarbeitende (
    mitarbeitenden_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    vorgesetzten_id INT UNSIGNED NULL,
    CONSTRAINT fk_raumuebung_leitung FOREIGN KEY (vorgesetzten_id)
        REFERENCES mitarbeitende (mitarbeitenden_id) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB;
CREATE TABLE teilnehmende (
    teilnehmenden_id INT UNSIGNED PRIMARY KEY,
    kuerzel VARCHAR(12) NOT NULL UNIQUE
) ENGINE = InnoDB;
CREATE TABLE veranstaltungen (
    veranstaltungs_id INT UNSIGNED PRIMARY KEY,
    titel VARCHAR(100) NOT NULL,
    raum_id SMALLINT UNSIGNED NOT NULL,
    verantwortlichen_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_raumuebung_raum FOREIGN KEY (raum_id)
        REFERENCES raeume (raum_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_raumuebung_verantwortliche FOREIGN KEY (verantwortlichen_id)
        REFERENCES mitarbeitende (mitarbeitenden_id) ON DELETE RESTRICT
) ENGINE = InnoDB;
CREATE TABLE anmeldungen (
    veranstaltungs_id INT UNSIGNED NOT NULL,
    teilnehmenden_id INT UNSIGNED NOT NULL,
    status VARCHAR(16) NOT NULL DEFAULT 'offen' CHECK (status IN ('offen', 'bezahlt')),
    betrag DECIMAL(7,2) NOT NULL DEFAULT 0 CHECK (betrag >= 0),
    PRIMARY KEY (veranstaltungs_id, teilnehmenden_id),
    CONSTRAINT fk_raumuebung_anlass FOREIGN KEY (veranstaltungs_id)
        REFERENCES veranstaltungen (veranstaltungs_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_raumuebung_person FOREIGN KEY (teilnehmenden_id)
        REFERENCES teilnehmende (teilnehmenden_id) ON DELETE RESTRICT
) ENGINE = InnoDB;

INSERT INTO raeume VALUES (10, 'Aare', 36), (20, 'Gurten', 72);
INSERT INTO mitarbeitende VALUES (1, 'Lea Fluss', NULL);
INSERT INTO mitarbeitende VALUES (2, 'Miro Tal', 1), (3, 'Noa Licht', 1);
INSERT INTO teilnehmende VALUES (201, 'MS'), (202, 'JB');
INSERT INTO veranstaltungen VALUES (101, 'Lichtwerkstatt', 10, 2), (102, 'Tonstudio', 20, 3);
INSERT INTO anmeldungen VALUES (101, 201, 'bezahlt', 45), (101, 202, 'offen', 0);
