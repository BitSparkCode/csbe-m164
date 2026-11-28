USE eventstar_import;
SELECT JSON_ARRAYAGG(JSON_OBJECT(
    'veranstaltungs_id', veranstaltungs_id,
    'teilnehmenden_id', teilnehmenden_id,
    'erfasst_am', erfasst_am,
    'status', status,
    'betrag', betrag
)) AS export_dokument
FROM anmeldungen;
