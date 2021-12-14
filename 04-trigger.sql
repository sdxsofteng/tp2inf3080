/* DECLENCHEURS */

/* 14. Créer un déclencheur qui vérifie que la date d’ouverture d’une station soit la même journée que la date de
l’élection. Cette contrainte ne doit pas être appliquée pour les stations qui font un vote par anticipation. (4p) */

CREATE OR REPLACE TRIGGER dateinvalidetrigger
    BEFORE INSERT OR UPDATE
        OF dateouverture
    ON station
    FOR EACH ROW
DECLARE
    d1 NUMBER;
    d2 NUMBER;
    a1 CHAR(1);
BEGIN
    SELECT EXTRACT(DAY FROM jour) INTO d1 FROM election;
    d2 := EXTRACT(DAY FROM :new.dateouverture);
    a1 := :new.estparanticipation;
    IF (d1 != d2) AND a1 = 'N' THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'Erreure! Impossible d avoir une station ouverte un autre jour que l election!');
    END IF;
END;
/


/* 15. Créer un déclencheur qui vérifie que le budget d’un parti ne dépasse pas 10 millions de dollars. (6p) */

CREATE OR REPLACE FUNCTION get_budget_parti(partiin candidat.abbreviationparti%TYPE) RETURN NUMBER
AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    budget_parti NUMBER;
BEGIN
    SELECT SUM(budget) INTO budget_parti FROM candidat WHERE partiin = candidat.abbreviationparti;
    RETURN budget_parti;
END get_budget_parti;

CREATE OR REPLACE TRIGGER budgetmaxtrigger
    BEFORE INSERT OR UPDATE
        OF budget
    ON candidat
    FOR EACH ROW
DECLARE
    budget_total   NUMBER;
    nouveau_budget NUMBER;
    partiin        partipolitque.abbreviationparti%TYPE;
BEGIN
    partiin := :new.abbreviationparti;
    nouveau_budget := :new.budget;

    budget_total := get_budget_parti(partiin);

    IF (nouveau_budget + budget_total) > 10000000 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Le budget par parti ne peut pas depasser 10 millions de dollards');
    END IF;
END;
/

/*
INSERT INTO candidat (idcandidat, prenomcandidat, nomcandidat, comteid, abbreviationparti, budget)
VALUES (20, 'Chuck', 'Norris', 30, 'PC', 9999990.00);
COMMIT;
*/


/* 16. Créer un déclencheur qui vérifie que chaque comté ne peut pas avoir plus qu’un candidat du même parti. (6p) */

CREATE OR REPLACE TRIGGER deuxcandidatstrigger
    FOR INSERT OR UPDATE
    ON candidat COMPOUND TRIGGER
    partiin partipolitque.abbreviationparti%TYPE;
    comtein INTEGER;
    line_count INTEGER;

AFTER EACH ROW IS
BEGIN
    partiin := :new.abbreviationparti;
    comtein := :new.comteid;
END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        SELECT COUNT(*) INTO line_count FROM candidat WHERE abbreviationparti = partiin AND comteid = comtein;
        IF line_count > 1 THEN
            RAISE_APPLICATION_ERROR(-20003,
                                    'Il ne peut pas y avoir deux candidat pour le meme parti dans le meme comte');
        END IF;
    END AFTER STATEMENT;
    END deuxcandidatstrigger;
/

/*
INSERT INTO candidat (idcandidat, prenomcandidat, nomcandidat, comteid, abbreviationparti, budget)
    VALUES (95, 'Phil', 'Collins', 1, 'RH', 150.98);
INSERT INTO candidat (idcandidat, prenomcandidat, nomcandidat, comteid, abbreviationparti, budget)
    VALUES (96, 'David', 'Bowie', 1, 'RH', 350.91);
COMMIT;
*/


/* 17. Créer un déclencheur qui vérifie que la date d’envoi d’une station soit après la date de fermeture de la station.
(2p) */

CREATE OR REPLACE TRIGGER dateenvoitrigger
    BEFORE INSERT OR UPDATE
    ON station
    FOR EACH ROW
DECLARE
    dtfermeture DATE;
    dtenvoi     DATE;
BEGIN
    dtfermeture := :old.datefermeture;
    dtenvoi := :new.heureenvoivotes;
    IF dtfermeture > dtenvoi THEN
        RAISE_APPLICATION_ERROR(-20004, 'La date d envoi ne peut etre avant la fermeture');
    END IF;
END;
/


/* 18. Créer un déclencheur qui insère dans une table “resultat_comte” les élus de chaque comté. L’élu est choisi quand
toutes les stations d’un comté ont envoyé leurs votes. (10p) */

CREATE OR REPLACE TRIGGER resultat_comte
    FOR UPDATE OF heureenvoivotes
    ON station COMPOUND TRIGGER
    comtein INTEGER;
    pasenvoye INTEGER;
    gagnant INTEGER;
AFTER EACH ROW IS
BEGIN
    comtein := :new.comteid;
END AFTER EACH ROW;

AFTER STATEMENT IS
BEGIN
    SELECT COUNT(*)
    INTO pasenvoye
    FROM comte
        NATURAL JOIN station
    WHERE comteid = comtein
      AND heureenvoivotes IS NULL;
    IF pasenvoye LIKE 0 THEN
        SELECT idcandidat
        INTO gagnant
        FROM (
            SELECT idcandidat, SUM(nombresdevotes) AS votes
            FROM comptevotes
            GROUP BY idcandidat
            ORDER BY votes DESC)
        WHERE rownum = 1;
        INSERT INTO resultat_comte (comteid, idcandidat) VALUES (comtein, gagnant);
    END IF;
END AFTER STATEMENT;
END resultat_comte;
/

/*
UPDATE station set heureenvoivotes = TO_DATE('2021/12/15 01:02', 'YYYY/MM/DD HH24:MI') WHERE comteid = 193;
 */
