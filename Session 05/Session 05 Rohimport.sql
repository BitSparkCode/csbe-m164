-- Erst EventStar per Dump ohne CREATE DATABASE in eventstar_import wiederherstellen.
-- Im Session-Ordner mit mysql --local-infile=1 ausführen.
USE eventstar_import;
DROP TABLE IF EXISTS import_roh, import_json;
CREATE TABLE import_roh (
    roh_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quelle VARCHAR(4) NOT NULL,
    veranstaltung VARCHAR(40),
    person VARCHAR(40),
    datum VARCHAR(40),
    status_roh VARCHAR(40),
    betrag_roh VARCHAR(40)
);
CREATE TABLE import_json (dokument JSON NOT NULL);

LOAD DATA LOCAL INFILE 'Session 05 anmeldungen-roh.csv'
INTO TABLE import_roh CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n' IGNORE 1 LINES
(veranstaltung, person, datum, status_roh, @betrag)
SET quelle = 'CSV', betrag_roh = TRIM(TRAILING '\r' FROM @betrag);

LOAD DATA LOCAL INFILE 'Session 05 anmeldungen-roh.json'
INTO TABLE import_json CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\0' ESCAPED BY ''
LINES TERMINATED BY '\0'
(dokument);

INSERT INTO import_roh (quelle, veranstaltung, person, datum, status_roh, betrag_roh)
SELECT 'JSON', j.veranstaltung, j.person, j.datum, j.status_roh, j.betrag_roh
FROM import_json
CROSS JOIN JSON_TABLE(dokument, '$[*]' COLUMNS (
    pos FOR ORDINALITY,
    veranstaltung VARCHAR(40) PATH '$.veranstaltungs_id',
    person VARCHAR(40) PATH '$.teilnehmenden_id',
    datum VARCHAR(40) PATH '$.erfasst_am',
    status_roh VARCHAR(40) PATH '$.status',
    betrag_roh VARCHAR(40) PATH '$.betrag'
)) AS j
ORDER BY j.pos;

SELECT quelle, COUNT(*) AS zeilen FROM import_roh GROUP BY quelle ORDER BY quelle;
