/* INSERTS */

/* 1-2 Insérer au moins 10 enregistrements par table, en s’assurant que les requêtes que vous allez
fournir dans les directives qui suivent retournent au moins un enregistrement. (4p + 4p)

Je veux aussi les scripts qui complètent les opérations suivantes: */

-- Vider les tables de la base de données :
alter table comptevotes disable constraint comptevotes_id_candidat_fk;
alter table comptevotes disable constraint comptevotes_comte_station_fk;
alter table candidat disable constraint candidat_parti_fk;
alter table codepostal disable constraint codepostal_comte_id_fk;
alter table station disable constraint station_comte_id_fk;
alter table station disable constraint station_comte_id_id_station_pk;
alter table candidat disable constraint candidat_comte_id_fk;
alter table comptevotes disable constraint comptevotes_comte_station_fk;
alter table comte disable constraint comte_province_fk;
alter table resultat_comte disable constraint resultat_comte_id_pk;
alter table resultat_comte disable constraint resultat_comte_id_candidat_fk;
TRUNCATE TABLE resultat_comte;
TRUNCATE TABLE comptevotes;
TRUNCATE TABLE candidat;
TRUNCATE TABLE partipolitque;
TRUNCATE TABLE station;
TRUNCATE TABLE codepostal;
TRUNCATE TABLE comte;
TRUNCATE TABLE province;
TRUNCATE TABLE election;
alter table comptevotes enable constraint comptevotes_id_candidat_fk;
alter table candidat enable constraint candidat_parti_fk;
alter table codepostal enable constraint codepostal_comte_id_fk;
alter table station enable constraint station_comte_id_fk;
alter table station enable constraint station_comte_id_id_station_pk;
alter table candidat enable constraint candidat_comte_id_fk;
alter table comptevotes enable constraint comptevotes_comte_station_fk;
alter table comte enable constraint comte_province_fk;
alter table comptevotes enable constraint comptevotes_comte_station_fk;
alter table resultat_comte enable constraint resultat_comte_id_pk;
alter table resultat_comte enable constraint resultat_comte_id_candidat_fk;


-- Remplir les informations avec des données de test :

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI';

-- PROVINCES/TERRITOIRES
INSERT ALL
    INTO province (abrProvince, nomProvince) VALUES ('QC', 'Quebec')
    INTO province (abrProvince, nomProvince) VALUES ('ON', 'Ontario')
    INTO province (abrProvince, nomProvince) VALUES ('MN', 'Manitoba')
    INTO province (abrProvince, nomProvince) VALUES ('CB', 'Colombie-Britannique')
    INTO province (abrProvince, nomProvince) VALUES ('SK', 'Saskatchewan')
    INTO province (abrProvince, nomProvince) VALUES ('AB', 'Alberta')
    INTO province (abrProvince, nomProvince) VALUES ('YK', 'Yukon')
    INTO province (abrProvince, nomProvince) VALUES ('TNL', 'Terre-Neuve et Labrador')
    INTO province (abrProvince, nomProvince) VALUES ('NN', 'Nunavut')
    INTO province (abrProvince, nomProvince) VALUES ('TNO', 'Territoires du Nord Ouest')
    INTO province (abrProvince, nomProvince) VALUES ('NE', 'Nouvelle Ecosse')
    INTO province (abrProvince, nomProvince) VALUES ('NB', 'Nouveau Brunswick')
    INTO province (abrProvince, nomProvince) VALUES ('IPE', 'Ile du Prince Edouard')
SELECT * FROM dual;


