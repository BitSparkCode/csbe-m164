# Session 01: Übungen

Freiwillige Übungen ausserhalb der Unterrichtszeit.

[Zur Session](README.md)

## Einstieg

**Basis:** Welche Modellstufe erklärt den Namen Aare, welche den Typ der Raumnummer?

**Vertiefung:** Entwerfen Sie eine Belegungsprüfung ohne Daten von Gästen.

Für Aufgaben mit Daten: [EventStar laden](../Session%2001/Session%2001%20EventStar.sql).

Beginnen Sie mit Grundlagen: sagen Sie das Ergebnis voraus, bevor Sie eine Abfrage ausführen. Bei Anwendung vergleichen Sie Soll und Ist. Bearbeiten Sie die Vertiefung zunächst ohne Musterlösung.

## Übersicht

- [Datenmodelle lesen](#datenmodelle-lesen)

## Datenmodelle lesen

### Grundlagen

**1. Welche Aufgabe haben MySQL Server und Workbench?**

**2. Ordnen Sie «Raum beherbergt Anlässe» einer Modellstufe zu.**

**3. Ordnen Sie `raeume(raum_id, name, kapazitaet)` mit Schlüssel einer Modellstufe zu.**

**4. Ordnen Sie SMALLINT UNSIGNED und InnoDB einer Modellstufe zu.**

**5. Ermitteln Sie die Serverversion und das aktive Schema.**

### Anwendung

**6. Lesen Sie die Beziehung Raum zu Veranstaltung in beiden Richtungen.**

**7. Benennen Sie beide Fremdschlüssel und den Primärschlüssel einer Anmeldung.**

**8. Weshalb gehört der Status zur Anmeldung statt zur Person?**

**9. Unterscheiden Sie Entität, Attribut und Datensatz am Raum Aare.**

**10. Zeigen Sie die gespeicherten Räume in Schlüsselreihenfolge.**

### Vertiefung

**11. Verfolgen Sie die Verbindung von Raum 10 zur Person 201 durch die Tabellen.**

**12. Welche beiden Rollen hat die Tabelle mitarbeitende im Selbstbezug?**

**13. Prüfen Sie die physische Definition des Raums.**

**14. Beurteilen Sie, ob ein Fremdschlüssel Doppelbelegungen des Raumes verhindert.**

**15. Welche Angaben braucht eine Liste freier Räume, und auf welche verzichten Sie?**
