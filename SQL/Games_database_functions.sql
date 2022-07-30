--Creates many-to-many tables used by the Game table
CREATE PROCEDURE connectGame @gameid int, @devstudioid int, @distributionid int, @price int, @genreid int
AS
    INSERT INTO Developer(idGame,idDev_studio) VALUES (@gameid,@devstudioid);
    INSERT INTO Distributions(idGame,idDistribution,price) VALUES (@gameid,@distributionid,@price);
    INSERT INTO Game_type(idGame,idGenre) VALUES (@gameid,@genreid);


--Inserts a new/finds existing genre by name and adds it to a game
CREATE PROCEDURE insertGenre @name varchar(30), @gameid int
AS
	DECLARE @genreid AS int

    IF NOT EXISTS ( SELECT * FROM Genre WHERE name = @name )
    BEGIN
        INSERT INTO Genre(name) VALUES (@name);
        SELECT @genreid = MAX(idGenre) FROM Genre;
	END
    ELSE
	BEGIN
        SELECT @genreid = idGenre FROM Genre
        WHERE name = @name;
    END

	IF EXISTS ( SELECT * FROM Game_type WHERE idGame = @gameid AND idGenre = @genreid )
	BEGIN
		PRINT 'Already matched'
	END
	ELSE
	BEGIN
		INSERT INTO Game_type(idGame,idGenre) VALUES (@gameid,@genreid);
	END



--Adds the cover for a specified game from drive
CREATE FUNCTION dbo.addPicture(@FilePath nvarchar(256), @gameid int)
RETURNS bit
AS
BEGIN
    DECLARE @FileExists AS Int = 0;
    DECLARE @sql AS nvarchar(MAX);

    EXECUTE MASTER.dbo.xp_fileexist @FilePath, @FileExists OUTPUT;

    IF ( @FileExists = 1 )
    BEGIN
        SET @sql = 'UPDATE Game SET cover =
                    ((SELECT * FROM OPENROWSET(BULK ''' + @FilePath +''', SINGLE_BLOB) 
                    AS VarbinaryMaxColumn)) WHERE idGame = ' + CONVERT(varchar(12), @gameid);

        EXECUTE sp_executesql @sql,N'';

        RETURN 1;
    END
       
    RETURN 0;
END;



--Counts games from a certain Publisher, Distribution, Genre or Developer
CREATE FUNCTION countGames (@sortby varchar(30), @name varchar(30))
RETURNS int
AS
BEGIN
    DECLARE @ret AS int

    IF (@sortby = 'Publisher')
    BEGIN
        SELECT @ret = COUNT(DISTINCT idGame) FROM gameOverview WHERE publisher = @name
	END
    ELSE IF (@sortby = 'Distribution')
    BEGIN
        SELECT @ret = COUNT(DISTINCT idGame) FROM gameOverview WHERE distribution = @name
    END 
    ELSE IF (@sortby = 'Genre')
    BEGIN
        SELECT @ret = COUNT(DISTINCT idGame) FROM gameOverview WHERE genre = @name
    END
    ELSE IF (@sortby = 'Developer')
    BEGIN
        SELECT @ret = COUNT(DISTINCT idGame) FROM gameOverview WHERE developer = @name
    END
    ELSE
    BEGIN
        RETURN -1
    END

    IF (@ret = 0)
    BEGIN
		RETURN 0
    END
   
	RETURN @ret

END;



--Shows overview of game/games, does not include statistical data
CREATE VIEW gameOverview
AS
SELECT Game.idGame, Game.title, Game.series, Publisher.name AS publisher, Dev_studio.name AS developer, Distribution.name AS distribution, Genre.name AS genre
FROM Game
JOIN Publisher ON Game.idPublisher = Publisher.idPublisher
JOIN Developer ON Game.idGame = Developer.idGame
JOIN Dev_studio ON Developer.idDev_studio = Dev_studio.idDev_studio
JOIN Game_type ON Developer.idGame = Game_type.idGame
JOIN Genre ON Game_type.idGenre = Genre.idGenre
JOIN Distributions ON Game.idGame = Distributions.idGame
JOIN Distribution ON Distributions.idDistribution = Distribution.idDistribution
GROUP BY Game.idGame, Game.title, Game.series, Publisher.name, Dev_studio.name, Distribution.name, Genre.name



--Adds the current date as release date if not specified when adding a new game, designed for adding future releases
CREATE TRIGGER autoDate
ON Game
AFTER INSERT
AS
	IF ( (SELECT COALESCE(Game.release_date, '') FROM Game JOIN inserted i ON Game.idGame = i.idGame) = '' )
	BEGIN
		UPDATE Game
		SET release_date = GETDATE()
		FROM Game
		JOIN inserted i ON Game.idGame = i.idGame;
	END



--Automatically checks for the default cover picture using a function above
CREATE TRIGGER checkForPic
ON Game
AFTER INSERT
AS
    DECLARE @gameid AS int
    SELECT @gameid = MAX(idGame) FROM Game
    EXEC addPicture N'C:\cover.jpg', @gameid



--Triggers check
INSERT INTO Game(idPublisher,idAge_rating,idPlayers,idMonetization,title,engine) VALUES (1,1,1,1,'Test','Engine');

--Date automatically added, picture automatically added if possible
SELECT * FROM Game


EXEC connectGame 6, 1, 1, 60, 1

EXEC insertGenre 'Space', 6

--Above can be now seen
SELECT * FROM gameOverview

--See the picture change
SELECT * FROM Game
EXEC addPicture 'C:\X4.jpg', 5
SELECT * FROM Game

BEGIN
DECLARE
@count real
EXEC @count=countGames 'Publisher', 'Electronic Arts'
print(@count)
END

SELECT * FROM Game
SELECT * FROM gameOverview


--Just helpful commands
DROP PROCEDURE connectGame

DROP PROCEDURE insertGenre

DROP FUNCTION addPicture

DROP FUNCTION countGames

DROP VIEW gameOverview

DROP TRIGGER checkForPic

DROP TRIGGER autoDate