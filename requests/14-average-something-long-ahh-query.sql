SELECT
    ROUND(AVG(total_sales), 2) AS avg_sales_per_user,
    ROUND(AVG(total_refunds), 2) AS avg_refunds_per_user
FROM (
    SELECT
        buy.id_utilisateur,
        SUM(a.prix) AS total_sales,
        SUM(CASE 
                WHEN a.rembourse = 1 THEN a.prix 
                ELSE 0 
            END) AS total_refunds
    FROM
        Acheter buy
    JOIN
        Application a ON buy.id_application = a.id
    WHERE
        a.prix > 0
    GROUP BY
        buy.id_utilisateur
);
