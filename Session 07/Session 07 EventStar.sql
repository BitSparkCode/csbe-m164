CREATE DATABASE IF NOT EXISTS eventstar_07
    CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE eventstar_07;

CREATE TABLE raeume (
    raum_id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE,
    kapazitaet SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT chk_raum_kapazitaet CHECK (kapazitaet > 0)
) ENGINE = InnoDB;

CREATE TABLE mitarbeitende (
    mitarbeitenden_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    vorgesetzten_id INT UNSIGNED NULL,
    CONSTRAINT fk_mitarbeitende_vorgesetzte FOREIGN KEY (vorgesetzten_id)
        REFERENCES mitarbeitende (mitarbeitenden_id)
        ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE veranstaltungen (
    veranstaltungs_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titel VARCHAR(120) NOT NULL,
    beginnt_am DATETIME NOT NULL,
    preis DECIMAL(7, 2) NOT NULL DEFAULT 0.00,
    raum_id SMALLINT UNSIGNED NOT NULL,
    verantwortlichen_id INT UNSIGNED NOT NULL,
    CONSTRAINT chk_veranstaltung_preis CHECK (preis >= 0),
    CONSTRAINT fk_veranstaltungen_raum FOREIGN KEY (raum_id)
        REFERENCES raeume (raum_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_veranstaltungen_verantwortliche FOREIGN KEY (verantwortlichen_id)
        REFERENCES mitarbeitende (mitarbeitenden_id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE teilnehmende (
    teilnehmenden_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    vorname VARCHAR(60) NOT NULL,
    nachname VARCHAR(60) NOT NULL,
    email VARCHAR(180) NOT NULL UNIQUE,
    geburtsdatum DATE NULL,
    CONSTRAINT chk_teilnehmende_email CHECK (CHAR_LENGTH(TRIM(email)) > 0)
) ENGINE = InnoDB;

CREATE TABLE anmeldungen (
    veranstaltungs_id INT UNSIGNED NOT NULL,
    teilnehmenden_id INT UNSIGNED NOT NULL,
    erfasst_am DATE NOT NULL,
    status VARCHAR(16) NOT NULL DEFAULT 'offen',
    betrag DECIMAL(7, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (veranstaltungs_id, teilnehmenden_id),
    CONSTRAINT chk_anmeldungen_status CHECK (status IN ('offen', 'bezahlt', 'storniert')),
    CONSTRAINT chk_anmeldungen_betrag CHECK (betrag >= 0),
    CONSTRAINT fk_anmeldungen_veranstaltung FOREIGN KEY (veranstaltungs_id)
        REFERENCES veranstaltungen (veranstaltungs_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_anmeldungen_teilnehmende FOREIGN KEY (teilnehmenden_id)
        REFERENCES teilnehmende (teilnehmenden_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

USE eventstar_07;
START TRANSACTION;

INSERT INTO raeume (raum_id, name, kapazitaet) VALUES
    (10, 'Aare', 36), (20, 'Gurten', 72), (30, 'Matte', 18),
    (40, 'Reichenbach', 25);

INSERT INTO mitarbeitende (mitarbeitenden_id, name, vorgesetzten_id) VALUES
    (1, 'Lea Fluss', NULL);
INSERT INTO mitarbeitende (mitarbeitenden_id, name, vorgesetzten_id) VALUES
    (2, 'Miro Tal', 1), (3, 'Noa Licht', 1);
INSERT INTO mitarbeitende (mitarbeitenden_id, name, vorgesetzten_id) VALUES
    (4, 'Eli Moos', 2);

INSERT INTO veranstaltungen
    (veranstaltungs_id, titel, beginnt_am, preis, raum_id, verantwortlichen_id)
VALUES
    (101, 'Lichtwerkstatt', '2027-01-16 09:00:00', 45.00, 10, 2),
    (102, 'Tonstudio', '2027-01-16 13:30:00', 55.00, 20, 3),
    (103, 'Papieratelier', '2027-01-23 10:00:00', 30.00, 30, 2),
    (104, 'Fotospaziergang', '2027-02-06 14:00:00', 25.00, 10, 4),
    (105, 'Druckwerkstatt', '2027-02-13 09:00:00', 40.00, 30, 4);

INSERT INTO teilnehmende (teilnehmenden_id, vorname, nachname, email, geburtsdatum) VALUES
    (201, 'Mira', 'Silber', 'mira.silber@example.org', '1998-04-09'),
    (202, 'Jonas', 'Birke', 'jonas.birke@example.org', '2001-03-17'),
    (203, 'Dana', 'Vogel', 'dana.vogel@example.org', NULL),
    (204, 'Sami', 'Klee', 'sami.klee@example.org', '1997-08-23'),
    (205, 'Noel', 'Sand', 'noel.sand@example.org', NULL),
    (206, 'Ari', 'Mohn', 'ari.mohn@example.org', '2003-10-08'),
    (207, 'Nila', 'Sonne', 'nila.sonne@example.org', '1999-01-12');

INSERT INTO anmeldungen (veranstaltungs_id, teilnehmenden_id, erfasst_am, status, betrag) VALUES
    (101, 201, '2026-11-02', 'bezahlt', 45.00),
    (101, 202, '2026-11-03', 'offen', 0.00),
    (101, 204, '2026-11-04', 'storniert', 0.00),
    (102, 201, '2026-11-02', 'bezahlt', 55.00),
    (102, 203, '2026-11-04', 'bezahlt', 50.00),
    (103, 202, '2026-11-05', 'bezahlt', 30.00),
    (103, 205, '2026-11-06', 'offen', 0.00),
    (104, 204, '2026-11-07', 'bezahlt', 25.00);

COMMIT;
