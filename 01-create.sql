CREATE TABLE election
(
    idelection INTEGER PRIMARY KEY,
    nom        VARCHAR(200),
    jour       DATE
);
CREATE TABLE province
(
    abrprovince VARCHAR(3)  NOT NULL
        CONSTRAINT province_pk
            PRIMARY KEY,
    nomprovince VARCHAR(50) NOT NULL

);
CREATE TABLE comte
(
    comteid     INTEGER     NOT NULL
        CONSTRAINT compte_pk
            PRIMARY KEY,
    nomcomte    VARCHAR(60) NOT NULL,
    abrprovince VARCHAR(3)  NOT NULL
        CONSTRAINT comte_province_fk
            REFERENCES province
);
CREATE TABLE codepostal
(
    codepostal VARCHAR(3) NOT NULL
        CONSTRAINT codepostal_pk
            PRIMARY KEY,
    comteid    INTEGER    NOT NULL
        CONSTRAINT codepostal_comte_id_fk
            REFERENCES comte
);
CREATE TABLE station
(
    comteid            INTEGER             NOT NULL
        CONSTRAINT station_comte_id_fk
            REFERENCES comte,
    idstation          INTEGER             NOT NULL,
    nomstation         VARCHAR(255)        NOT NULL,
    votesattendus      INTEGER             NOT NULL,
    dateouverture      DATE                NOT NULL,
    datefermeture      DATE                NOT NULL,
    heureenvoivotes    DATE,
    estparanticipation CHAR(1) DEFAULT '0' NOT NULL,
    CONSTRAINT station_comte_id_id_station_pk
        PRIMARY KEY (comteid, idstation)
);
CREATE TABLE partipolitque
(
    nomparti          VARCHAR(255)            NOT NULL,
    abbreviationparti VARCHAR(10) PRIMARY KEY NOT NULL,
    idcandidatchef    INTEGER
);
CREATE TABLE candidat
(
    idcandidat         INTEGER PRIMARY KEY NOT NULL,
    abbreviationparti  VARCHAR(10)         NOT NULL
        CONSTRAINT candidat_parti_fk
            REFERENCES partipolitque,
    comteid            INTEGER             NOT NULL
        CONSTRAINT candidat_comte_id_fk
            REFERENCES comte,
    prenomcandidat     VARCHAR(50)         NOT NULL,
    nomcandidat        VARCHAR(50)         NOT NULL,
    professioncandidat VARCHAR(255),
    budget             NUMBER(10, 2)       NOT NULL
);
CREATE TABLE comptevotes
(
    nombresdevotes INTEGER NOT NULL,
    idcandidat     INTEGER NOT NULL
        CONSTRAINT comptevotes_id_candidat_fk
            REFERENCES candidat,
    idstation      INTEGER NOT NULL,
    comteid        INTEGER NOT NULL,
    CONSTRAINT comptevotes_comte_station_fk
        FOREIGN KEY (comteid, idstation) REFERENCES station
);
CREATE TABLE resultat_comte
(
    comteid    INTEGER PRIMARY KEY NOT NULL
        CONSTRAINT resultat_comte_id_pk
            REFERENCES comte,
    idcandidat INTEGER             NOT NULL
        CONSTRAINT resultat_comte_id_candidat_fk
            REFERENCES candidat
);
