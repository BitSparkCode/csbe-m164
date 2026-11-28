# Session 05: Übungen

## Preisimport kontrollieren

EventStar erhält eine Preisliste für Mietmaterial. Das Startskript legt die drei Rohzeilen bereits so ab, wie sie nach einem Dateiimport vorliegen. Sie brauchen keine Client-Einstellungen zu ändern.

[Zur Session](README.md)

Öffnen Sie [Startskript](Session%2005%20%C3%9Cbungen%20Start.sql) in MySQL Workbench. Führen Sie es vollständig aus. Es wählt das Übungsschema `eventstar_uebung_05` aus. Führen Sie danach die Schritte der Reihe nach im selben SQL-Tab aus. Zum Neustart führen Sie das Startskript erneut aus: Es setzt die Übungstabellen zurück.

### 1. Rohzeilen lesen

Zeigen Sie die Zeilennummern und Preisangaben der Zwischentabelle in Eingangsreihenfolge.

**Soll:** Drei Textwerte: 3.50, offen, 8.00.

<details>
<summary>Lösung</summary>

```sql
SELECT zeile, preis_text FROM rohpreise ORDER BY zeile;
```

</details>

### 2. Zeile ohne Preis finden

Zeigen Sie den Materialcode, dessen Preistext «offen» ist.

**Soll:** L20 fehlt ein Zahlenwert.

<details>
<summary>Lösung</summary>

```sql
SELECT code FROM rohpreise WHERE preis_text = 'offen';
```

</details>

### 3. Gültige Zeilen übernehmen

Kopieren Sie die Zeilen mit den Nummern 1 und 3 mit `INSERT … SELECT` nach `mietpreise`. Verwenden Sie Code und Preistext als Quelle.

**Soll:** Zwei Zeilen werden übernommen. Die Zielspalte `preis` speichert die Werte als Dezimalzahlen.

<details>
<summary>Lösung</summary>

```sql
INSERT INTO mietpreise (code, preis)
SELECT code, preis_text FROM rohpreise WHERE zeile IN (1, 3);
```

</details>

### 4. Exportmenge kontrollieren

Zeigen Sie Code und Preis aus der Zieltabelle in Codereihenfolge. Speichern Sie das Ergebnis bei Bedarf über das Symbol «Export recordset» im Workbench-Ergebnisraster als CSV.

**Soll:** Zwei Datenzeilen: L10 mit 3.50 und L30 mit 8.00.

<details>
<summary>Lösung</summary>

```sql
SELECT code, preis FROM mietpreise ORDER BY code;
```

</details>
