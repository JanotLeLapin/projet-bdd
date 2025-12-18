OPTIONS (SKIP=1)
LOAD DATA
INFILE 'stores.csv'
APPEND
INTO TABLE store
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
    email,
    pays,
    date_ouverture DATE "YYYY-MM-DD HH24:MI:SS",
    nom,
    id_gestionnaire
)
