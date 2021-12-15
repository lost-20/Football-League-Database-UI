USE F_L_Main
GO
-----------------------------------------------Update1
ALTER TRIGGER Players_Transfer
ON Transfer
AFTER UPDATE
AS
DECLARE @id INT, @cl INT, @pl INT, @count INT, @dialog_handler UNIQUEIDENTIFIER, @error_save INT, @error_desc nvarchar(100)
SET @error_save = @@ERROR
SELECT @count = count(*) from inserted
IF @count > 1 
BEGIN
ROLLBACK TRAN
SET @error_desc = N'Unable To Update'
END CONVERSATION @dialog_handler
WITH ERROR = @error_save DESCRIPTION  = @error_desc
END
IF @count = 1
BEGIN
IF EXISTS (SELECT * FROM inserted WHERE inserted.transfer_Date_Over IS NOT NULL)
	BEGIN
	SELECT @cl = Transfer.Club_ID_To, @id = Transfer.ID, @pl = Transfer.Player_ID
	FROM Transfer join inserted
	ON inserted.ID = Transfer.ID
		UPDATE Players
		SET Players.Club_ID = @cl
		WHERE Players.ID = @pl
	END
END



UPDATE Transfer
SET transfer_Date_Over = '2020-01-01'
WHERE ID = 2

SELECT * FROM Transfer

SELECT * FROM Players
WHERE ID = 56   


SELECT Club_ID, ID FROM Players
WHERE ID = 56

UPDATE Players
SET Club_ID = 1
WHERE ID = 56
---------------------------------------------Update2
CREATE VIEW Players_view
AS
SELECT p.ID, p.name, c.name as Club_Name
FROM Players p inner join Clubs c
ON p.Club_ID = c.ID

CREATE TRIGGER Players__Update
ON Players_view
INSTEAD OF UPDATE 
AS
BEGIN
DECLARE @name nvarchar(50), @club nvarchar(50), @id INT
SELECT @name = inserted.name, @club = inserted.Club_name, @id = inserted.ID FROM inserted
UPDATE Players
SET name = @name
WHERE ID = @id
UPDATE Clubs
SET name = @club
WHERE ID = (SELECT Club_ID FROM Players, inserted WHERE inserted.ID = Players.ID)
END

SELECT * FROM Players_view


UPDATE Players_view
SET Club_Name = 'ZZZZZZ'
WHERE ID = 77


----------------------------------------------INSERT1


CREATE TRIGGER Club_Insert_Stat
ON Clubs
AFTER INSERT
AS
BEGIN
DECLARE @id INT, @cl INT, @pl INT, @count INT,  @dialog_handler UNIQUEIDENTIFIER, @error_save INT, @error_desc nvarchar(100)
SELECT @count = count(*) from inserted
SET @error_save = @@ERROR
IF @count = 1
	BEGIN
	SELECT @cl = inserted.ID FROM inserted
	SELECT @id = max(rank) FROM Clubs_Statistics
	INSERT INTO Clubs_Statistics 
	VALUES (@id + 1, @cl, 0, 0, 0) 
	END
IF NOT EXISTS (SELECT * FROM Stadiums INNER JOIN inserted ON inserted.Stadium_ID = Stadiums.ID)
	BEGIN
	SET @error_desc = N'Inserted Stadium_Id does not exist'
	END CONVERSATION @dialog_handler
	WITH ERROR = @error_save DESCRIPTION  = @error_desc
	END
END



INSERT INTO Stadiums values ('A', 'B', 'C', 12345)

INSERT INTO Clubs values ('1300-04-09', 'ABCD', 900)

SELECT * FROM Clubs_Statistics
-------------------------------------------------------------------INSERTE2

CREATE VIEW Trainers_view
AS
SELECT t.ID, t.full_name,t.wage, c.name as Club_Name
FROM Trainers t inner join Clubs c
ON t.Club_ID = c.ID

SELECT * FROM Trainers_view

CREATE TRIGGER Trainers_view_Insert
ON Trainers_view
INSTEAD OF Insert
AS
BEGIN
DECLARE @name nvarchar(50), @club nvarchar(50), @id INT, @wage INT
SELECT @name = inserted.full_name, @club = inserted.Club_name, @id = inserted.ID, @wage = inserted.wage FROM inserted
Insert INTO Trainers (date_of_birth, full_name, wage, date_of_appointment, position) values (GETDATE(), @name, @wage, GETDATE(), 'Тренер')
END


INSERT INTO Trainers_view (full_name, wage) values ('ABCCC', 111111)
SELECT * FROM Clubs

SELECT * FROM Trainers



---------------------------------------------------------DELETE1
ALTER TABLE Clubs
ADD deleted BIT

UPDATE Clubs
SET deleted = 0

ALTER TRIGGER Club_Delete
ON Clubs
INstead of DELETE
AS
BEGIN
DECLARE @id INT
SELECT @id = deleted.ID FROM deleted
	DELETE FROM Clubs_Statistics
	WHERE Club_ID = @id
	UPDATE Players
	SET Club_ID = NULL
	WHERE Club_ID = @id
	UPDATE Owners
	SET Club_ID = NULL
	WHERE Club_ID = @id
	UPDATE Trainers
	SET Club_ID = NULL
	WHERE Club_ID = @id
	UPDATE Clubs
	SET deleted = 1
	WHERE ID = @id
END

INSERT INTO Clubs_Statistics values (30, 30, 0, 6, 0)

DELETE FROM Clubs
WHERE ID = 30

SELECT * FROM Players
WHERE Club_ID = 30

SELECT * FROM Clubs_Statistics
WHERE Club_ID = 30

SELECT * FROM Trainers
WHERE Club_ID = 30

SELECT * FROM Owners
WHERE Club_ID = 30

SELECT * FROM Clubs
WHERE ID = 30

------------------------------------DELETE2
ALTER TABLE Injured_Players
ADD Recovered BIT

UPDATE Injured_Players
SET Recovered = 0

ALTER TRIGGER Injured_Players_delete
ON Injured_players
AFTER DELETE
AS
BEGIN
DECLARE @time INT, @match date
SELECT @match = (Select TOP(1) Match.date_of_match
        FROM deleted inner join Match
        ON Match_ID = deleted.Match_ID
    )
 SELECT @time = (SELECT TOP (1) deleted.recovery_time
        FROM deleted inner join Match
        ON Match_ID = deleted.Match_ID
    )
	PRINT @time
	PRINT @match
	PRINT convert(date, GETDATE())
	IF (dateadd(day, -@time, convert (date, GetDate())) < @match) 
    BEGIN
        ROLLBACK;
        THROW 50001, 'Cannot delete a Player which hasnot recovered yet', 1;
    END
END

DELETE FROM Injured_Players
WHERE Player_ID = 23000 AND Match_ID = 14500

SELECT * FROM Injured_Players
WHERE Match_ID = 14500

SELECT Match.date_of_match FROM Match
WHERE ID = 14500

INSERT INTO Injured_Players values (23000, 14500, 'ABC', 500, 0)