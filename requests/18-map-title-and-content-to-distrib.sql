WITH distrib_periods AS (
    SELECT
        id_application,
        num,
        changelog,
        date_publi AS start_date,
        LEAD(date_publi, 1, SYSDATE) OVER (
            PARTITION BY id_application 
            ORDER BY date_publi ASC
        ) AS end_date
    FROM
        Distribution
)
SELECT
    a.nom AS app_name,
    d.num AS target_version,
    e.titre,
    e.contenu,
    e.date_publi AS comment_date
FROM
    Evaluer e
JOIN
    Application a ON e.id_application = a.id
JOIN
    distrib_periods d ON e.id_application = d.id_application
WHERE
    e.titre IS NOT NULL 
    AND e.contenu IS NOT NULL
    AND e.date_publi >= d.start_date
    AND e.date_publi < d.end_date
ORDER BY
    a.nom, e.date_publi DESC;
