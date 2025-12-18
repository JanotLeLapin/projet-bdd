OPTIONS (SKIP=1)
LOAD DATA
INFILE 'distribution.csv'
APPEND
INTO TABLE distribution
FIELDS TERMINATED BY ','
TRAILING NULLCOLS
(
    num,
    changelog,
    date_pub DATE "YYYY-MM-DD HH24:MI:SS",
    telechargement,
    id_application
)
