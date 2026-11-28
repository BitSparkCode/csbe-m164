# Normalisierung: Parkplatz-Reservation

## Ausgangslage

![Nicht normalisierte Reservationsliste mit drei Buchungen und den zugehörigen Personen-, Fahrzeug- und Standortdaten.](Session%2003%20Normalisierung%20Ausgangslage.svg)

## Lösung

### Übersicht

![Links die flache Reservationsliste mit markierten Wiederholungen, rechts fünf verknüpfte Tabellen mit Primär- und Fremdschlüsseln und darunter die Regeln der drei Normalformen.](Session%2003%20Normalisierung.svg)

### 1. Anomalien

| Anomalie | Beispiel |
|---|---|
| Einfügen | Einen neuen Standort «Bahnhof» können wir nicht für sich erfassen: Die Ausgangsliste verlangt unter anderem eine Reservationsnummer und ein Datum. |
| Ändern | Wird der Ibis-Tagespreis nur bei Reservation 101 auf 9.50 geändert, steht bei Reservation 102 weiterhin 8.50. |
| Löschen | Wird Reservation 103 gelöscht, gehen mit der letzten Zeile zu Stadtpark auch dessen Adresse und Preis verloren. |

### 2. Erste Normalform

![1NF: fünf Zeilen mit einzelnem Kennzeichen und zusammengesetztem Primärschlüssel.](Session%2003%20Normalisierung%201NF.svg)

Das Feld mit der Kennzeichenliste wird aufgeteilt: In `reservationsliste_1nf` steht pro Zeile ein einzelnes Kennzeichen. Die fünf entstehenden Zeilen lassen sich über den zusammengesetzten Schlüssel `(reservationsnr, kennzeichen)` unterscheiden. Name, Telefonnummer und Standortangaben bleiben vorerst mehrfach gespeichert.

### 3. Zweite Normalform

![2NF: Buchungen und Fahrzeuge in zwei getrennten Tabellen.](Session%2003%20Normalisierung%202NF.svg)

In der 2NF darf ein Nichtschlüsselattribut nicht nur von einem Teil eines zusammengesetzten Schlüssels abhängen. Datum und Parkplatz hängen nur von der Reservationsnummer ab, die Halterzuordnung nur vom Kennzeichen. Deshalb enthält `buchungen_2nf` genau eine Zeile pro Reservation und `fahrzeuge_2nf` genau eine Zeile pro Kennzeichen. Eine separate Zuordnung von Fahrzeug zu Reservation ist nicht nötig: Die Ausgangsliste zeigt alle Kennzeichen der Person.

### 4. Dritte Normalform

![3NF: fünf Tabellen mit Beispieldaten und Pfeilen von den Fremdschlüsseln zu den Primärschlüsseln.](Session%2003%20Normalisierung%203NF.svg)

In der 3NF sollen Nichtschlüsselattribute nicht über andere Nichtschlüsselattribute vom Schlüssel abhängen. Name und Telefon hängen von der Personennummer ab. Die Parkplatznummer bestimmt den Standort; dessen Nummer bestimmt Name, Adresse und Preis. Diese Angaben wandern in `personen`, `parkplaetze` und `standorte`. In `reservationen` bleiben die Reservationsnummer, das Datum und die beiden Fremdschlüssel. `fahrzeuge` behält das Kennzeichen und verweist über die Personennummer auf `personen`.

### 5. ERD

Das ERD zeigt Schlüssel und Kardinalitäten; die Typen ergänzen die MySQL-Umsetzung. Vergleichen Sie die vier Beziehungen einzeln mit Ihrer Zeichnung:

- Eine Person kann null bis viele Fahrzeuge und null bis viele Reservationen haben. Ein Fahrzeug und eine Reservation gehören jeweils genau einer Person.
- Ein Standort kann null bis viele Parkplätze haben. Jeder Parkplatz gehört genau einem Standort.
- Ein Parkplatz kann über mehrere Tage null bis viele Reservationen haben. Jede Reservation belegt genau einen Parkplatz. Die Regel «höchstens einmal pro Tag» wird zusätzlich mit `UNIQUE (parkplatz_nr, datum)` umgesetzt.

```mermaid
erDiagram
    personen ||..o{ fahrzeuge : registriert
    personen ||..o{ reservationen : bucht
    standorte ||..o{ parkplaetze : umfasst
    parkplaetze ||..o{ reservationen : hat

    personen {
        INT person_nr PK
        VARCHAR(50) personenname
        VARCHAR(20) telefon
    }
    fahrzeuge {
        VARCHAR(12) kennzeichen PK
        INT person_nr FK
    }
    standorte {
        INT standort_nr PK
        VARCHAR(50) standort
        VARCHAR(80) adresse
        DECIMAL(6,2) tagespreis
    }
    parkplaetze {
        CHAR(3) parkplatz_nr PK
        INT standort_nr FK
    }
    reservationen {
        INT reservationsnr PK
        DATE datum
        INT person_nr FK
        CHAR(3) parkplatz_nr FK
    }
```

