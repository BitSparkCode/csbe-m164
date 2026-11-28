# Session 03: Übungen

## Lagerkisten und Ausgaben

EventStar speichert Kistenbezeichnungen nur in `lagerkisten`. Die Ausgaben verweisen auf die Kistennummer, statt die Bezeichnung zu wiederholen.

[Zur Session](README.md)

Öffnen Sie [Startskript](Session%2003%20%C3%9Cbungen%20Start.sql) in MySQL Workbench. Führen Sie es vollständig aus. Es wählt das Übungsschema `eventstar_uebung_03` aus. Führen Sie danach die Schritte der Reihe nach im selben SQL-Tab aus. Zum Neustart führen Sie das Startskript erneut aus: Es setzt die Übungstabellen zurück.

### 1. Ausgabentabelle anlegen

Erstellen Sie `ausgaben` mit der ganzzahligen Ausgabenummer `ausgabe_nr` als Primärschlüssel, einem Pflichtdatum `tag` und dem Pflicht-Fremdschlüssel `kisten_nr` auf `lagerkisten`.

**Soll:** Die Tabelle hat drei Spalten. Der Fremdschlüssel verweist auf `lagerkisten.kisten_nr`.

### 2. Vorhandene Kiste ausgeben

Erfassen Sie Ausgabe 31 am 05.02.2027 für Kiste 12.

**Soll:** Eine Zeile wird eingefügt.

### 3. Unbekannte Kiste testen

Versuchen Sie, Ausgabe 32 am gleichen Tag für Kiste 99 einzufügen. Führen Sie die Anweisung einzeln aus.

**Soll:** MySQL lehnt die Zeile ab: Kiste 99 ist nicht vorhanden. Fahren Sie danach mit Schritt 4 fort.

### 4. Bestand anzeigen

Lesen Sie Ausgabenummer, Datum und Kistennummer aus `ausgaben`.

**Soll:** Nur Ausgabe 31 vom 05.02.2027 für Kiste 12 ist gespeichert.
