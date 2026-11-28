# Session 02: Übungen

Freiwillige Übungen ausserhalb der Unterrichtszeit.

[Zur Session](README.md)

## Einstieg

**Basis:** Ergänzen Sie `DECIMAL(…, …)` für höchstens 9’999.99 Franken.

**Vertiefung:** Warum hält der Typ allein eine negative Zahlung nicht auf?

Für Aufgaben mit Daten: [EventStar laden](../Session%2002/Session%2002%20EventStar.sql).

Beginnen Sie mit Grundlagen: sagen Sie das Ergebnis voraus, bevor Sie eine Abfrage ausführen. Bei Anwendung vergleichen Sie Soll und Ist. Bearbeiten Sie die Vertiefung zunächst ohne Musterlösung.

## Übersicht

- [Tabellen und Datentypen](#tabellen-und-datentypen)

## Tabellen und Datentypen

### Grundlagen

**1. Unterscheiden Sie Schema, Tabelle und Spalte anhand von EventStar.**

**2. Wofür ist das Datenbankmanagementsystem zuständig?**

**3. Ordnen Sie Zeichensatz und Kollation je eine Aufgabe zu.**

**4. Unterscheiden Sie Tablespace und Partition.**

**5. Wählen Sie den Typ für 1’500 Plätze ohne negative Werte.**

### Anwendung

**6. Wählen Sie einen Typ für höchstens 9’999.99 Franken.**

**7. Wählen Sie Typen für Code mit genau vier Zeichen und optionale Notiz bis 120 Zeichen.**

**8. Wann ist DATE gegenüber DATETIME passend?**

**9. Vergleichen Sie eine örtliche Startzeit und einen Messwert.**

**10. Welche Typfamilie verwenden Sie für eine binäre Prüfsumme mit 32 Bytes?**

### Vertiefung

**11. Ermitteln Sie Typ und Standardwert von preis.**

**12. Legen Sie eine Tabelle zuerst in Workbench an. Womit vergleichen Sie den Entwurf?**

**13. Legen Sie eine temporäre Tabelle mit Nummer, Code und positivem Standardwert an.**

**14. Ergänzen Sie in einer eigenen temporären Tabelle eine optionale Notiz.**

**15. Ein Pflichtfeld fehlt beim INSERT. Unterscheiden Sie NOT NULL und DEFAULT.**

**16. Eine Belegung hat PRIMARY KEY (raum_id, tag). Was passiert bei gleichem Paar und was bei unbekannter Raum-ID?**

**17. Warum ist SQL Server TIMESTAMP kein Ersatz für MySQL TIMESTAMP?**

**18. Legen Sie eine temporäre Kontrollliste für Stromkreise an. Setzen Sie das Prüfdatum automatisch. Benennen Sie die Notiz um und prüfen Sie Struktur und Datum.**
