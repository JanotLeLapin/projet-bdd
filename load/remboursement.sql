OPTIONS (SKIP=1)
LOAD DATA
INFILE 'remboursement.csv'
APPEND
INTO TABLE remboursement
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
    id,
    id_utilisateur,
    id_application,
    date_emission DATE "YYYY-MM-DD HH24:MI:SS",
    motif,
    status
)
