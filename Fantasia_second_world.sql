
DROP TABLE  IF EXISTS amicizia;
DROP TABLE  IF EXISTS arma_a_distanza;
DROP TABLE  IF EXISTS arma_bianca;
DROP TABLE  IF EXISTS clan;
DROP TABLE  IF EXISTS classe;
DROP TABLE  IF EXISTS giocatore;
DROP TABLE  IF EXISTS include_b;
DROP TABLE  IF EXISTS include_d;
DROP TABLE  IF EXISTS inventario;
DROP TABLE  IF EXISTS lobby;
DROP TABLE  IF EXISTS messaggio;
DROP TABLE  IF EXISTS missione;
DROP TABLE  IF EXISTS ospita;
DROP TABLE  IF EXISTS personaggio;
DROP TABLE  IF EXISTS professione;
DROP TABLE  IF EXISTS razza;
DROP TABLE  IF EXISTS reame;
DROP TABLE  IF EXISTS server;
DROP TABLE  IF EXISTS specializzazione;
DROP VIEW IF EXISTS QUERY_1;
DROP VIEW IF EXISTS QUERY_2;
DROP VIEW IF EXISTS QUERY_3;
DROP VIEW IF EXISTS QUERY_4;
DROP VIEW IF EXISTS QUERY_5;
DROP VIEW IF EXISTS inv;
DROP VIEW IF EXISTS Ng;
DROP PROCEDURE IF EXISTS login;
DROP PROCEDURE IF EXISTS logout;
DROP PROCEDURE IF EXISTS Newclan;
DROP FUNCTION IF EXISTS LivelloPersonaggio;
DROP FUNCTION IF EXIsTS	MaxSoldi;
DROP TRIGGER IF EXISTS SetPlayersdown;
DROP TRIGGER IF EXISTS SetReami;

