WITH stats_per_store AS (
    SELECT
        s.pays,
        s.nom AS store_name,
        AVG(d.telechargement) as avg_downloads
    FROM
        store s
    JOIN
        application a ON s.id = a.id_store
    JOIN
        distribution d ON a.id = d.id_application
    GROUP BY
        s.id, s.nom, s.pays
),
rank_per_country AS (
    SELECT
        pays,
        store_name,
        avg_downloads,
        RANK() OVER (PARTITION BY pays ORDER BY avg_downloads DESC) as rank
    FROM
        stats_per_store
)
SELECT
    pays,
    store_name,
    avg_downloads
FROM
    rank_per_country
WHERE
    rank = 1;
