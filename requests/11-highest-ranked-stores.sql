SELECT
    s.nom AS store_name,
    AVG(e.note) AS general_avg
FROM
    store s
JOIN
    application a ON s.id = a.id_store
JOIN
    evaluer e ON a.id = e.id_application
GROUP BY
    s.id, s.nom
ORDER BY
    general_avg DESC;
