# Session 08: Übungen

## Versandpakete erfassen

EventStar verteilt Pakete auf Packorte. Ein Packort kann mehrere Pakete aufnehmen; jedes Paket gehört genau einem Packort.

[Zur Session](README.md)

Öffnen Sie [Startskript](Session%2008%20%C3%9Cbungen%20Start.sql) in MySQL Workbench. Führen Sie es vollständig aus. Es wählt das Übungsschema `eventstar_uebung_08` aus. Führen Sie danach die Schritte der Reihe nach im selben SQL-Tab aus. Zum Neustart führen Sie das Startskript erneut aus: Es setzt die Übungstabellen zurück.

### 1. Tabelle ableiten

Legen Sie `pakete` mit Textschlüssel `paketcode` (drei Zeichen), Pflicht-Fremdschlüssel `ort_nr` und Pflicht-Textspalte `status` (höchstens zwölf Zeichen) an.

**Soll:** Jedes Paket verweist auf einen vorhandenen Packort.

<details>
<summary>Lösung</summary>

```sql
CREATE TABLE pakete (
    paketcode CHAR(3) PRIMARY KEY,
    ort_nr INT NOT NULL,
    status VARCHAR(12) NOT NULL,
    FOREIGN KEY (ort_nr) REFERENCES packorte (ort_nr)
) ENGINE = InnoDB;
```

</details>

### 2. Zwei Pakete laden

Erfassen Sie P10 für Ort 1 und P20 für Ort 2 mit dem Status «offen» in einer Anweisung.

**Soll:** Zwei Zeilen werden eingefügt.

<details>
<summary>Lösung</summary>

```sql
INSERT INTO pakete (paketcode, ort_nr, status) VALUES
    ('P10', 1, 'offen'), ('P20', 2, 'offen');
```

</details>

### 3. Ein Paket umlagern

Ändern Sie den Ort nur für Paket P10 auf Ort 2.

**Soll:** Eine Zeile wird geändert.

<details>
<summary>Lösung</summary>

```sql
UPDATE pakete SET ort_nr = 2 WHERE paketcode = 'P10';
```

</details>

### 4. Zuordnungen kontrollieren

Zeigen Sie Paketcode, Packort und Status beider Pakete in Codereihenfolge.

**Soll:** P10 und P20 stehen beide bei der Rampe und bleiben offen.

<details>
<summary>Lösung</summary>

```sql
SELECT p.paketcode, o.name, p.status
FROM pakete AS p JOIN packorte AS o ON o.ort_nr = p.ort_nr
ORDER BY p.paketcode;
```

</details>
