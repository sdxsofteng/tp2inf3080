/* VUES */

/* 3. Créer une vue (budget_parti) qui indique le budget de chaque parti. On doit indiquer le total des budgets par
parti et la moyenne par candidats par parti. (4p) */

CREATE OR REPLACE VIEW budget_parti AS
SELECT partipolitque.nomparti,
       SUM(candidat.budget)           AS budget_total,
       ROUND(AVG(candidat.budget), 2) AS budget_moyen
FROM partipolitque
         NATURAL JOIN candidat
GROUP BY partipolitque.nomparti
ORDER BY partipolitque.nomparti
;


/* 4. Créer une vue (station_ouverte) qui indique le nombre de stations ouvertes par comté. (4p) */

CREATE OR REPLACE VIEW station_ouverte AS
SELECT nomcomte, COUNT(*) AS nombre_stations
FROM comte
         NATURAL JOIN station
WHERE estparanticipation = 'N'
  AND heureenvoivotes is null
GROUP BY nomcomte
ORDER BY nomcomte
;


/* 5. Créer une vue (probabilite_candidat) qui indique la probabilité qu’un candidat d’un parti se présente dans un
comté. La probabilité est calculée en trouvant le nombre de candidats d’un parti sur le nombre de comtés total
de l’élection. (3p) */

CREATE OR REPLACE VIEW probabilite_candidat AS
SELECT partipolitque.nomparti, ROUND(COUNT(*) / (SELECT COUNT(comte.comteid) FROM comte), 3) AS probabilite
FROM partipolitque
         NATURAL JOIN candidat
         NATURAL JOIN comte
GROUP BY partipolitque.nomparti
ORDER BY probabilite DESC
;


/* 6. Créer une vue (votes_candidats) qui indique le nombre de votes pour chaque candidat. Les candidats doivent
être triés par parti et ensuite par nom. (6p) */

CREATE OR REPLACE VIEW votes_candidats AS
SELECT nomparti, nomcandidat, prenomcandidat, SUM(nombresdevotes) AS "Nombre de votes"
FROM candidat
         NATURAL JOIN comptevotes
         NATURAL JOIN partipolitque
GROUP BY (nomcandidat, prenomcandidat, nomparti)
ORDER BY nomparti, nomcandidat, prenomcandidat
;


/* 7. Créer une vue (info_province) qui indique pour chaque province le nombre de candidats de chaque parti et le
nombre de votes de chaque parti pour la province. (4p) */

CREATE OR REPLACE VIEW info_province AS
SELECT nomprovince,
       partipolitque.nomparti,
       COUNT(DISTINCT candidat.idcandidat)     AS "Candidats dans la province",
       SUM(NVL(comptevotes.nombresdevotes, 0)) AS "Nombres de votes"
FROM candidat
         LEFT JOIN comptevotes ON candidat.idcandidat = comptevotes.idcandidat
         RIGHT JOIN partipolitque ON candidat.abbreviationparti = partipolitque.abbreviationparti
         LEFT JOIN comte ON candidat.comteid = comte.comteid
         RIGHT JOIN province p ON comte.abrprovince = p.abrprovince
GROUP BY nomprovince, partipolitque.nomparti
ORDER BY nomprovince, partipolitque.nomparti
;