### 6. Tabellen erstellen

Legen Sie die Elterntabellen an, bevor Sie Tabellen mit Verweisen darauf erstellen. Ein `PRIMARY KEY` ist bereits eindeutig und schliesst `NULL` aus; Pflichtfelder und Pflichtverweise erhalten `NOT NULL`. Die Typen der FK-Spalten entsprechen denen der referenzierten Schlüssel.

**Personen.** Die Personennummer identifiziert die Zeile. Die Telefonnummer bleibt Text, damit führende Nullen und Leerzeichen erhalten bleiben.

```sql
CREATE TABLE personen (
    person_nr INT PRIMARY KEY,
    personenname VARCHAR(50) NOT NULL,
    telefon VARCHAR(20) NOT NULL
) ENGINE = InnoDB;
```

**Fahrzeuge.** Das Kennzeichen ist ein Textschlüssel. Der Fremdschlüssel stellt sicher, dass der eingetragene Halter existiert.

```sql
CREATE TABLE fahrzeuge (
    kennzeichen VARCHAR(12) PRIMARY KEY,
    person_nr INT NOT NULL,
    FOREIGN KEY (person_nr) REFERENCES personen (person_nr)
) ENGINE = InnoDB;
```

**Standorte.** Der Preis wird als `DECIMAL(6,2)` gespeichert, damit Beträge mit zwei Nachkommastellen exakt bleiben.

```sql
CREATE TABLE standorte (
    standort_nr INT PRIMARY KEY,
    standort VARCHAR(50) NOT NULL,
    adresse VARCHAR(80) NOT NULL,
    tagespreis DECIMAL(6,2) NOT NULL
) ENGINE = InnoDB;
```

**Parkplätze.** `CHAR(3)` passt zu den fest dreistelligen Parkplatznummern wie `A01`. Die Standortnummer ist Pflicht.

```sql
CREATE TABLE parkplaetze (
    parkplatz_nr CHAR(3) PRIMARY KEY,
    standort_nr INT NOT NULL,
    FOREIGN KEY (standort_nr) REFERENCES standorte (standort_nr)
) ENGINE = InnoDB;
```

**Reservationen.** `DATE` speichert das Datum ohne Uhrzeit. `UNIQUE (parkplatz_nr, datum)` verhindert eine zweite Reservation für denselben Parkplatz am selben Tag; derselbe Parkplatz darf an anderen Tagen erneut reserviert werden.

```sql
CREATE TABLE reservationen (
    reservationsnr INT PRIMARY KEY,
    datum DATE NOT NULL,
    person_nr INT NOT NULL,
    parkplatz_nr CHAR(3) NOT NULL,
    UNIQUE (parkplatz_nr, datum),
    FOREIGN KEY (person_nr) REFERENCES personen (person_nr),
    FOREIGN KEY (parkplatz_nr) REFERENCES parkplaetze (parkplatz_nr)
) ENGINE = InnoDB;
```

### 7. Beispieldaten

Tragen Sie zuerst die Datensätze ein, auf die andere Tabellen verweisen. Die folgenden Werte stammen direkt aus der Ausgangsliste.

```sql
INSERT INTO personen (person_nr, personenname, telefon) VALUES
    (1, 'Maier', '031 555 01 01'),
    (2, 'Huber', '031 555 02 02');

INSERT INTO fahrzeuge (kennzeichen, person_nr) VALUES
    ('BE12345', 1),
    ('BE45678', 1),
    ('BE98765', 2);

INSERT INTO standorte (standort_nr, standort, adresse, tagespreis) VALUES
    (10, 'Ibis', 'Ibisweg 1, Bern', 8.50),
    (20, 'Stadtpark', 'Parkstrasse 1, Bern', 11.00);

INSERT INTO parkplaetze (parkplatz_nr, standort_nr) VALUES
    ('A01', 10),
    ('A02', 10),
    ('B01', 20);

INSERT INTO reservationen (reservationsnr, datum, person_nr, parkplatz_nr) VALUES
    (101, '2027-01-14', 1, 'A01'),
    (102, '2027-01-15', 1, 'A02'),
    (103, '2027-01-14', 2, 'B01');
```

### 8. Kontrolle

Diese fertige Abfrage dient nur zur Kontrolle. Für Maier erscheinen zwei Zeilen pro Reservation, weil zwei Kennzeichen registriert sind.

