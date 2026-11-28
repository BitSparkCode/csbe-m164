USE eventstar_01;

DROP TEMPORARY TABLE IF EXISTS raumtest_innodb, raumtest_myisam;
CREATE TEMPORARY TABLE raumtest_innodb (
    raum_id SMALLINT UNSIGNED PRIMARY KEY
) ENGINE=InnoDB;
CREATE TEMPORARY TABLE raumtest_myisam (
    raum_id SMALLINT UNSIGNED PRIMARY KEY
) ENGINE=MyISAM;

SHOW CREATE TABLE raumtest_innodb;
SHOW CREATE TABLE raumtest_myisam;

START TRANSACTION;
INSERT INTO raumtest_innodb SELECT raum_id FROM raeume WHERE raum_id=10;
INSERT INTO raumtest_myisam SELECT raum_id FROM raeume WHERE raum_id=10;
ROLLBACK;
SHOW WARNINGS;

SELECT 'InnoDB' AS engine, COUNT(*) AS zeilen FROM raumtest_innodb
UNION ALL
SELECT 'MyISAM', COUNT(*) FROM raumtest_myisam;

DROP TEMPORARY TABLE raumtest_innodb, raumtest_myisam;
