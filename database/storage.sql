DROP SCHEMA IF EXISTS skeetpro;
CREATE SCHEMA IF NOT EXISTS skeetpro;
USE skeetpro;

CREATE TABLE Cliente (
    CF           VARCHAR(16)  PRIMARY KEY,
    Nome         VARCHAR(50)  NOT NULL,
    Cognome      VARCHAR(50)  NOT NULL,
    Email        VARCHAR(100) NOT NULL UNIQUE,
    Password     VARCHAR(255) NOT NULL,
    TipoCliente  ENUM('Socio', 'Temporaneo') NOT NULL
);

CREATE TABLE Socio (
    CF        VARCHAR(16) PRIMARY KEY,
    DataIscr  DATE        NOT NULL,
    N_Tessera VARCHAR(20) NOT NULL UNIQUE,
    Stato     ENUM('Attivo', 'Sospeso', 'Scaduto') NOT NULL DEFAULT 'Attivo',
    FOREIGN KEY (CF) REFERENCES Cliente(CF)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PortoArmi (
    NumLic   VARCHAR(20) PRIMARY KEY,
    Scadenza DATE        NOT NULL,
    SocioCF  VARCHAR(16) NOT NULL UNIQUE,
    FOREIGN KEY (SocioCF) REFERENCES Socio(CF)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admin (
    Username VARCHAR(50)  PRIMARY KEY,
    Password VARCHAR(255) NOT NULL
);

CREATE TABLE Campo (
    ID         INT PRIMARY KEY AUTO_INCREMENT,
    Disciplina ENUM('Trap', 'Skeet', 'Sporting') NOT NULL
);

CREATE TABLE Prenotazione (
    Codice        INT         PRIMARY KEY AUTO_INCREMENT,
    Data          DATE        NOT NULL,
    FasciaOraria  TIME        NOT NULL,
    CampoID       INT         NOT NULL,
    ClienteCF     VARCHAR(16) NOT NULL,
    FOREIGN KEY (ClienteCF) REFERENCES Cliente(CF)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (CampoID) REFERENCES Campo(ID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE (CampoID, Data, FasciaOraria)
);

CREATE TABLE Sessione (
    ID                 INT PRIMARY KEY AUTO_INCREMENT,
    Punteggio          INT NULL,
    PrenotazioneCodice INT NOT NULL UNIQUE,
    FOREIGN KEY (PrenotazioneCodice) REFERENCES Prenotazione(Codice)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Arma (
    Matricola      VARCHAR(20)  PRIMARY KEY,
    Modello        VARCHAR(50)  NOT NULL,
    Calibro        VARCHAR(10)  NOT NULL,
    Descrizione    TEXT         NULL,
    Foto           LONGBLOB     NULL,
    PrezzoNoleggio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Attiva         BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE Munizioni (
    Lotto       VARCHAR(20) PRIMARY KEY,
    Calibro     VARCHAR(10) NOT NULL,
    Marca       VARCHAR(50) NOT NULL,
    Descrizione TEXT        NULL,
    Foto        LONGBLOB    NULL,
    Prezzo      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Attiva      BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Dotata (
    ArmaMatricola  VARCHAR(20) NOT NULL,
    MunizioniLotto VARCHAR(20) NOT NULL,
    PRIMARY KEY (ArmaMatricola, MunizioniLotto),
    FOREIGN KEY (ArmaMatricola)  REFERENCES Arma(Matricola)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (MunizioniLotto) REFERENCES Munizioni(Lotto)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Ordine (
    Codice    INT PRIMARY KEY AUTO_INCREMENT,
    Data      DATETIME NOT NULL,
    Stato     ENUM('Da Ritirare', 'Ritirato', 'Annullato') NOT NULL DEFAULT 'Da Ritirare',
    ClienteCF VARCHAR(16) NOT NULL,
    FOREIGN KEY (ClienteCF) REFERENCES Cliente(CF)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE RigaOrdine (
    OrdineCodice INT NOT NULL,
    IDProdotto   VARCHAR(20) NOT NULL, -- Matricola Arma, Lotto Munizione o Codice Prenotazione
    TipoProdotto ENUM('Arma', 'Munizione', 'Sessione') NOT NULL,
    Prezzo       DECIMAL(10,2) NOT NULL, -- Prezzo congelato al momento dell'acquisto
    Quantita     INT NOT NULL,
    Durata       INT NULL, -- Per le ore di noleggio armi
    PRIMARY KEY (OrdineCodice, IDProdotto, TipoProdotto),
    FOREIGN KEY (OrdineCodice) REFERENCES Ordine(Codice)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Gara (
    ID_Gara INT  PRIMARY KEY AUTO_INCREMENT,
    Data    DATE NOT NULL
);

CREATE TABLE Partecipa (
    ClienteCF VARCHAR(16) NOT NULL,
    GaraID    INT         NOT NULL,
    Risultato INT         NULL,
    PRIMARY KEY (ClienteCF, GaraID),
    FOREIGN KEY (ClienteCF) REFERENCES Cliente(CF)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (GaraID) REFERENCES Gara(ID_Gara)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


-- -----------------------------------------------
-- Dati di test
-- -----------------------------------------------

INSERT INTO Admin VALUES ('admin', 'admin123');

INSERT INTO Cliente VALUES
('RSSMRA80A01H501A', 'Mario',  'Rossi',   'mario.rossi@email.it',    'pass123', 'Socio'),
('VRDLGU75B02H501B', 'Luigi',  'Verdi',   'luigi.verdi@email.it',    'pass123', 'Socio'),
('BNCGLI90C03H501C', 'Giulia', 'Bianchi', 'giulia.bianchi@email.it', 'pass123', 'Temporaneo');

INSERT INTO Socio VALUES
('RSSMRA80A01H501A', '2020-01-10', 'TESS-0001', 'Attivo'),
('VRDLGU75B02H501B', '2019-05-15', 'TESS-0002', 'Attivo');

INSERT INTO PortoArmi VALUES
('LIC-987654', '2027-03-15', 'RSSMRA80A01H501A'),
('LIC-123456', '2028-10-20', 'VRDLGU75B02H501B');

INSERT INTO Campo (Disciplina) VALUES
('Skeet'),
('Trap'),
('Sporting');

INSERT INTO Arma VALUES
('MAT-001', 'Beretta DT11 Black Edition', 'Cal. 12', 'Fucile sovrapposto da competizione ideale per il Trap.', NULL, 25.00, TRUE),
('MAT-002', 'Perazzi High Tech',          'Cal. 12', 'Un classico per i veri tiratori professionisti.', NULL, 20.00, TRUE),
('MAT-003', 'Browning B725 Sporter',      'Cal. 12', 'Fucile bilanciato e maneggevole per lo Sporting.', NULL, 15.00, TRUE),
('MAT-004', 'Beretta 694 Sporting',       'Cal. 12', 'Ottimo fucile progettato specificamente per il percorso di caccia e lo Sporting.', NULL, 18.00, TRUE),
('MAT-005', 'Browning Cynergy',           'Cal. 12', 'Design moderno e bilanciamento perfetto per risultati di alto livello.', NULL, 16.00, TRUE),
('MAT-006', 'Fabarm Elos N2 Sporting',    'Cal. 12', 'Fucile maneggevole ed entry-level, ideale per chi si avvicina al tiro a volo.', NULL, 12.00, TRUE);

INSERT INTO Munizioni VALUES
('LOT-C12-24G',  'Cal. 12', 'Fiocchi',       'Cartucce da 24 grammi, piombo 7.5 per il Trap.', NULL, 8.50, TRUE),
('LOT-C12-28G',  'Cal. 12', 'Baschieri',     'Cartucce da 28 grammi, perfette per lo Sporting e Skeet.', NULL, 9.00, TRUE),
('LOT-C12-24RC', 'Cal. 12', 'RC Cartridges', 'RC4 Champion Excellence da 24g. Elevata regolarità di rosata.', NULL, 10.50, TRUE);

INSERT INTO Dotata VALUES
('MAT-001', 'LOT-C12-24G'),
('MAT-001', 'LOT-C12-28G'),
('MAT-001', 'LOT-C12-24RC'),
('MAT-002', 'LOT-C12-24G'),
('MAT-002', 'LOT-C12-24RC'),
('MAT-003', 'LOT-C12-28G'),
('MAT-004', 'LOT-C12-28G'),
('MAT-005', 'LOT-C12-24G'),
('MAT-006', 'LOT-C12-28G');

INSERT INTO Prenotazione (Data, FasciaOraria, CampoID, ClienteCF) VALUES
('2026-03-01', '10:00:00', 1, 'RSSMRA80A01H501A'),
('2026-03-02', '11:00:00', 2, 'BNCGLI90C03H501C'),
('2025-05-01', '09:00:00', 1, 'VRDLGU75B02H501B'),
('2026-03-05', '15:00:00', 1, 'RSSMRA80A01H501A');

INSERT INTO Sessione (Punteggio, PrenotazioneCodice) VALUES
(95, 1),
(80, 2),
(75, 3),
(88, 4);

INSERT INTO Ordine (Codice, Data, Stato, ClienteCF) VALUES
(1, '2026-03-01 10:00:00', 'Ritirato', 'RSSMRA80A01H501A'),
(2, '2026-03-02 11:00:00', 'Da Ritirare', 'RSSMRA80A01H501A');

INSERT INTO RigaOrdine (OrdineCodice, IDProdotto, TipoProdotto, Prezzo, Quantita, Durata) VALUES
(1, 'MAT-001', 'Arma', 15.00, 1, 2),
(1, 'LOT-C12-24G', 'Munizione', 8.50, 250, NULL),
(2, 'MAT-002', 'Arma', 20.00, 1, 1),
(2, 'LOT-C12-28G', 'Munizione', 9.00, 50, NULL);

INSERT INTO Gara (Data) VALUES
('2026-04-10'),
('2026-05-20');

INSERT INTO Partecipa VALUES
('RSSMRA80A01H501A', 1, 120),
('BNCGLI90C03H501C', 1, 98),
('VRDLGU75B02H501B', 2, NULL);