```sql
SELECT r.reservationsnr, r.datum, p.personenname, v.kennzeichen,
       pp.parkplatz_nr, s.standort, s.tagespreis
FROM reservationen AS r
JOIN personen AS p ON p.person_nr = r.person_nr
JOIN parkplaetze AS pp ON pp.parkplatz_nr = r.parkplatz_nr
JOIN standorte AS s ON s.standort_nr = pp.standort_nr
LEFT JOIN fahrzeuge AS v ON v.person_nr = p.person_nr
ORDER BY r.reservationsnr, v.kennzeichen;
```

| Reservationsnr. | Datum | Name | Kennzeichen | Parkplatz | Standort | Tagespreis |
|---|---|---|---|---|---|---:|
| 101 | 2027-01-14 | Maier | BE12345 | A01 | Ibis | 8.50 |
| 101 | 2027-01-14 | Maier | BE45678 | A01 | Ibis | 8.50 |
| 102 | 2027-01-15 | Maier | BE12345 | A02 | Ibis | 8.50 |
| 102 | 2027-01-15 | Maier | BE45678 | A02 | Ibis | 8.50 |
| 103 | 2027-01-14 | Huber | BE98765 | B01 | Stadtpark | 11.00 |

## Vollständiges SQL-Skript

[SQL-Datei für MySQL Workbench](Session%2003%20Normalisierung.sql)

```sql
-- Parkplatz-Reservation: Normalisierung (MySQL 8.4)
-- Vor dem Ausführen in Workbench ein leeres Übungsschema als Standard wählen.

-- Tabellen anlegen
CREATE TABLE personen (
    person_nr INT PRIMARY KEY,
    personenname VARCHAR(50) NOT NULL,
    telefon VARCHAR(20) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE fahrzeuge (
    kennzeichen VARCHAR(12) PRIMARY KEY,
    person_nr INT NOT NULL,
    FOREIGN KEY (person_nr) REFERENCES personen (person_nr)
) ENGINE = InnoDB;

CREATE TABLE standorte (
    standort_nr INT PRIMARY KEY,
    standort VARCHAR(50) NOT NULL,
    adresse VARCHAR(80) NOT NULL,
    tagespreis DECIMAL(6,2) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE parkplaetze (
    parkplatz_nr CHAR(3) PRIMARY KEY,
    standort_nr INT NOT NULL,
    FOREIGN KEY (standort_nr) REFERENCES standorte (standort_nr)
) ENGINE = InnoDB;

CREATE TABLE reservationen (
    reservationsnr INT PRIMARY KEY,
    datum DATE NOT NULL,
    person_nr INT NOT NULL,
    parkplatz_nr CHAR(3) NOT NULL,
    UNIQUE (parkplatz_nr, datum),
    FOREIGN KEY (person_nr) REFERENCES personen (person_nr),
    FOREIGN KEY (parkplatz_nr) REFERENCES parkplaetze (parkplatz_nr)
) ENGINE = InnoDB;

-- Beispieldaten einfügen
INSERT INTO personen (person_nr, personenname, telefon) VALUES
    (1, 'Maier', '031 555 01 01'),
    (2, 'Huber', '031 555 02 02');

INSERT INTO fahrzeuge (kennzeichen, person_nr) VALUES
    ('BE12345', 1),
    ('BE45678', 1),
    ('BE98765', 2);

INSERT INTO standorte (standort_nr, standort, adresse, tagespreis) VALUES
    (10, 'Ibis', 'Ibisweg 1, Bern', 8.50),
    (20, 'Stadtpark', 'Parkstrasse 1, Bern', 11.00);

INSERT INTO parkplaetze (parkplatz_nr, standort_nr) VALUES
    ('A01', 10),
    ('A02', 10),
    ('B01', 20);

INSERT INTO reservationen (reservationsnr, datum, person_nr, parkplatz_nr) VALUES
    (101, '2027-01-14', 1, 'A01'),
    (102, '2027-01-15', 1, 'A02'),
    (103, '2027-01-14', 2, 'B01');

-- Daten mit JOIN kontrollieren
SELECT r.reservationsnr, r.datum, p.personenname, v.kennzeichen,
       pp.parkplatz_nr, s.standort, s.tagespreis
FROM reservationen AS r
JOIN personen AS p ON p.person_nr = r.person_nr
JOIN parkplaetze AS pp ON pp.parkplatz_nr = r.parkplatz_nr
JOIN standorte AS s ON s.standort_nr = pp.standort_nr
LEFT JOIN fahrzeuge AS v ON v.person_nr = p.person_nr
ORDER BY r.reservationsnr, v.kennzeichen;
```
