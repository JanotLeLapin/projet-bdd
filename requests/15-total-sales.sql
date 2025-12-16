SELECT
    a.nom AS app_name,
    p.libelle AS plateform,
    SUM(a.prix) AS total_revenue,
    COUNT(buy.id_utilisateur) AS sale_count
FROM
    application a
JOIN
    acheter buy ON a.id = buy.id_application
JOIN
    plateforme p ON buy.id_plateforme = p.id
GROUP BY
    a.nom, p.libelle;
