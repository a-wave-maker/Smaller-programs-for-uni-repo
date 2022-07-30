--Creating the necessary tables
CREATE TABLE Distribution (
  idDistribution INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  platform VARCHAR(30) NOT NULL,
  active_accounts INTEGER,
  distributor_cut FLOAT NOT NULL CHECK(distributor_cut>=0 AND distributor_cut<=1)
);
GO

CREATE TABLE Dev_studio (
  idDev_studio INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  country VARCHAR(30) NOT NULL,
  city VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Publisher (
  idPublisher INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  value BIGINT
);
GO

CREATE TABLE Monetization (
  idMonetization INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  paid BIT NOT NULL DEFAULT 1,
  dlc BIT NOT NULL DEFAULT 0,
  microtransactions BIT NOT NULL DEFAULT 0,
  sold_copies INTEGER NOT NULL CHECK(sold_copies>0),
  all_time_profit INTEGER NOT NULL CHECK(all_time_profit>0)
);
GO

CREATE TABLE Players (
  idPlayers INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  all_time_peak INTEGER,
  average_daily INTEGER,
  monthly_trend VARCHAR(5)
);
GO

CREATE TABLE Age_rating (
  idAge_rating INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  PEGI INTEGER NOT NULL DEFAULT 16 CHECK(PEGI IN (3, 7, 12, 16, 18)),
  ESRB CHAR NOT NULL DEFAULT 'T' CHECK(ESRB IN ('C', 'E', 'T', 'M', 'A')),
  ACB VARCHAR(2) NOT NULL DEFAULT 'MA' CHECK(ACB IN ('G', 'PG', 'M', 'MA', 'R', 'X')),
  IARC INTEGER NOT NULL DEFAULT 16 CHECK(IARC IN (3, 7, 12, 16, 18)),
  USK INTEGER NOT NULL DEFAULT 16 CHECK(USK IN (0, 6, 12, 16, 18))
);
GO

CREATE TABLE Genre (
  idGenre INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Game (
  idGame INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  idPublisher INTEGER NOT NULL REFERENCES Publisher(idPublisher),
  idAge_rating INTEGER NOT NULL REFERENCES Age_rating(idAge_rating),
  idPlayers INTEGER NOT NULL REFERENCES Players(idPlayers),
  idMonetization INTEGER NOT NULL REFERENCES Monetization(idMonetization),
  title VARCHAR(50) NOT NULL UNIQUE,
  series VARCHAR(50),
  release_date DATE DEFAULT NULL,
  cover VARBINARY(MAX) DEFAULT NULL,
  engine VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Developer (
  idDeveloper INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  idGame INTEGER NOT NULL REFERENCES Game(idGame),
  idDev_studio INTEGER NOT NULL REFERENCES Dev_studio(idDev_studio)
);
GO

CREATE TABLE Distributions (
  idDistributions INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  idGame INTEGER NOT NULL REFERENCES Game(idGame),
  idDistribution INTEGER NOT NULL REFERENCES Distribution(idDistribution),
  price FLOAT,
);
GO

CREATE TABLE Game_type (
  idGame_type INTEGER NOT NULL IDENTITY(1,1) PRIMARY KEY,
  idGame INTEGER NOT NULL REFERENCES Game(idGame),
  idGenre INTEGER NOT NULL REFERENCES Genre(idGenre)
);
GO

--Inserting sample data
INSERT INTO Distribution(name,platform,active_accounts,distributor_cut) VALUES ('Steam','PC',120000000,0.3);
INSERT INTO Distribution(name,platform,active_accounts,distributor_cut) VALUES ('Origin','PC',NULL,0.9);
INSERT INTO Distribution(name,platform,active_accounts,distributor_cut) VALUES ('PSN Store','PlayStation',104000000,0.3);
INSERT INTO Distribution(name,platform,active_accounts,distributor_cut) VALUES ('Microsoft Store','PC',90000000,0.12);
INSERT INTO Distribution(name,platform,active_accounts,distributor_cut) VALUES ('Microsoft Store','Xbox',90000000,0.12);
INSERT INTO Distribution(name,platform,active_accounts,distributor_cut) VALUES ('Epic Games Store','PC',58000000,0.12);
INSERT INTO Distribution(name,platform,active_accounts,distributor_cut) VALUES ('GOG','PC',64000000,0.3);

INSERT INTO Dev_studio(name,country,city) VALUES ('Respawn Vancouver','Canada','Vancouver');
INSERT INTO Dev_studio(name,country,city) VALUES ('Respawn Entertainment','United States','Seattle');
INSERT INTO Dev_studio(name,country,city) VALUES ('Psyonix Studios','United States','San Diego');
INSERT INTO Dev_studio(name,country,city) VALUES ('DICE','Sweden','Stockholm');
INSERT INTO Dev_studio(name,country,city) VALUES ('DICE','United States','New York');
INSERT INTO Dev_studio(name,country,city) VALUES ('Naughty Dog','United States','Santa Monica');
INSERT INTO Dev_studio(name,country,city) VALUES ('Egosoft','Germany','Hamburg');

INSERT INTO Publisher(name,value) VALUES ('Electronic Arts',35110000000);
INSERT INTO Publisher(name,value) VALUES ('Epic Games',28700000000);
INSERT INTO Publisher(name,value) VALUES ('Sony Computer Entertainment',156690000000);
INSERT INTO Publisher(name,value) VALUES ('Blizzard Activision',15037000000);
INSERT INTO Publisher(name,value) VALUES ('Egosoft',1528000);

INSERT INTO Monetization(paid,microtransactions,sold_copies,all_time_profit) VALUES (0,1,10000000,1600000000);
INSERT INTO Monetization(paid,dlc,microtransactions,sold_copies,all_time_profit) VALUES (0,1,1,10500000,70000000);
INSERT INTO Monetization(sold_copies,all_time_profit) VALUES (8700000,56000000);
INSERT INTO Monetization(dlc,microtransactions,sold_copies,all_time_profit) VALUES (1,1,7300000,1290000000);
INSERT INTO Monetization(dlc,sold_copies,all_time_profit) VALUES (1,1000000,6500000);

INSERT INTO Players(all_time_peak,average_daily,monthly_trend) VALUES (330879,150976,'+4.5%');
INSERT INTO Players(all_time_peak,average_daily,monthly_trend) VALUES (146902,33000,'+0.4%');
INSERT INTO Players(all_time_peak,average_daily,monthly_trend) VALUES (19074,598,'-2.3%');
INSERT INTO Players(all_time_peak,average_daily,monthly_trend) VALUES (89814,11102,'+6.7%');
INSERT INTO Players(all_time_peak,average_daily,monthly_trend) VALUES (15074,2503,'+9.9%');

INSERT INTO Age_rating(PEGI) VALUES (16);
INSERT INTO Age_rating(PEGI,ESRB,ACB,IARC,USK) VALUES (3,'E','G',3,0);
INSERT INTO Age_rating(PEGI,ESRB,ACB,IARC,USK) VALUES (18,'M','R',18,18);
INSERT INTO Age_rating(PEGI,ESRB,ACB,IARC,USK) VALUES (12,'T','M',12,12);

INSERT INTO Genre(name) VALUES ('Singleplayer');
INSERT INTO Genre(name) VALUES ('Multiplayer');
INSERT INTO Genre(name) VALUES ('First Person');
INSERT INTO Genre(name) VALUES ('Third Person');
INSERT INTO Genre(name) VALUES ('Open World');
INSERT INTO Genre(name) VALUES ('Linear');
INSERT INTO Genre(name) VALUES ('Shooter');
INSERT INTO Genre(name) VALUES ('Platformer');
INSERT INTO Genre(name) VALUES ('RPG');
INSERT INTO Genre(name) VALUES ('Sports');
INSERT INTO Genre(name) VALUES ('Battle Royale');
INSERT INTO Genre(name) VALUES ('Competitive');
INSERT INTO Genre(name) VALUES ('Open World');
INSERT INTO Genre(name) VALUES ('Sandbox');

INSERT INTO Game(idPublisher,idAge_rating,idPlayers,idMonetization,title,series,release_date,engine) VALUES (1,1,1,1,'Apex Legends',NULL,'2019-02-04','Source');
INSERT INTO Game(idPublisher,idAge_rating,idPlayers,idMonetization,title,series,release_date,engine) VALUES (2,2,2,2,'Rocket League',NULL,'2015-07-07','Unreal Engine 3');
INSERT INTO Game(idPublisher,idAge_rating,idPlayers,idMonetization,title,series,release_date,engine) VALUES (3,1,3,3,'Uncharted: The Lost Legacy','The Uncharted series','2017-08-22','Naughty Dog Game Engine');
INSERT INTO Game(idPublisher,idAge_rating,idPlayers,idMonetization,title,series,release_date,engine) VALUES (1,3,4,4,'Battlefield V','The Battlefield series','2018-11-20','Frostbite');
INSERT INTO Game(idPublisher,idAge_rating,idPlayers,idMonetization,title,series,release_date,engine) VALUES (5,4,5,5,'X4: Foundations','The X series','2018-11-30','Egosoft Engine');

INSERT INTO Developer(idGame,idDev_studio) VALUES (1,1);
INSERT INTO Developer(idGame,idDev_studio) VALUES (1,2);
INSERT INTO Developer(idGame,idDev_studio) VALUES (2,3);
INSERT INTO Developer(idGame,idDev_studio) VALUES (3,4);
INSERT INTO Developer(idGame,idDev_studio) VALUES (3,5);
INSERT INTO Developer(idGame,idDev_studio) VALUES (4,6);
INSERT INTO Developer(idGame,idDev_studio) VALUES (5,7);

INSERT INTO Distributions(idGame,idDistribution,price) VALUES (1,1,0);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (1,2,0);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (1,3,0);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (1,5,0);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (1,6,0);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (2,3,0);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (2,5,0);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (2,6,0);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (3,1,25);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (3,3,20);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (4,1,40);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (4,2,40);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (4,3,40);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (4,5,35);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (5,1,60);
INSERT INTO Distributions(idGame,idDistribution,price) VALUES (5,7,50);

INSERT INTO Game_type(idGame,idGenre) VALUES (1,2);
INSERT INTO Game_type(idGame,idGenre) VALUES (1,3);
INSERT INTO Game_type(idGame,idGenre) VALUES (1,7);
INSERT INTO Game_type(idGame,idGenre) VALUES (1,11);
INSERT INTO Game_type(idGame,idGenre) VALUES (1,12);
INSERT INTO Game_type(idGame,idGenre) VALUES (2,2);
INSERT INTO Game_type(idGame,idGenre) VALUES (2,4);
INSERT INTO Game_type(idGame,idGenre) VALUES (2,10);
INSERT INTO Game_type(idGame,idGenre) VALUES (2,12);
INSERT INTO Game_type(idGame,idGenre) VALUES (3,1);
INSERT INTO Game_type(idGame,idGenre) VALUES (3,4);
INSERT INTO Game_type(idGame,idGenre) VALUES (3,6);
INSERT INTO Game_type(idGame,idGenre) VALUES (3,12);
INSERT INTO Game_type(idGame,idGenre) VALUES (4,2);
INSERT INTO Game_type(idGame,idGenre) VALUES (4,3);
INSERT INTO Game_type(idGame,idGenre) VALUES (4,7);
INSERT INTO Game_type(idGame,idGenre) VALUES (5,1);
INSERT INTO Game_type(idGame,idGenre) VALUES (5,3);
INSERT INTO Game_type(idGame,idGenre) VALUES (5,5);
INSERT INTO Game_type(idGame,idGenre) VALUES (5,9);
INSERT INTO Game_type(idGame,idGenre) VALUES (5,13);
INSERT INTO Game_type(idGame,idGenre) VALUES (5,14);

--Inserting images if exits
DECLARE @FilePath AS NVarChar(256), @FileExists AS Int = 0;

SET @FilePath = N'C:\AL.jpg';

EXECUTE MASTER.dbo.xp_fileexist @FilePath, @FileExists OUTPUT;

IF ( @FileExists = 1 )
    UPDATE Game SET cover = ((SELECT * FROM OPENROWSET(BULK N'C:\AL.jpg', SINGLE_BLOB) AS VarbinaryMaxColumn)) WHERE idGame = 1
ELSE
	PRINT 'File not found'

SET @FilePath = N'C:\RL.jpg';

EXECUTE MASTER.dbo.xp_fileexist @FilePath, @FileExists OUTPUT;

IF ( @FileExists = 1 )
    UPDATE Game SET cover = ((SELECT * FROM OPENROWSET(BULK N'C:\AL.jpg', SINGLE_BLOB) AS VarbinaryMaxColumn)) WHERE idGame = 2
ELSE
	PRINT 'File not found'

SET @FilePath = N'C:\UT.jpg';

EXECUTE MASTER.dbo.xp_fileexist @FilePath, @FileExists OUTPUT;

IF ( @FileExists = 1 )
    UPDATE Game SET cover = ((SELECT * FROM OPENROWSET(BULK N'C:\AL.jpg', SINGLE_BLOB) AS VarbinaryMaxColumn)) WHERE idGame = 3
ELSE
	PRINT 'File not found'

SET @FilePath = N'C:\BV.jpg';

EXECUTE MASTER.dbo.xp_fileexist @FilePath, @FileExists OUTPUT;

IF ( @FileExists = 1 )
    UPDATE Game SET cover = ((SELECT * FROM OPENROWSET(BULK N'C:\AL.jpg', SINGLE_BLOB) AS VarbinaryMaxColumn)) WHERE idGame = 4
ELSE
	PRINT 'File not found'

SET @FilePath = N'C:\X.jpg';

EXECUTE MASTER.dbo.xp_fileexist @FilePath, @FileExists OUTPUT;

IF ( @FileExists = 1 )
    UPDATE Game SET cover = ((SELECT * FROM OPENROWSET(BULK N'C:\AL.jpg', SINGLE_BLOB) AS VarbinaryMaxColumn)) WHERE idGame = 5
ELSE
	PRINT 'File not found'




