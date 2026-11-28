# Session 07: Datenkrimi bei EventStar

**Freiwilliger Bonus, etwa 25 Minuten.** Zwei Beträge wurden nach dem Kassenabgleich verändert. Trotzdem stimmen die Zahl der Anmeldungen und der Gesamtbetrag. Wer hat die Beträge geändert, und welche zwei Werte müssen wiederhergestellt werden?

Öffnen Sie [Session 07 Datenkrimi.sql](Session%2007%20Datenkrimi.sql) in Workbench und führen Sie die Datei lokal aus. Sie baut den Fall im eigenen Schema `eventstar_krimi` auf. Lesen Sie die Hinweise der Reihe nach. [Zur Session](README.md)

## 1. Etwas stimmt nicht

Vergleichen Sie `anmeldungen` und `anmeldungen_referenz`: einmal nach Anzahl und Summe, einmal nach SHA-256 über alle Schlüssel und Beträge. Vor dem Hash die Zeilen gleich sortieren. Schreiben Sie zuerst auf, was zwei gleiche Summen beweisen und was nicht.

**Starthilfe:** Verwenden Sie dieselbe Reihenfolge und Trennung in beiden Abfragen:

```sql
SELECT SHA2(GROUP_CONCAT(
    CONCAT_WS(':', anlass_id, teilnehmenden_id, betrag)
    ORDER BY anlass_id, teilnehmenden_id SEPARATOR ';'
), 256) AS pruefwert
FROM anmeldungen_referenz;
```

## 2. Zwei Schlüsselteile, zwei Spuren

Verbinden Sie beide Bestände über das **ganze Schlüsselpaar**. Geben Sie nur Paare mit unterschiedlichem Betrag und beide Werte aus. Wenn mehr als zwei Paare erscheinen, kontrollieren Sie zuerst die Verknüpfung.

**Weniger Hilfe:** Beginnen Sie mit `JOIN anmeldungen_referenz USING (...)`. Ergänzen Sie selbst die Schlüssel und die Filterbedingung.

## 3. Das Zeitfenster schliesst sich

Die verdächtigen Einträge stammen vom 4. Dezember 2026 von 21:00 bis vor 21:10 Uhr. Suchen Sie im `aenderungsprotokoll` nur Einträge zu den abweichenden Paaren, deren protokollierter Betrag dem aktuellen entspricht. Eine Unterabfrage mit `EXISTS` kann die Kandidaten begrenzen. Gruppieren Sie nach Person und filtern Sie auf **zwei verschiedene Paare**. Verbinden Sie das Ergebnis mit `mitarbeitende` und ermitteln Sie mit einem Selbstbezug auch die zugehörige Leitung.

**Prüfen Sie Ihre Spur:** Mehrere Einträge im Zeitfenster genügen nicht. Die Person muss mit genau den beiden abweichenden Paaren und ihren aktuellen Beträgen verbunden sein.

## 4. Kontrolle und freiwillige Korrektur

Setzen Sie in der folgenden Abfrage den vollständigen Namen aus Ihrem Ergebnis ein. `1` bestätigt Ihre Lösung.

```sql
SELECT SHA2('NAME EINSETZEN', 256) =
    '008e4c5acd051fe865334c67b99f6c54af884d1cb0cc13a404f5b0e1a132a24e' AS fall_geloest;
```

**Vertiefung:** Stellen Sie die zwei Referenzbeträge in einer Transaktion wieder her. Vergleichen Sie den Hash erneut und nehmen Sie die Änderungen mit ROLLBACK zurück. Belegen Sie, dass der Versuch keine Daten dauerhaft ändert.
