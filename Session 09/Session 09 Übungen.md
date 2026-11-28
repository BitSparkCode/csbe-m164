# Session 09: Übungen

## Zählstand prüfen

EventStar zählt benutzte Schliessfächer an zwei Garderoben. Die Zählergebnisse können neben der Garderobenliste ausgewertet werden.

[Zur Session](README.md)

Öffnen Sie [Startskript](Session%2009%20%C3%9Cbungen%20Start.sql) in MySQL Workbench. Führen Sie es vollständig aus. Es wählt das Übungsschema `eventstar_uebung_09` aus. Führen Sie danach die Schritte der Reihe nach im selben SQL-Tab aus. Zum Neustart führen Sie das Startskript erneut aus: Es setzt die Übungstabellen zurück.

### 1. Tabellen verbinden

Zeigen Sie Garderobennamen und belegte Fächer zusammen an. Sortieren Sie nach der Garderobennummer.

**Soll:** Halle: 7. Foyer: 3.

### 2. Korrektur eingrenzen

Bei Zählung 92 sind es 5 statt 3 belegte Fächer. Ändern Sie nur diese Zeile und lesen Sie beide Nummern mit ihrem Zählstand.

**Soll:** 91 bleibt bei 7. 92 steht neu bei 5.

### 3. Gesamtzahl ausgeben

Summieren Sie die belegten Fächer über beide Zählungen.

**Soll:** 12 belegte Fächer.