-- COMTE
INSERT ALL
    INTO comte(comteId, nomComte, abrProvince) VALUES (1, 'Banff—Airdrie', 'AB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (4, 'Calgary-Centre', 'AB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (14, 'Edmonton-Centre', 'AB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (27, 'Medicine Hat—Cardston—Warner', 'AB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (30, 'Red Deer—Mountain', 'AB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (57, 'North Vancouver', 'CB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (75, 'Victoria', 'CB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (78, 'Charlottetown', 'IPE')
    INTO comte(comteId, nomComte, abrProvince) VALUES (94, 'Winnipeg-Sud-Centre', 'MN')
    INTO comte(comteId, nomComte, abrProvince) VALUES (95, 'Yukon', 'YK')
    INTO comte(comteId, nomComte, abrProvince) VALUES (96, 'Acadie—Bathurst', 'NB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (102, 'Moncton—Riverview—Dieppe', 'NB')
    INTO comte(comteId, nomComte, abrProvince) VALUES (109, 'Dartmouth—Cole Harbour', 'NE')
    INTO comte(comteId, nomComte, abrProvince) VALUES (110, 'Halifax', 'NE')
    INTO comte(comteId, nomComte, abrProvince) VALUES (186, 'Niagara Falls', 'ON')
    INTO comte(comteId, nomComte, abrProvince) VALUES (193, 'Orléans', 'ON')
    INTO comte(comteId, nomComte, abrProvince) VALUES (197, 'Ottawa—Vanier', 'ON')
    INTO comte(comteId, nomComte, abrProvince) VALUES (220, 'Sudbury', 'ON')
    INTO comte(comteId, nomComte, abrProvince) VALUES (225, 'Toronto-Centre', 'ON')
    INTO comte(comteId, nomComte, abrProvince) VALUES (240, 'Abitibi—Témiscamingue', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (254, 'Brossard—Saint-Lambert', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (257, 'Chicoutimi—Le Fjord', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (263, 'Hochelaga', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (265, 'Hull—Aylmer', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (270, 'Lac-Saint-Jean', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (278, 'Longueuil—Saint-Hubert', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (285, 'Montarville', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (288, 'Mont-Royal', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (289, 'Notre-Dame-de-Grâce—Westmount', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (290, 'Outremont', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (296, 'Québec', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (302, 'Rosemont—La Petite-Patrie', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (313, 'Trois-Rivières', 'QC')
    INTO comte(comteId, nomComte, abrProvince) VALUES (322, 'Regina—Lewvan', 'SK')
    INTO comte(comteId, nomComte, abrProvince) VALUES (331, 'Avalon', 'TNL')
    INTO comte(comteId, nomComte, abrProvince) VALUES (338, 'Territoires du Nord-Ouest', 'TNO')
SELECT * FROM dual;


-- CODEPOSTAL    (pourrait être plus complet?)
INSERT ALL
    INTO codePostal (codePostal, comteId) VALUES ('K1C', 193)
    INTO codePostal (codePostal, comteId) VALUES ('K1E', 193)
    INTO codePostal (codePostal, comteId) VALUES ('K4A', 193)
    INTO codePostal (codePostal, comteId) VALUES ('K1W', 193)
    INTO codePostal (codePostal, comteId) VALUES ('H2S', 302)
    INTO codePostal (codePostal, comteId) VALUES ('H2G', 302)
    INTO codePostal (codePostal, comteId) VALUES ('H1Y', 302)
    INTO codePostal (codePostal, comteId) VALUES ('H1T', 302)
    INTO codePostal (codePostal, comteId) VALUES ('H1M', 302)
    INTO codePostal (codePostal, comteId) VALUES ('H1S', 302)
SELECT * FROM dual;


-- ELECTION
INSERT INTO election (idElection, nom, jour) VALUES (1, 'Election super normale', '2021/12/13');


-- STATIONS
INSERT ALL
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (30, 1, 'Red Deer Memorial Center', 250, TO_DATE('2021/12/07 08:30', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/07 20:30', 'YYYY/MM/DD HH24:MI'), 'Y')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (78, 1, 'Charlottetown Arena', 300, TO_DATE('2021/12/13 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 20:00', 'YYYY/MM/DD HH24:MI'), 'N')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (102, 1, 'Acadie Center', 512, TO_DATE('2021/12/07 07:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/07 20:05', 'YYYY/MM/DD HH24:MI'), 'Y')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (102, 2, 'Lobster Hall', 824, TO_DATE('2021/12/13 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 20:00', 'YYYY/MM/DD HH24:MI'), 'N')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (193, 1, 'Salle communautraire Orleans', 208, TO_DATE('2021/12/07 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/07 20:15', 'YYYY/MM/DD HH24:MI'), 'Y')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (193, 2, 'Sous-sol Eglise St-Joseph', 287, TO_DATE('2021/12/13 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 20:00', 'YYYY/MM/DD HH24:MI'), 'N')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (193, 3, 'Residence Soleil Couchant', 612, TO_DATE('2021/12/13 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 20:05', 'YYYY/MM/DD HH24:MI'), 'N')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (197, 1, 'La Vila des Six Roses', 524, TO_DATE('2021/12/13 09:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 21:00', 'YYYY/MM/DD HH24:MI'), 'N')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (197, 2, 'Vanier Hall', 398, TO_DATE('2021/12/13 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 20:00', 'YYYY/MM/DD HH24:MI'), 'N')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (254, 1, 'Resto-Bar Chez Jean-Guy', 302, TO_DATE('2021/12/13 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 21:00', 'YYYY/MM/DD HH24:MI'), 'N')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (302, 1, 'École Saint-Jean Brébeuf', 286, TO_DATE('2021/12/13 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 20:00', 'YYYY/MM/DD HH24:MI'), 'N')
    INTO station (comteid, idstation, nomstation, votesattendus, dateouverture, datefermeture, estparanticipation)
    VALUES (302, 2, 'École Ste-Bibiane', 624, TO_DATE('2021/12/13 08:00', 'YYYY/MM/DD HH24:MI'),
            TO_DATE('2021/12/13 20:00', 'YYYY/MM/DD HH24:MI'), 'N')
SELECT * FROM dual;


-- PARTIS
INSERT ALL
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti Rhinocéros', 'RH')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti de la Loi Naturelle', 'LN')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti Marijuana', 'PM')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti communiste du Canada', 'PC')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti Marxiste-Léniniste du Canada', 'ML')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti libertarien', 'PL')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti de lindépendance de New York', 'PI')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti Végétarien', 'PV')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti 51', '51')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti nul', 'PN')
    INTO partipolitque (nomParti, abbreviationParti) VALUES ('Parti royaliste du Québec', 'RQ')
SELECT * FROM dual;


-- CANDIDATS
INSERT ALL
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (1, 'Gaetan', 'Alexandre', 193, 'RH', 1000.95, 'couturier')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (2, 'Audrey', 'Gosselin', 193, 'PC', 53.75, 'mécanicienne')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (3, 'Rachel', 'Barrientos', 193, 'LN', 400000.00, 'cuisiniere')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (4, 'Émile', 'Chateaub', 193, 'PI', 1234.56, 'enseignant')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget)
        VALUES (5, 'Robert', 'Tachel', 193, 'PV', 8053.73)
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (6, 'Norris', 'Fontaine', 302, 'PV', 1975.12, 'chauffeur dautobus')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (7, 'Quennel', 'Bussière', 302, 'PL', 52464.36, 'programmeur')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (8, 'Aurélie', 'Cailot', 302, 'RQ', 354.45, 'sociologue')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget)
        VALUES (9, 'Léon', 'Covillon', 302, 'ML', 10728.25)
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (10, 'Guillaume', 'Labossière', 302, 'RH', 200.08, 'garde forestier')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (11, 'Sébastien', 'Reault', 302, 'LN', 998.53, 'auteur')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget)
        VALUES (12, 'Agnès', 'Denis', 302, 'PM', 10728.25)
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (13, 'Afrodille', 'Metivier', 302, '51', 200.08, 'patissier')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget, professionCandidat)
        VALUES (14, 'Paul-Arthur', 'Royer', 302, 'PN', 998.53, 'styliste')
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget)
        VALUES (15, 'Bernadette', 'Fréchette', 197, 'PV', 50.98)
    INTO candidat (idCandidat, prenomCandidat, nomCandidat, comteId, abbreviationParti, budget)
        VALUES (16, 'Hormidas', 'Ouipette', 197, 'RH', 1350.91)
SELECT * FROM dual;


-- CHEFS DE PARTIS
UPDATE partiPolitque SET idcandidatchef = 1 WHERE abbreviationParti = 'RH';
UPDATE partiPolitque SET idcandidatchef = 3 WHERE abbreviationParti = 'LN';
UPDATE partiPolitque SET idcandidatchef = 12 WHERE abbreviationParti = 'PM';
UPDATE partiPolitque SET idcandidatchef = 2 WHERE abbreviationParti = 'PC';
UPDATE partiPolitque SET idcandidatchef = 9 WHERE abbreviationParti = 'ML';
UPDATE partiPolitque SET idcandidatchef = 7 WHERE abbreviationParti = 'PL';
UPDATE partiPolitque SET idcandidatchef = 4 WHERE abbreviationParti = 'PI';
UPDATE partiPolitque SET idcandidatchef = 5 WHERE abbreviationParti = 'PV';
UPDATE partiPolitque SET idcandidatchef = 13 WHERE abbreviationParti = '51';
UPDATE partiPolitque SET idcandidatchef = 14 WHERE abbreviationParti = 'PN';
UPDATE partiPolitque SET idcandidatchef = 8 WHERE abbreviationParti = 'RQ';


-- COMPTE DES VOTES
INSERT ALL
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (193, 1, 1, 121)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (193, 1, 2, 3)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (193, 1, 3, 54)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (193, 1, 4, 112)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (193, 2, 2, 54)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (193, 2, 4, 124)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (193, 1, 5, 138)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (197, 1, 15, 138)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (197, 1, 16, 300)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (197, 2, 15, 200)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (197, 2, 16, 50)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (302, 1, 6, 120)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (302, 1, 5, 36)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (302, 1, 6, 215)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (302, 1, 7, 36)
    INTO comptevotes (comteId, idStation, idCandidat, nombresdevotes) VALUES (302, 1, 8, 78)
SELECT * FROM dual;


/* CONTRAINTES */

/* 8. Ajouter comme contrainte statique que le nombre de votes ne doit pas être négatif. (2p) */

ALTER TABLE comptevotes
    ADD CONSTRAINT cc_nombredevotes_positif CHECK (nombresdevotes >= 0) ENABLE;


/* 09. Ajouter comme contrainte statique que les codes postaux doivent être sous la forme A#A (5p) */

ALTER TABLE codepostal
    ADD CONSTRAINT cc_codepostal_a#a CHECK ( REGEXP_LIKE(codepostal, '^[A-Z]\d[A-Z]$') ) ENABLE;


/* PROCEDURES */

/* 10. Créer une procédure “ajout_scrutin” qui reçoit un nombre de vote pour un candidat à une station donné.
La procédure s’assure que la station n’a pas déjà envoyé ses résultats et ajoute le nombre de votes pour le candidat.
(4p) */

CREATE OR REPLACE PROCEDURE ajout_scrutin(candidat INT, conte_insert INT, station_insert INT, votes INT)
AS
    ajout station.heureenvoivotes%TYPE;
BEGIN
    SELECT heureenvoivotes
    INTO ajout
    FROM station
    WHERE idstation = station_insert
      AND comteid = conte_insert
      AND heureenvoivotes IS NULL;
    INSERT INTO comptevotes (comteid, idstation, idcandidat, nombresdevotes)
    VALUES (conte_insert, station_insert, candidat, votes);
    COMMIT;
EXCEPTION
    WHEN no_data_found
        THEN
            dbms_output.put_line('La station a déjà envoyé ses résultats');
END;
/

/*
BEGIN
    ajout_scrutin(6, 197, 1, 2);
END;
*/


/* 11. Créer une procédure “demarrer_scrutin” qui va initialiser tous les votes de tous les candidats à toutes les
stations à 0. La procédure s’assure qu’il n’y a pas de votes déjà présents dans le système. Si c’est le cas, les
informations sont supprimées. (8p). */

CREATE OR REPLACE PROCEDURE demarrer_scrutin
    IS
BEGIN
    UPDATE comptevotes
    SET nombresdevotes = 0
    WHERE nombresdevotes NOT LIKE 0;
    COMMIT;
END;
/

/*
BEGIN
    demarrer_scrutin;
END;
*/


/* 12. Créer une procédure “bulletin_abrege” qui reçoit l’identification d’un comté. La procédure affiche un bulletin
abrégé qui contient les initiales de chaque candidat avec l’abréviation du parti du candidat. (4p) */


-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


CREATE OR REPLACE PROCEDURE bulletin_abrege(comte_info INT) AS
    CURSOR select_buletin IS
        SELECT CONCAT(SUBSTR(prenomcandidat, 1, 1), SUBSTR(nomcandidat, 1, 1)) AS "Initiales du candidat",
               abbreviationparti                                               AS "Abbreviation du parti"
        FROM comte
                 NATURAL JOIN partipolitque
                 NATURAL JOIN candidat
        WHERE comteid = comte_info
        ORDER BY abbreviationparti;
BEGIN
    FOR line IN select_buletin
        LOOP
            dbms_output.put_line('Initiales du candidat' || 'Abbreviation du parti');
        END LOOP;
END;
/

/*
BEGIN
    bulletin_abrege(193);
END;
*/


/* INDEX */

/* 13. Pour améliorer les performances, créer les index suivants: (3p) */

-- Un index sur le nom des comtés.
CREATE INDEX index_nomcomte
    ON comte (nomcomte);


-- Un index sur le nom complet (prénom et nom) des candidats.
CREATE INDEX index_nom_complet
    ON candidat (prenomcandidat, nomcandidat);
