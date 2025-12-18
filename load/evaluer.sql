OPTIONS (SKIP=1)
LOAD DATA
INFILE 'evaluer.csv'
APPEND
INTO TABLE evaluer
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
    id_utilisateur,
    id_application,
    titre,
    contenu,
    date_publi DATE "YYYY-MM-DD HH24:MI:SS",
    note
)
