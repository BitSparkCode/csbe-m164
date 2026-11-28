# Session 07: Übungen

## Materialstationen verbinden

Drei Materialstationen können Ausleihen erfassen. Station Nord hat noch keine Ausleihe.

[Zur Session](README.md)

Öffnen Sie [Startskript](Session%2007%20%C3%9Cbungen%20Start.sql) in MySQL Workbench. Führen Sie es vollständig aus. Es wählt das Übungsschema `eventstar_uebung_07` aus. Führen Sie danach die Schritte der Reihe nach im selben SQL-Tab aus. Zum Neustart führen Sie das Startskript erneut aus: Es setzt die Übungstabellen zurück.

### 1. Stationen zuordnen

Verbinden Sie beide Tabellen über die Stationsnummer. Zeigen Sie zu jeder Ausleihe Nummer und Stationsname, aufsteigend nach Ausleihenummer.

**Soll:** 71 West, 72 West, 73 Sued.

<details>
<summary>Lösung</summary>

```sql
SELECT a.ausleihe_nr, s.name
FROM ausleihen AS a JOIN materialstationen AS s ON s.station_nr = a.station_nr
ORDER BY a.ausleihe_nr;
```

</details>

### 2. Station ohne Ausleihe finden

Beginnen Sie bei den Stationen. Zeigen Sie mit einem `LEFT JOIN` nur Stationen, zu denen keine Ausleihenummer gefunden wurde.

**Soll:** Nur Nord.

<details>
<summary>Lösung</summary>

```sql
SELECT s.name
FROM materialstationen AS s LEFT JOIN ausleihen AS a ON a.station_nr = s.station_nr
WHERE a.ausleihe_nr IS NULL;
```

</details>

### 3. Grösste Menge finden

Zeigen Sie Nummer und Stationsname der Ausleihe mit der grössten Stückzahl. Bestimmen Sie die Höchstmenge mit einer Unterabfrage.

**Soll:** 72 West, mit 4 Stück.

<details>
<summary>Lösung</summary>

```sql
SELECT a.ausleihe_nr, s.name, a.stueck
FROM ausleihen AS a JOIN materialstationen AS s ON s.station_nr = a.station_nr
WHERE a.stueck = (SELECT MAX(stueck) FROM ausleihen);
```

</details>

## Bonus: Datenkrimi

[Bonusübung öffnen](Session%2007%20Datenkrimi.md)

<details>
<summary>Lösung</summary>

```sql
USE eventstar_krimi;

SELECT 'referenz' AS bestand, COUNT(*) AS anzahl, SUM(betrag) AS summe,
       SHA2(GROUP_CONCAT(CONCAT_WS(':', anlass_id, teilnehmenden_id, betrag)
           ORDER BY anlass_id, teilnehmenden_id SEPARATOR ';'), 256) AS pruefwert
FROM anmeldungen_referenz
UNION ALL
SELECT 'aktuell', COUNT(*), SUM(betrag),
       SHA2(GROUP_CONCAT(CONCAT_WS(':', anlass_id, teilnehmenden_id, betrag)
           ORDER BY anlass_id, teilnehmenden_id SEPARATOR ';'), 256)
FROM anmeldungen;

SELECT a.anlass_id, a.teilnehmenden_id, r.betrag AS soll, a.betrag AS ist
FROM anmeldungen AS a
JOIN anmeldungen_referenz AS r USING (anlass_id, teilnehmenden_id)
WHERE a.betrag <> r.betrag
ORDER BY a.anlass_id, a.teilnehmenden_id;

WITH spur AS (
    SELECT p.person_id
    FROM aenderungsprotokoll AS p
    WHERE p.zeitpunkt >= '2026-12-04 21:00:00'
      AND p.zeitpunkt < '2026-12-04 21:10:00'
      AND EXISTS (
          SELECT 1
          FROM anmeldungen AS a
          JOIN anmeldungen_referenz AS r USING (anlass_id, teilnehmenden_id)
          WHERE a.anlass_id = p.anlass_id
            AND a.teilnehmenden_id = p.teilnehmenden_id
            AND a.betrag <> r.betrag
            AND a.betrag = p.neuer_betrag
      )
    GROUP BY p.person_id
    HAVING COUNT(DISTINCT p.anlass_id, p.teilnehmenden_id) = 2
)
SELECT m.name AS protokollierte_person, l.name AS leitung,
       SHA2(m.name, 256) AS bestaetigungswert
FROM spur
JOIN mitarbeitende AS m USING (person_id)
LEFT JOIN mitarbeitende AS l ON l.person_id = m.vorgesetzten_id;

START TRANSACTION;
UPDATE anmeldungen AS a
JOIN anmeldungen_referenz AS r USING (anlass_id, teilnehmenden_id)
SET a.betrag = r.betrag
WHERE a.betrag <> r.betrag;
SELECT ROW_COUNT() AS korrigierte_zeilen;
SELECT
    (SELECT SHA2(GROUP_CONCAT(CONCAT_WS(':', anlass_id, teilnehmenden_id, betrag)
        ORDER BY anlass_id, teilnehmenden_id SEPARATOR ';'), 256) FROM anmeldungen) =
    (SELECT SHA2(GROUP_CONCAT(CONCAT_WS(':', anlass_id, teilnehmenden_id, betrag)
        ORDER BY anlass_id, teilnehmenden_id SEPARATOR ';'), 256) FROM anmeldungen_referenz) AS hash_gleich;
ROLLBACK;
```

</details>
