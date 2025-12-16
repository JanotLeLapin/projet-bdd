SELECT
    s.id,
    s.nom,
    s.pays
FROM
    store s
WHERE NOT EXISTS (
    SELECT 1
    FROM application a
    JOIN restriction r ON a.id = r.id_application
    WHERE a.id_store = s.id
      AND r.limite > 16
);
