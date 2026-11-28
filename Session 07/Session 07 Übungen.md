# Session 07: Übungen

## Materialstationen verbinden

Drei Materialstationen können Ausleihen erfassen. Station Nord hat noch keine Ausleihe.

[Zur Session](README.md)

Öffnen Sie [Startskript](Session%2007%20%C3%9Cbungen%20Start.sql) in MySQL Workbench. Führen Sie es vollständig aus. Es wählt das Übungsschema `eventstar_uebung_07` aus. Führen Sie danach die Schritte der Reihe nach im selben SQL-Tab aus. Zum Neustart führen Sie das Startskript erneut aus: Es setzt die Übungstabellen zurück.

### 1. Stationen zuordnen

Verbinden Sie beide Tabellen über die Stationsnummer. Zeigen Sie zu jeder Ausleihe Nummer und Stationsname, aufsteigend nach Ausleihenummer.

**Soll:** 71 West, 72 West, 73 Sued.

### 2. Station ohne Ausleihe finden

Beginnen Sie bei den Stationen. Zeigen Sie mit einem `LEFT JOIN` nur Stationen, zu denen keine Ausleihenummer gefunden wurde.

**Soll:** Nur Nord.

### 3. Grösste Menge finden

Zeigen Sie Nummer und Stationsname der Ausleihe mit der grössten Stückzahl. Bestimmen Sie die Höchstmenge mit einer Unterabfrage.

**Soll:** 72 West, mit 4 Stück.

## Bonus: Datenkrimi

[Bonusübung öffnen](Session%2007%20Datenkrimi.md)
