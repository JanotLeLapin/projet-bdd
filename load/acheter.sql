OPTIONS (SKIP=1)
LOAD DATA
INFILE 'acheter.csv'
APPEND
INTO TABLE acheter
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
    date_achat DATE "YYYY-MM-DD HH24:MI:SS",
    rembourse,
    id_utilisateur,
    id_application,
    id_plateforme
)
