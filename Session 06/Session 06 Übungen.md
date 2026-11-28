# Session 06: Übungen

## Infokarten auswerten

Für einen Anlass druckt EventStar Infokarten zu Programm und Anreise. Eine Notiz ist optional.

[Zur Session](README.md)

Öffnen Sie [Startskript](Session%2006%20%C3%9Cbungen%20Start.sql) in MySQL Workbench. Führen Sie es vollständig aus. Es wählt das Übungsschema `eventstar_uebung_06` aus. Führen Sie danach die Schritte der Reihe nach im selben SQL-Tab aus. Zum Neustart führen Sie das Startskript erneut aus: Es setzt die Übungstabellen zurück.

### 1. Sortiert filtern

Zeigen Sie Nummer und Exemplare für Karten mit mindestens 20 Exemplaren. Sortieren Sie aufsteigend nach Exemplaren.

**Soll:** Karte 13 mit 20 steht vor Karte 11 mit 30.

### 2. Fehlende Notiz finden

Zeigen Sie die Nummern der Karten ohne Notiz in aufsteigender Reihenfolge.

**Soll:** 11 und 14.

### 3. Exemplare zusammenzählen

Summieren Sie die Exemplare pro Bereich. Zeigen Sie nur Bereiche, für die mindestens zwei Karten gespeichert sind.

**Soll:** Nur Programm bleibt: zwei Karten mit insgesamt 50 Exemplaren.
