# Session 04: Übungen

## Materialbestand ändern

EventStar pflegt den Bestand der Materialkisten. Ändern Sie eine Zeile und prüfen Sie vor dem Löschen, welche Nummer betroffen ist.

[Zur Session](README.md)

Öffnen Sie [Startskript](Session%2004%20%C3%9Cbungen%20Start.sql) in MySQL Workbench. Führen Sie es vollständig aus. Es wählt das Übungsschema `eventstar_uebung_04` aus. Führen Sie danach die Schritte der Reihe nach im selben SQL-Tab aus. Zum Neustart führen Sie das Startskript erneut aus: Es setzt die Übungstabellen zurück.

### 1. Zeile erfassen

Fügen Sie Artikel 43 «Warnweste» mit 4 Stück ein.

**Soll:** Eine Zeile wird eingefügt.

<details>
<summary>Lösung</summary>

```sql
INSERT INTO materialbestand (artikel_nr, artikel, anzahl) VALUES (43, 'Warnweste', 4);
```

</details>

### 2. Zielzeile lesen

Zeigen Sie Nummer, Artikel und Anzahl nur für Artikel 43.

**Soll:** 43, Warnweste, 4.

<details>
<summary>Lösung</summary>

```sql
SELECT artikel_nr, artikel, anzahl FROM materialbestand WHERE artikel_nr = 43;
```

</details>

### 3. Änderung zurücknehmen

Starten Sie eine Transaktion. Ändern Sie Artikel 43 auf 8 Stück, lesen Sie die Anzahl, machen Sie die Änderung rückgängig und lesen Sie nochmals. Führen Sie alles im selben Tab aus.

**Soll:** Erste Ausgabe: 8. Nach der Rücknahme: 4.

<details>
<summary>Lösung</summary>

```sql
START TRANSACTION;
UPDATE materialbestand SET anzahl = 8 WHERE artikel_nr = 43;
SELECT anzahl FROM materialbestand WHERE artikel_nr = 43;
ROLLBACK;
SELECT anzahl FROM materialbestand WHERE artikel_nr = 43;
```

</details>

### 4. Zeile entfernen

Löschen Sie nur Artikel 43 und zeigen Sie die Nummern der verbleibenden Artikel aufsteigend.

**Soll:** Die Nummern 41 und 42 bleiben erhalten.

<details>
<summary>Lösung</summary>

```sql
DELETE FROM materialbestand WHERE artikel_nr = 43;
SELECT artikel_nr FROM materialbestand ORDER BY artikel_nr;
```

</details>
