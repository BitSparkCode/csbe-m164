<img src="csbe-logo.jpeg" alt="CsBe ICT Ausbildungszentrum Bern" width="180">

# Modul 164: Datenbanken erstellen und Daten einfügen

BIS26, Moritz Maier, MySQL 8.4 oder MariaDB 11.4 LTS

Im Kurs arbeiten wir mit MySQL Workbench; andere Clients sind frei wählbar, der Support ist eventuell eingeschränkt.

## Lernzielstufen

📌 Erinnern, 💡 Verstehen, 🛠️ Anwenden, 🔍 Analysieren, ⚖️ Beurteilen, 🏗️ Erschaffen

## Handlungsziele

1. Ein logisches relationales Datenmodell lesen.
2. Das Modell in einer relationalen Datenbank umsetzen.
3. Referenzielle Integrität mit Tabellenregeln sicherstellen.
4. Daten mit SQL einfügen.
5. Daten aus Dateien oder Tabellen importieren.
6. Daten auf Vollständigkeit und Richtigkeit prüfen.
7. Fehlerhafte und unvollständige Daten korrigieren.

## Sessions

Vier Lektionen pro Session. Die Arbeitsblätter lassen sich in Word ausfüllen.

| Session | Termin | Unterricht | Themen und Lernziele | Übungen |
|---|---|---|---|---|
| [Session 01](Session%2001/README.md) | DI<br>24.11.2026<br>18:00–21:15 | SOL | [💡](#lernzielstufen "Verstehen") [Modellstufen](Session%2001/Session%2001%20Theorie.md#modellstufen)<br>[💡](#lernzielstufen "Verstehen") [Kardinalität](Session%2001/Session%2001%20Theorie.md#raum-und-anlass)<br>[🛠️](#lernzielstufen "Anwenden") [Verbindung](Session%2001/Session%2001%20Theorie.md#installation-und-verbindung)<br>[🔍](#lernzielstufen "Analysieren") [Speicher-Engines](Session%2001/Session%2001%20Theorie.md#engine-vergleich)<br>[⚖️](#lernzielstufen "Beurteilen") [Modellgrenze](Session%2001/Session%2001%20Theorie.md#raum-und-anlass) | [Übungen](Session%2001/Session%2001%20%C3%9Cbungen.md) |
| [Session 02](Session%2002/README.md) | DO<br>26.11.2026<br>18:00–21:15 | Remote | [💡](#lernzielstufen "Verstehen") [Datenbankstruktur](Session%2002/Session%2002%20Theorie.md#schema-und-tabellen)<br>[🛠️](#lernzielstufen "Anwenden") [Datentypen](Session%2002/Session%2002%20Theorie.md#mysql-datentypen)<br>[🛠️](#lernzielstufen "Anwenden") [Tabellenerstellung](Session%2002/Session%2002%20Theorie.md#aufbau-von-create-table)<br>[🔍](#lernzielstufen "Analysieren") [Serverdefinition](Session%2002/Session%2002%20Theorie.md#tabellen%C3%A4nderung) | [Übungen](Session%2002/Session%2002%20%C3%9Cbungen.md) |
| [Session 03](Session%2003/README.md) | SA<br>28.11.2026<br>08:30–12:00 | CsBe | [💡](#lernzielstufen "Verstehen") [Schlüssel und Kardinalität](Session%2003/Session%2003%20Theorie.md#beziehungen-und-schl%C3%BCssel)<br>[🛠️](#lernzielstufen "Anwenden") [Beziehungen](Session%2003/Session%2003%20Theorie.md#selbstbezug)<br>[🔍](#lernzielstufen "Analysieren") [Datenregeln](Session%2003/Session%2003%20Theorie.md#datenregeln-und-fehler)<br>[🔍](#lernzielstufen "Analysieren") [Normalformen](Session%2003/Session%2003%20Theorie.md#normalisierung) | [Übungen](Session%2003/Session%2003%20%C3%9Cbungen.md) |
| [Session 04](Session%2004/README.md) | SA<br>28.11.2026<br>13:00–16:15 | CsBe | [💡](#lernzielstufen "Verstehen") [Struktur und Daten](Session%2004/Session%2004%20Theorie.md#zielzeilen)<br>[🛠️](#lernzielstufen "Anwenden") [Zeilenänderungen](Session%2004/Session%2004%20Theorie.md#insert-update-delete)<br>[🛠️](#lernzielstufen "Anwenden") [Transaktion](Session%2004/Session%2004%20Theorie.md#%C3%A4nderungsprobe)<br>[🔍](#lernzielstufen "Analysieren") [Referenzaktionen](Session%2004/Session%2004%20Theorie.md#referenzielle-integrit%C3%A4t) | [Übungen](Session%2004/Session%2004%20%C3%9Cbungen.md) |
| [Session 05](Session%2005/README.md) | DI<br>01.12.2026<br>18:00–21:15 | SOL | [💡](#lernzielstufen "Verstehen") [Sicherung und Austausch](Session%2005/Session%2005%20Theorie.md#sicherung)<br>[🛠️](#lernzielstufen "Anwenden") [Wiederherstellung](Session%2005/Session%2005%20Theorie.md#dump-und-arbeitskopie)<br>[🛠️](#lernzielstufen "Anwenden") [Rohdatenimport](Session%2005/Session%2005%20Theorie.md#rohdatenpr%C3%BCfung)<br>[🔍](#lernzielstufen "Analysieren") [Bestandsabgleich](Session%2005/Session%2005%20Theorie.md#%C3%BCbernahme-und-export) | [Übungen](Session%2005/Session%2005%20%C3%9Cbungen.md) |
| [Session 06](Session%2006/README.md) | DO<br>03.12.2026<br>18:00–21:15 | Remote | [🛠️](#lernzielstufen "Anwenden") [Auswahl und Sortierung](Session%2006/Session%2006%20Theorie.md#auswahl-und-sortierung)<br>[🛠️](#lernzielstufen "Anwenden") [Filter](Session%2006/Session%2006%20Theorie.md#textfilter-und-sortierung)<br>[🔍](#lernzielstufen "Analysieren") [Gruppierung](Session%2006/Session%2006%20Theorie.md#gruppierte-auswertung)<br>[⚖️](#lernzielstufen "Beurteilen") [Kennzahlen](Session%2006/Session%2006%20Theorie.md#nullwerte-und-z%C3%A4hlung) | [Übungen](Session%2006/Session%2006%20%C3%9Cbungen.md) |
| [Session 07](Session%2007/README.md) | SA<br>05.12.2026<br>08:30–12:00 | CsBe | [🛠️](#lernzielstufen "Anwenden") [Tabellenverbindung](Session%2007/Session%2007%20Theorie.md#tabellenverbindungen)<br>[🛠️](#lernzielstufen "Anwenden") [Korrektur](Session%2007/Session%2007%20Theorie.md#hash-und-korrektur)<br>[🔍](#lernzielstufen "Analysieren") [Filterplatzierung](Session%2007/Session%2007%20Theorie.md#on-und-where)<br>[🔍](#lernzielstufen "Analysieren") [Bestandsprüfung](Session%2007/Session%2007%20Theorie.md#bestandspr%C3%BCfung-und-korrektur) | [Übungen](Session%2007/Session%2007%20%C3%9Cbungen.md); 🔎 [Datenkrimi](Session%2007/Session%2007%20Datenkrimi.md) |
| [Session 08](Session%2008/README.md) | SA<br>05.12.2026<br>13:00–16:15 | SOL | [💡](#lernzielstufen "Verstehen") [Fachmodell](Session%2008/Session%2008%20Theorie.md#modell-und-schl%C3%BCssel)<br>[🛠️](#lernzielstufen "Anwenden") [Regeltest](Session%2008/Session%2008%20Theorie.md#schl%C3%BCsselpaar)<br>[🛠️](#lernzielstufen "Anwenden") [Datenübernahme](Session%2008/Session%2008%20Theorie.md#importpr%C3%BCfung)<br>[⚖️](#lernzielstufen "Beurteilen") [Selbstkorrektur](Session%2008/Session%2008%20Theorie.md#korrektur-und-nachweis) | [Übungen](Session%2008/Session%2008%20%C3%9Cbungen.md) |
| [Session 09](Session%2009/README.md) | SA<br>12.12.2026<br>08:30–12:00 | CsBe | [🛠️](#lernzielstufen "Anwenden") [Tabellenregeln](Session%2009/Session%2009%20Theorie.md#einsatzmodell)<br>[🛠️](#lernzielstufen "Anwenden") [Rohdaten](Session%2009/Session%2009%20Theorie.md#import-und-integrit%C3%A4t)<br>[🛠️](#lernzielstufen "Anwenden") [Auswertung](Session%2009/Session%2009%20Theorie.md#kennzahlen)<br>[🔍](#lernzielstufen "Analysieren") [Korrekturbeleg](Session%2009/Session%2009%20Theorie.md#gezielte-korrektur)<br>[🏗️](#lernzielstufen "Erschaffen") [Helfereinsätze](Session%2009/Session%2009%20Theorie.md#modellierung) | [Übungen](Session%2009/Session%2009%20%C3%9Cbungen.md) |