CREATE TABLE arma_bianca (
  IDArma int(11) NOT NULL PRIMARY KEY,
  Danno int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO arma_bianca (IDArma, Danno) VALUES
(654, 10),
(772,  8),
(1212, 4),
(121,  15),
(774,  7);

CREATE TABLE clan (
  NomeClan varchar(255) NOT NULL PRIMARY KEY,
  Nmembri int(11) NOT NULL,
  tag varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO clan (NomeClan, Nmembri, tag) VALUES
('Raging Tigers', 54, 'RT'),
('IWN', 24, 'IWN'),
('MilloFanClub', 122, 'MFC'),
('joinUs', 54, 'JU');

CREATE TABLE classe (
  Nome varchar(255) PRIMARY KEY NOT NULL,
  Risorsa varchar(255)  DEFAULT 'mana',
  Ruolo varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO classe (Nome, Risorsa, Ruolo) VALUES
('Guerriero', 'Stamina', 'Combattente'),
('Ladro', 'Mana', 'Assassino'),
('Druido', 'Mana', 'Guaritore'),
('Mago', 'Mana', 'Assassino'),
('Sacerdote', 'Mana', 'Guaritore'),
('Berserk', 'Furia', 'Combattente');


CREATE TABLE missione (
  Codice int(11) PRIMARY KEY NOT NULL,
  Tipologia varchar(255) NOT NULL,
  Ricompensa varchar(255) NOT NULL DEFAULT '500 oro',
  N_membri int(11) DEFAULT '0',
  A_tempo tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO missione (Codice, Tipologia, Ricompensa, N_Membri, A_Tempo) VALUES
(12, 'Difendi la Base', '1500 oro', 3, 5),
(24, 'Difendi il VIP', '500 oro', 0, 0),
(31, 'Sconfiggi il Boss', '1000 oro, Spada del Boss', 2, 0),
(22, 'Scaccia i pirati', '1500 oro', 1, 0),
(06, 'Duello!', '500 oro', 0, 2),
(07, 'Porta i materiali a destinazione', '500 oro', 0, 5);

CREATE TABLE professione (
  Nome varchar(255)PRIMARY KEY NOT NULL,
  Guadagno int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO professione (Nome, Guadagno) VALUES
('Mercenario', 200),
('Insegnante', 350),
('Cacciatore', 120),
('Mercante', 380),
('Custode', 200),
('Contadino', 250),
('Artista', 215);

CREATE TABLE lobby (
  IDlobby int(11) PRIMARY KEY NOT NULL,
  Proprietario varchar(255) NOT NULL,
  Data_creazione date NOT NULL,
  Missione int(11) NOT NULL,
  FOREIGN KEY (Missione) REFERENCES missione (Codice) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO lobby (IDlobby, Proprietario, Data_creazione, Missione) VALUES
(8, 'Pippo', '2018-03-05', 12),
(1, 'Paperino', '2018-06-23', 31),
(2, 'Ale2345', '2019-03-04', 22);

CREATE TABLE razza (
  Nome varchar(255)PRIMARY KEY NOT NULL,
  Fazione enum('orda','alleanza')  DEFAULT 'alleanza',
  Magia varchar(255) NOT NULL,
  Mezzo_di_trasporto varchar(255) NOT NULL,
  Area_Provenienza varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO razza (Nome, Fazione, Magia, Mezzo_di_trasporto, Area_Provenienza) VALUES
('Worg', 'Orda', 'Ululato', 'Zampe', 'Rivendell'),
('Elfo Oscuro', 'Orda', 'Resisti-Magia', 'Teletrasporto', 'Riften'),
('Argoniano', 'Alleanza', 'Respiro Acquatico', 'Vascello', 'Rivendell'),
('Elfo Alto', 'Alleanza', 'Mira Migliorata', 'Portali', 'Solitude'),
('Umano', 'Alleanza', 'Resisti-Gelo', 'Carro', 'Baltimora'),
('Orco', 'Orda', 'Urlo di Guerra', 'SiltRider', 'Minas-Morgul'),
('Goblin', 'Orda', 'Palla di fuoco', 'Vie Sotterranee', 'Moria');


CREATE TABLE `server` (
  IPserver int(11) PRIMARY KEY NOT NULL,
  Nome varchar(255) NOT NULL,
  Regione varchar(255) NOT NULL,
  Capienza int(11) NOT NULL,
  Stato enum('online','offline') DEFAULT 'offline',
  Tipo enum('pvp','pve') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
INSERT INTO server (IPserver, Nome, Regione, Capienza, Stato, Tipo) VALUES
(0, 'Azeroth', 'Europe West', 50000, 'online', 'pvp'),
(1, 'Olvaeria', 'Europe East', 50000, 'online', 'pve'),
(2, 'Xenosie', 'North America', 50000, 'online', 'pvp'),
(3, 'Ozuno', 'South-East Asia', 50000, 'offline', 'pve'),
(4, 'Sonia', 'Russia', 50000, 'offline', 'pvp'),
(5, 'Aldrassil', 'Australia', 50000, 'offline', 'pve'),
(6, 'VenomSpite', 'South America', 50000, 'offline', 'pvp');

CREATE TABLE arma_a_distanza (
  IDArma int(11) NOT NULL PRIMARY KEY,
  Danno int(11) NOT NULL,
  Gittata int(11) NOT NULL,
  Munizioni int(11) NOT NULL,
  MaxMunizioni int(11) NOT NULL DEFAULT '30'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO arma_a_distanza (IDArma, Danno, Gittata, Munizioni, MaxMunizioni) VALUES
(1001,  0, 20, 1, 1),
(436,  11, 15, 15, 45),
(799,  5, 10, 30, 100),
(1002, 30, 15, 1, 1),
(982,  14, 8, 10, 25);

CREATE TABLE giocatore (
  Username varchar(255) NOT NULL PRIMARY KEY,
  Stato enum('online','offline') DEFAULT 'offline',
  Ping smallint(6) NOT NULL,
  Clan varchar(255) DEFAULT 'nessun clan',
  Lobby int(11),
  MissioneInCorso int(11),
  FOREIGN KEY (Clan) REFERENCES clan (NomeClan) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (Lobby) REFERENCES lobby (IDlobby) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (MissioneInCorso) REFERENCES missione (Codice) ON DELETE SET NULL  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO giocatore (Username, Stato, Ping, Clan, Lobby, MissioneInCorso) VALUES
('Pippo', 'online', 5, 'Raging Tigers', 8, 12),
('Pluto', 'online', 12, 'Raging Tigers', 8, 12),
('Topolino', 'online', 4, 'Raging Tigers', 8, 12),
('Paperino', 'online', 11, 'IWN', 1, 31),
('PincoPallo', 'online', 21, 'IWN', 1, 31),
('Ale2345', 'online', 7, 'MilloFanClub', 2, 22),
('Arthas007', 'offline', 0, 'MilloFanClub', default, default),
('TeamLeader', 'offline', 0, 'joinUs', default, default);


CREATE TABLE amicizia (
  Username1 varchar(255) NOT NULL,
  Username2 varchar(255) NOT NULL,
  Data date NOT NULL,
  PRIMARY KEY( Username1,Username2),
  FOREIGN KEY (Username1) REFERENCES giocatore (Username) ON      DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Username2) REFERENCES giocatore (Username) ON    DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE messaggio (
  ID int(11)PRIMARY KEY AUTO_INCREMENT NOT NULL,
  Testo varchar(255) NOT NULL,
  Data date NOT NULL,
  Mittente varchar(255) NOT NULL,
  Destinatario varchar(255) NOT NULL,
  FOREIGN KEY (Mittente) REFERENCES giocatore (Username) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Destinatario) REFERENCES giocatore (Username) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO messaggio (ID, Testo, Data, Mittente, Destinatario) VALUES
(0345, 'Ciao, facciamo una lobby? Devo farmare gold oggi.', '2018-03-05', 'Pippo', 'Pluto'),
(0346, 'Wewe, stavo giusto per staccare, posso esserci stasera, che dici?', '2018-03-05', 'Pluto', 'Pippo'),
(0347, 'ottimo! a stasera :)', '2018-03-05', 'Pippo', 'Pluto'),
(1456, 'Hey, hai voglia di aiutarmi contro il boss della missione n.31?', '2018-06-23', 'Paperino', 'PincoPallo'),
(1457, 'Arrivo subito, intanto entra su TeamSpeak', '2018-06-23', 'PincoPallo', 'Paperino'),
(5897, 'Ciao Arthas007, ho visto che hai una balestra che non usi, me la scambieresti?', '2019-01-31', 'Paperino', 'Arthas007'),
(4687, 'Ciao! Mi daresti una mano? Ho appena scaricato il gioco e vorrei chiederti un paio di info ^^', '2018-04-10', 'TeamLeader', 'Pluto');

INSERT INTO amicizia (Username1, Username2, Data) VALUES
('Pippo', 'Pluto', '2018-02-15'),
('Topolino', 'Pluto', '2018-03-11'),
('Paperino', 'PincoPallo', '2019-01-05'),
('Ale2345', 'Arthas007', '2018-06-15'),
('Paperino', 'Arthas007', '2018-07-22');

CREATE TABLE inventario (
  IDinventario int(11) NOT NULL,
  NomeOggetto varchar(255) NOT NULL,
  N_oggetti int(11) NOT NULL,
  PRIMARY KEY(IDinventario, NomeOggetto)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO inventario (IDinventario, NomeOggetto, N_Oggetti) VALUES
(1114, 'Pozione Curativa', 5),
(1114, 'rubedo', 1),
(1114, 'chiave del relitto', 5),
(1115, 'iniettore di detonite', 10),
(1115, 'Pozione di Invisibilità', 3),
(1115, 'Pergamena del Silenzio', 2),
(4315, 'Bastone del Saggio', 1),
(4315, 'Germogli Curativi', 4),
(4315, 'Acetosella del Re', 5),
(1234, 'cetus wisp', 1),
(1234, 'Pozione Curativa', 3),
(1234, 'Radice di Nirn', 7),
(2316, 'Libro degli Incantesimi', 1),
(2316, 'Radice di Nirn', 10),
(2316, 'Pergamena Antica', 1),
(6751, 'Bomba Nera', 5),
(6751, 'Polvere Draconica', 5),
(6751, 'Libro degli Incantesimi', 1),
(2134, 'nuka cola', 1),
(2134, 'Pillola della Furia', 5),
(2134, 'chiave del relitto', 10),
(8464, 'elisir della forza', 1),
(8464, 'Polvere da Sparo', 15),
(8464, 'Dinamite', 4),
(1115, 'balestra elfica', 1),
(1234, 'kunai', 5),
(2316, 'arco', 1),
(2316, 'lancia degli antichi', 1),
(6751, 'arco', 1),
(8464, 'dardi paralizzanti', 5),
(1114, 'daga orchesca', 1),
(1115, 'bastone argoniano', 1),
(4315, 'stocco', 1),
(2134, 'spadone elfico', 1),
(2134, 'coltellino', 2);


CREATE TABLE personaggio (
  IDPersonaggio int(11)PRIMARY KEY NOT NULL,
  NomePersonaggio varchar(50) NOT NULL,
  Monete int(11) DEFAULT '0',
  Esperienza int(11) DEFAULT '0',
  Potenza smallint(6) NOT NULL,
  Punti_vita int(11) DEFAULT '750',
  Giocatore varchar(255) NOT NULL,
  Razza varchar(255) NOT NULL,
  Classe varchar(255) NOT NULL,
  Professione varchar(255) DEFAULT 'nessuna professione',
  Inventario int(11) NOT NULL,
  FOREIGN KEY (Giocatore) REFERENCES giocatore (Username) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Razza) REFERENCES razza (Nome) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Classe) REFERENCES classe (Nome) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Professione) REFERENCES professione (Nome) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (Inventario) REFERENCES inventario (IDinventario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO personaggio (IDPersonaggio, NomePersonaggio, Monete, Esperienza, Potenza, Punti_vita, Giocatore, Razza, Classe, Professione, Inventario) VALUES
(3541, 'Garrik', 7400, 155, 12, 750, 'Pippo', 'Worg', 'Druido', 'Mercenario', 1114),
(3542, 'Ayen', 15470, 240, 17, 660, 'Pippo', 'Elfo Oscuro', 'Ladro', 'Mercante', 1115),
(4567, 'Kailu', 6450, 150, 12, 400, 'Pluto', 'Argoniano', 'Druido', 'Insegnante', 4315),
(7542, 'Meriel', 1345, 40, 8, 688, 'Topolino', 'Elfo Alto', 'Guerriero', 'Cacciatore', 1234),
(1346, 'Alais', 76410, 322, 21, 750, 'Arthas007', 'Umano', 'Sacerdote', 'Insegnante', 2316),
(7648, 'Karfu', 3140, 95, 7, 750, 'Ale2345', 'Umano', 'Mago', 'Custode', 6751),
(6479, 'Zarod', 7900, 170, 17, 468, 'TeamLeader', 'Orco', 'Berserk', 'Mercenario', 2134),
(4613, 'Morbash', 6050, 116, 15, 115, 'Paperino', 'Goblin', 'Ladro', 'Cacciatore', 8464);

CREATE TABLE include_b (
  IDInventario int(11) NOT NULL,
  Nome varchar(255) NOT NULL,
  IDarma int(11) NOT NULL,
  PRIMARY KEY(IDInventario, Nome, IDarma),
  FOREIGN KEY (IDInventario, Nome) REFERENCES inventario (IDInventario, NomeOggetto) ON DELETE CASCADE ON UPDATE CASCADE,		
  FOREIGN KEY (IDarma) REFERENCES arma_bianca (IDArma) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO include_b (IDInventario, Nome, IDArma) VALUES
(1114, 'daga orchesca', 654),
(1115, 'bastone argoniano', 772),
(4315, 'stocco', 1212),
(2134, 'spadone elfico', 121),
(2134, 'coltellino', 774);


CREATE TABLE include_d (
  IDInventario int(11) NOT NULL,
  Nome varchar(255) NOT NULL,
  IDarma int(11) NOT NULL,
  PRIMARY KEY(IDInventario, Nome, IDarma),
  FOREIGN KEY (IDInventario, Nome) REFERENCES inventario (IDInventario, NomeOggetto) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IDarma) REFERENCES arma_a_distanza (IDArma) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO include_d (IDInventario, Nome, IDArma) VALUES
(1115, 'balestra elfica', 1001),
(1234, 'kunai', 436),
(2316, 'arco', 799),
(2316, 'lancia degli antichi', 1002),
(6751, 'arco', 799),
(8464, 'dardi paralizzanti', 982);


CREATE TABLE reame (
  IDreame int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  Status enum('online','offline') DEFAULT 'offline',
  Popolazione int(11) NOT NULL,
  Server int(11) NOT NULL,
  FOREIGN KEY (Server) REFERENCES server (IPserver) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO reame (IDreame, Status, Popolazione, Server) VALUES
(00, 'online', 7000, 0),
(01, 'online', 4582, 0),
(10, 'online', 7946, 1),
(11, 'online', 2564, 1),
(20, 'online', 9004, 2),
(21, 'online', 8468, 2),
(30, 'offline', 0, 3),
(40, 'offline', 0, 4),
(50, 'offline', 0, 5),
(60, 'offline', 0, 6);

CREATE TABLE ospita (
  IDreame int(11) NOT NULL,
  Username varchar(255) NOT NULL,
  PRIMARY KEY(IDreame,Username),
  FOREIGN KEY (IDreame) REFERENCES reame (IDreame) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Username) REFERENCES giocatore (Username) ON DELETE CASCADE ON UPDATE CASCADE
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO ospita (IDreame, Username) VALUES
(00, 'Pippo'),
(00, 'Pluto'),
(00, 'Topolino'),
(01, 'Paperino'),
(01, 'PincoPallo'),
(11, 'Ale2345'),
(20, 'Arthas007'),
(21, 'TeamLeader');

CREATE TABLE specializzazione (
  Nome varchar(255) PRIMARY KEY NOT NULL,
  Tipo varchar(255) NOT NULL,
  Classe varchar(255) NOT NULL,
  FOREIGN KEY (Classe) REFERENCES classe (Nome) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO specializzazione (Nome, Tipo, Classe) VALUES
('Arma e scudo', 'Scudo', 'Guerriero'),
('Arma a due mani', 'Danno', 'Guerriero'),
('Canaglia', 'Danno', 'Ladro'),
('Servitore oscuro', 'Danno', 'Ladro'),
('Servitore della Natura', 'Cura', 'Druido'),
('Mago della Luce', 'Danno/Cura', 'Mago'),
('Mago oscuro', 'Danno', 'Mago'),
('Paladino', 'Scudo/Cura', 'Sacerdote'),
('Distruttore', 'Danno', 'Berserk');

-- QUERY 1:
	CREATE VIEW QUERY_1 AS
	SELECT p.IDpersonaggio, p.NomePersonaggio, sum(N_oggetti) AS oggetti_totali
	FROM Personaggio p, Inventario i
	WHERE p.Inventario= i.IDinventario
	GROUP BY p.IDpersonaggio, p.NomePersonaggio
	ORDER BY oggetti_totali;
-- QUERY 2:
	CREATE VIEW QUERY_2 AS
	SELECT  g.Username, p.NomePersonaggio, p.razza
	FROM reame r JOIN ospita o ON r.IDreame=o.IDreame JOIN giocatore g ON g.Username=o.Username JOIN personaggio p ON p.Giocatore=g.Username JOIN classe c ON p.Classe=c.nome
	WHERE r.IDreame=0 AND C.Ruolo='guaritore';
-- QUERY 3:
	CREATE VIEW inv AS
	SELECT DISTINCT IDinventario
	FROM inventario;

	CREATE VIEW QUERY_3 AS
	SELECT g.Username, p.NomePersonaggio
	FROM giocatore g JOIN personaggio p on p.Giocatore=g.Username JOIN inv i on i.
	IDinventario=p.Inventario JOIN include_b ib on ib.IDInventario=i.IDinventario 
	GROUP BY g.Username, p.NomePersonaggio
	HAVING count(ib.IDinventario) > 1
	UNION
	SELECT g.Username, p.NomePersonaggio
	FROM giocatore g JOIN personaggio p on p.Giocatore=g.Username JOIN inv i on i.IDinventario=p.Inventario JOIN include_d id on id.IDInventario=i.IDinventario 
	GROUP BY g.Username, p.NomePersonaggio
	HAVING count(id.IDinventario)>1;
-- QUERY 4:
	CREATE VIEW QUERY_4 AS
	SELECT s.IPserver, s.Nome, MAX(g.Ping) AS Maxping, AVG(g.Ping) AS pingMedio
	FROM server s, giocatore g, ospita o, reame r
	WHERE (r.Server= s.IPserver) AND (g.Username=o.Username AND r.IDreame=o.IDreame) AND (o.IDreame=0 OR o.IDreame=1) AND (g.Stato='online')
	GROUP BY s.IPserver, s.Nome;
-- QUERY 5:
	CREATE VIEW QUERY_5 AS
	SELECT p.NomePersonaggio, p.Potenza, p.Punti_vita, po.Nome, po.Guadagno
	FROM personaggio p, razza r, professione po
	WHERE p.Professione=po.Nome AND p.Razza= r.Nome AND Fazione='orda' AND po.Guadagno>= 200
	ORDER BY po.Guadagno DESC;
-- PROCEDURE 6:
	DELIMITER |
CREATE PROCEDURE login ( User varchar(255))
BEGIN
   DECLARE p varchar(50);
   SELECT g.Stato INTO p
   FROM giocatore g
   WHERE g.Username=User;
   IF ( p= 'offline') THEN
      update giocatore
      set Stato= 'online' 
      where Username=User;
      update giocatore
      set Ping=30
      where Username=User;
   END IF;
END|
DELIMITER ;

-- PROCEDURE 7:
	

DELIMITER | CREATE PROCEDURE logout ( User varchar(255))
BEGIN
   DECLARE p varchar(50);
   SELECT g.Stato INTO p
   FROM giocatore g
   WHERE g.Username=User;
   IF ( p= 'online') THEN 
      update giocatore
      set Stato= 'offline'
      where Username=User;
      update giocatore
      set Ping= 0, Lobby=NULL, MissioneInCorso=NULL
      where Username=User;
   END IF;
END| 
DELIMITER ;

-- PROCEDURE 8:
	DELIMITER |
	CREATE PROCEDURE Newclan ( clanName varchar(255), giocatore varchar(255), oldClan varchar(255))
	BEGIN
 	DECLARE m varchar(50);
 	DECLARE n varchar(50);
 	DECLARE CodErr CONDITION FOR SQLSTATE '45000'; 
 	set @err_mess = 'il giocatore non appartiene a quel clan';
 	SELECT g.Clan into m
 	FROM giocatore g
 	where g.Username= giocatore;
 	IF ( m <> oldClan) THEN 
     	   SIGNAL CodErr SET MESSAGE_TEXT= @err_mess;
	ELSE
          SELECT NomeClan into m
    	  FROM Clan
          WHERE NomeClan=ClanName;
          Update clan
          set Nmembri=Nmembri-1
          where nomeClan=oldClan;
          IF m is NOT NULL THEN
                   update Clan
                   set Nmembri=Nmembri +1
                   where nomeClan=ClanName;
                   update giocatore
                   set clan=clanName
                   where Username=giocatore;
    	 ELSE
                   insert into Clan values ( ClanName, 1, "tag predefinito");
                   Update giocatore
                   set clan=clanName
                   where Username=giocatore;
    	 END IF;
    END IF;
 END|
 DELIMITER ;

-- FUNCTION 9:
	DELIMITER |
	CREATE FUNCTION LivelloPersonaggio (IDPersonaggio int)
	RETURNS int
	BEGIN   
  	DECLARE n int;
        DECLARE m int;
	DECLARE r int;	
	set r= 20;
	set m=0;
	SELECT Esperienza into n
	FROM personaggio p
	WHERE p.IDPersonaggio = IDPersonaggio;
	WHILE (n-r >=0) DO
	   set n=n-r;
	   set m=m+1;
	   set r=r+5;
	END WHILE;
        RETURN m;
	END|
	DELIMITER ;

-- FUNCTION 10:
	CREATE VIEW Ng AS
	SELECT Giocatore, Monete+ Guadagno AS TOT
	FROM personaggio p JOIN professione  on Professione= Nome;

	DELIMITER |
	CREATE FUNCTION MaxSoldi ( Username varchar(255))
	RETURNS int
	BEGIN 
    	DECLARE N int;
    	SELECT MAX(TOT) into N
    	FROM Ng n, giocatore g
    	WHERE n.Giocatore=g.Username AND g.Username= Username;
    	RETURN N;
	END |
	DELIMITER ;

-- TRIGGER (a e b):

   	DELIMITER |
     	CREATE TRIGGER SetReami
	AFTER UPDATE ON server
	for each row
	BEGIN
	IF( old.Stato <> new.Stato) THEN
	update reame set reame.Status= 'offline'
	where reame.Server= new.IPServer;
	END IF;
	END|
	DELIMITER ;



	DELIMITER |
     	CREATE TRIGGER SetPlayersdown
	AFTER UPDATE ON reame
	for each ROW
	BEGIN
	IF(new.Status <> old.Status) THEN 
	Update giocatore 
	set Stato='offline', Ping=0, Lobby=NULL, MissioneInCorso=NULL
	where Username in  (SELECT O.Username
                          FROM ospita o
                                    where o.IDReame= new.IDReame);
    	END IF;
	END |
	DELIMITER ;







	



	


