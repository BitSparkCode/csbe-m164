# Session 02: Übungen

Freiwillige Übungen ausserhalb der Unterrichtszeit.

[Zur Session](README.md)

## Einstieg

**Basis:** Ergänzen Sie `DECIMAL(…, …)` für höchstens 9’999.99 Franken.

**Vertiefung:** Warum hält der Typ allein eine negative Zahlung nicht auf?

<details>
<summary>Lösung</summary>

DECIMAL(6,2). Für die Fachregel braucht es zusätzlich CHECK (betrag >= 0).

</details>

Für Aufgaben mit Daten: [EventStar laden](../Session%2002/Session%2002%20EventStar.sql).

Beginnen Sie mit Grundlagen: sagen Sie das Ergebnis voraus, bevor Sie eine Abfrage ausführen. Bei Anwendung vergleichen Sie Soll und Ist. Bearbeiten Sie die Vertiefung zunächst ohne Musterlösung.

## Übersicht

- [Tabellen und Datentypen](#tabellen-und-datentypen)

## Tabellen und Datentypen

### Grundlagen

**1. Unterscheiden Sie Schema, Tabelle und Spalte anhand von EventStar.**

<details>
<summary>Lösung</summary>

eventstar_02 ist das Schema; veranstaltungen ist eine Tabelle; preis ist eine Spalte.

</details>

**2. Wofür ist das Datenbankmanagementsystem zuständig?**

<details>
<summary>Lösung</summary>

Es verwaltet Speicher, Abfragen, gleichzeitigen Zugriff und die Kontrolle von Tabellenregeln.

</details>

**3. Ordnen Sie Zeichensatz und Kollation je eine Aufgabe zu.**

<details>
<summary>Lösung</summary>

Der Zeichensatz legt darstellbare Zeichen fest. Die Kollation bestimmt Vergleich und Sortierung.

</details>

**4. Unterscheiden Sie Tablespace und Partition.**

<details>
<summary>Lösung</summary>

Ein Tablespace organisiert die physische Ablage. Eine Partition teilt eine Tabelle nach einer Regel in Teilbereiche.

</details>

**5. Wählen Sie den Typ für 1’500 Plätze ohne negative Werte.**

<details>
<summary>Lösung</summary>

SMALLINT UNSIGNED deckt die Werte ab. CHECK (kapazitaet > 0) schliesst 0 aus, falls fachlich nötig.

</details>

### Anwendung

**6. Wählen Sie einen Typ für höchstens 9’999.99 Franken.**

<details>
<summary>Lösung</summary>

DECIMAL(6,2) speichert genau vier Vorkomma- und zwei Nachkommastellen.

</details>

**7. Wählen Sie Typen für Code mit genau vier Zeichen und optionale Notiz bis 120 Zeichen.**

<details>
<summary>Lösung</summary>

CHAR(4) für den Code mit UNIQUE, VARCHAR(120) NULL für die Notiz. Die genaue Codelänge kann ein CHECK absichern.

</details>

**8. Wann ist DATE gegenüber DATETIME passend?**

<details>
<summary>Lösung</summary>

DATE genügt für einen Kalendertag. DATETIME speichert zusätzlich Uhrzeit, aber keine Zeitzone.

</details>

**9. Vergleichen Sie eine örtliche Startzeit und einen Messwert.**

<details>
<summary>Lösung</summary>

TIME kann die Startzeit abbilden; DOUBLE eignet sich für einen angenäherten Messwert, nicht für Geldbeträge.

</details>

**10. Welche Typfamilie verwenden Sie für eine binäre Prüfsumme mit 32 Bytes?**

<details>
<summary>Lösung</summary>

BINARY(32) für rohe Bytes; CHAR(64) für die hexadezimale Darstellung.

</details>

### Vertiefung

**11. Ermitteln Sie Typ und Standardwert von preis.**

<details>
<summary>Lösung</summary>

```sql
SELECT COLUMN_TYPE, COLUMN_DEFAULT FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='veranstaltungen' AND COLUMN_NAME='preis';
```

decimal(7,2) und 0.00.

</details>

**12. Legen Sie eine Tabelle zuerst in Workbench an. Womit vergleichen Sie den Entwurf?**

<details>
<summary>Lösung</summary>

Öffnen Sie vor Apply die SQL-Vorschau. Vergleichen Sie danach SHOW CREATE TABLE mit Schlüssel, Spaltentypen und Standardwerten im Entwurf.

</details>

**13. Legen Sie eine temporäre Tabelle mit Nummer, Code und positivem Standardwert an.**

<details>
<summary>Lösung</summary>

```sql
CREATE TEMPORARY TABLE u_platz (platz_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, code CHAR(4) NOT NULL UNIQUE, plaetze SMALLINT UNSIGNED NOT NULL DEFAULT 1 CHECK (plaetze > 0));
SHOW CREATE TABLE u_platz;
DROP TEMPORARY TABLE u_platz;
```

</details>

**14. Ergänzen Sie in einer eigenen temporären Tabelle eine optionale Notiz.**

<details>
<summary>Lösung</summary>

```sql
CREATE TEMPORARY TABLE u_notiz (nummer INT PRIMARY KEY);
ALTER TABLE u_notiz ADD COLUMN notiz VARCHAR(120) NULL;
DESCRIBE u_notiz;
DROP TEMPORARY TABLE u_notiz;
```

</details>

**15. Ein Pflichtfeld fehlt beim INSERT. Unterscheiden Sie NOT NULL und DEFAULT.**

<details>
<summary>Lösung</summary>

NOT NULL verbietet einen fehlenden Wert. DEFAULT setzt einen Ersatzwert, wenn kein Wert angegeben wird.

</details>

**16. Eine Belegung hat PRIMARY KEY (raum_id, tag). Was passiert bei gleichem Paar und was bei unbekannter Raum-ID?**

<details>
<summary>Lösung</summary>

Dasselbe Paar verletzt den Primärschlüssel (1062). Eine unbekannte Raum-ID verletzt den Fremdschlüssel (1452).

</details>

**17. Warum ist SQL Server TIMESTAMP kein Ersatz für MySQL TIMESTAMP?**

<details>
<summary>Lösung</summary>

In SQL Server bedeutet TIMESTAMP ROWVERSION und speichert keinen Zeitpunkt. Je nach Zweck passen DATETIME2 oder DATETIMEOFFSET.

</details>

**18. Legen Sie eine temporäre Kontrollliste für Stromkreise an. Setzen Sie das Prüfdatum automatisch. Benennen Sie die Notiz um und prüfen Sie Struktur und Datum.**

<details>
<summary>Lösung</summary>

```sql
CREATE TEMPORARY TABLE u_stromkreis (code CHAR(5) PRIMARY KEY, kontrolltag DATE NOT NULL DEFAULT (CURRENT_DATE), notiz VARCHAR(50));
ALTER TABLE u_stromkreis RENAME COLUMN notiz TO messnotiz;
INSERT INTO u_stromkreis (code) VALUES ('S-204');
DESCRIBE u_stromkreis;
SELECT kontrolltag = CURRENT_DATE AS stimmt FROM u_stromkreis;
DROP TEMPORARY TABLE u_stromkreis;
```

Die Spalte heisst messnotiz. stimmt ist 1.

</details>
