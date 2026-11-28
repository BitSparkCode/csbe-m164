USE eventstar_import;
SELECT 'veranstaltungs_id;teilnehmenden_id;erfasst_am;status;betrag' AS csv_zeile;
SELECT CONCAT_WS(';', veranstaltungs_id, teilnehmenden_id, erfasst_am, status, betrag)
FROM anmeldungen ORDER BY veranstaltungs_id, teilnehmenden_id;
