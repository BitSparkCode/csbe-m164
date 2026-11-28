# Session 01: Übungen

Freiwillige Übungen ausserhalb der Unterrichtszeit.

[Zur Session](README.md)

## Einstieg

**Basis:** Welche Modellstufe erklärt den Namen Aare, welche den Typ der Raumnummer?

**Vertiefung:** Entwerfen Sie eine Belegungsprüfung ohne Daten von Gästen.

<details>
<summary>Lösung</summary>

Der Fachname hat eine fachliche Bedeutung. Die Typfestlegung ist physisch. Für den Abgleich genügen Raum, Anfang und Ende.

</details>

Für Aufgaben mit Daten: [EventStar laden](../Session%2001/Session%2001%20EventStar.sql).

Beginnen Sie mit Grundlagen: sagen Sie das Ergebnis voraus, bevor Sie eine Abfrage ausführen. Bei Anwendung vergleichen Sie Soll und Ist. Bearbeiten Sie die Vertiefung zunächst ohne Musterlösung.

## Übersicht

- [Datenmodelle lesen](#datenmodelle-lesen)

## Datenmodelle lesen

### Grundlagen

**1. Welche Aufgabe haben MySQL Server und Workbench?**

<details>
<summary>Lösung</summary>

Der Server speichert Daten und prüft Regeln. Workbench sendet Anweisungen und zeigt Ergebnisse.

</details>

**2. Ordnen Sie «Raum beherbergt Anlässe» einer Modellstufe zu.**

<details>
<summary>Lösung</summary>

Konzeptionell: Fachbegriffe und Zusammenhang, noch keine Schlüssel oder Datentypen.

</details>

**3. Ordnen Sie `raeume(raum_id, name, kapazitaet)` mit Schlüssel einer Modellstufe zu.**

<details>
<summary>Lösung</summary>

Logisch: tabellarische Struktur und Schlüssel ohne Festlegung auf ein Produkt.

</details>

**4. Ordnen Sie SMALLINT UNSIGNED und InnoDB einer Modellstufe zu.**

<details>
<summary>Lösung</summary>

Physisch: Umsetzung in MySQL.

</details>

**5. Ermitteln Sie die Serverversion und das aktive Schema.**

<details>
<summary>Lösung</summary>

```sql
SELECT VERSION() AS serverversion, DATABASE() AS schema_name;
```

Die Serverversion beginnt mit 8.4; das Schema ist eventstar_01.

</details>

### Anwendung

**6. Lesen Sie die Beziehung Raum zu Veranstaltung in beiden Richtungen.**

<details>
<summary>Lösung</summary>

Ein Raum hat null bis mehrere Veranstaltungen. Jede Veranstaltung hat genau einen Raum.

</details>

**7. Benennen Sie beide Fremdschlüssel und den Primärschlüssel einer Anmeldung.**

<details>
<summary>Lösung</summary>

Die beiden Fremdschlüssel sind veranstaltungs_id und teilnehmenden_id. Zusammen bilden sie den Primärschlüssel.

</details>

**8. Weshalb gehört der Status zur Anmeldung statt zur Person?**

<details>
<summary>Lösung</summary>

Eine Person kann gleichzeitig eine bezahlte und eine offene Anmeldung für verschiedene Veranstaltungen haben.

</details>

**9. Unterscheiden Sie Entität, Attribut und Datensatz am Raum Aare.**

<details>
<summary>Lösung</summary>

Raum ist die Entität, Name ein Attribut und Raum 10 mit Name Aare und Kapazität 36 ein Datensatz.

</details>

**10. Zeigen Sie die gespeicherten Räume in Schlüsselreihenfolge.**

<details>
<summary>Lösung</summary>

```sql
SELECT raum_id, name, kapazitaet FROM raeume ORDER BY raum_id;
```

Vier Zeilen, darunter Raum 10 Aare mit 36 Plätzen.

</details>

### Vertiefung

**11. Verfolgen Sie die Verbindung von Raum 10 zur Person 201 durch die Tabellen.**

<details>
<summary>Lösung</summary>

Raum 10 verweist über Veranstaltungen 101 und 104 auf deren Anmeldungen. Person 201 ist über (101, 201) verbunden.

</details>

**12. Welche beiden Rollen hat die Tabelle mitarbeitende im Selbstbezug?**

<details>
<summary>Lösung</summary>

Mitarbeitende sind die zugeordneten Personen. Dieselbe Tabelle liefert die vorgesetzte Person über ihren Schlüssel.

</details>

**13. Prüfen Sie die physische Definition des Raums.**

<details>
<summary>Lösung</summary>

```sql
SHOW CREATE TABLE raeume;
```

Die Ausgabe enthält unter anderem SMALLINT UNSIGNED, den Primärschlüssel und InnoDB.

</details>

**14. Beurteilen Sie, ob ein Fremdschlüssel Doppelbelegungen des Raumes verhindert.**

<details>
<summary>Lösung</summary>

Nein. Er prüft Existenz, nicht überlappende Zeiten. Mit Ende oder Dauer kann die Anwendung Überschneidungen vor der Speicherung prüfen.

</details>

**15. Welche Angaben braucht eine Liste freier Räume, und auf welche verzichten Sie?**

<details>
<summary>Lösung</summary>

Raumschlüssel und Belegungszeiten genügen. Geburtstage und E-Mail-Adressen sind für die Frage nicht nötig.

</details>
