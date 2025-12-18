LOAD DATA
INFILE 'users.csv'
APPEND
INTO TABLE utilisateur
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
    pays,
    nom,
    mot_de_passe,
    email,
    date_creation DATE "YYYY-MM-DD HH24:MI:SS",
    email_valide,
    date_naissance DATE "YYYY-MM-DD HH24:MI:SS"
)
