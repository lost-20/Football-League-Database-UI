Use Football_League;
GO


Create proc pl_case @club_id int, @name nvarchar (50), @perc int
 AS
 begin
 SELECT name, wage,
	CASE
		WHEN wage > 300 THEN 'The wage is higher than 300 000 euros per year'
		WHEN wage = 300 THEN 'The wage is 300 000 euros per year'
		ELSE 'The wage is lower than 300 000 euros per year'
	END AS Wage_Text
	FROM Players
	Where Club_ID = @club_id
	AND name = @name
	if ((Select wage from Players Where Club_ID = @club_id AND name = @name ) > 300)
		Update Players
		SET wage = wage - wage * @perc / 100
		WHERE Club_ID = @club_id AND name = @name 
	if ((Select wage from Players Where Club_ID = @club_id AND name = @name ) < 300)
		Update Players
		SET wage = wage + wage * @perc / 100
		WHERE Club_ID = @club_id AND name = @name 
end

exec pl_case 1, 'L. Messi', 10

Create PROC pl_names
@club_id INT, @perc int
AS
Declare Col_Cursor CURSOR FOR
	SELECT name, wage FROM Players 
	where Club_ID = @club_id
Declare @s nvarchar (1000)
Declare @name nvarchar (40)
Declare @wage decimal
OPEN Col_Cursor
Fetch Next From Col_Cursor INTO @name, @wage
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	exec pl_case @club_id, @name, @perc
	Fetch Next From Col_Cursor INTO @name, @wage
END
CLOSE Col_Cursor
DEALLOCATE Col_Cursor

exec pl_names 2, 50

CREATE PROC inc_wages
@owner_id INT, @pl_percentage INT = 0, @tr_percentage INT = 0
AS
BEGIN
DECLARE @club_id INT
SELECT @club_id = club_id FROM Owners WHERE ID = @owner_id
UPDATE Trainers
SET wage = wage + wage * @tr_percentage / 100
WHERE @club_id = Club_ID
UPDATE Players
SET wage = wage + wage * @pl_percentage / 100
WHERE @club_id = Club_ID
END

EXECUTE inc_wages 1, 10, 10

SELECT * FROM Trainers
where Club_ID  = 1

CREATE PROC is_club_profitable @club_id INT
AS
BEGIN
DECLARE @wastes INT
SELECT @wastes = (SELECT sum(wage) FROM Players WHERE Club_ID = @club_id)
IF @wastes > (SELECT club_Profit FROM Owners WHERE Club_ID = @club_id)
BEGIN
PRINT 'FALSE'
RETURN 1
END
ELSE
BEGIN 
PRINT 'TRUE'
RETURN 0
END
END

EXEC is_club_profitable 2

CREATE PROC club_winrate @club_id INT, @out float OUTPUT
AS
BEGIN
SELECT @out = 100 *  number_of_wins / (number_of_lesions + number_of_wins + draw_number) FROM Clubs_Statistics WHERE @club_id = Club_ID
PRINT @out
END

EXEC club_winrate 3, 0

CREATE PROC club_years_of_survivability @owner_id INT, @perc INT
AS
BEGIN
DECLARE @club_id INT
DECLARE @club_profit INT
DECLARE @years INT = 0
SELECT @club_id = Club_ID, @club_profit = club_Profit FROM Owners WHERE ID = @owner_id
DECLARE @tmp float
SET @tmp = (SELECT sum(wage) FROM Players WHERE Club_ID = @club_id) + (SELECT sum(wage) FROM Trainers WHERE Club_ID = @club_id)
WHILE (@club_profit > 0)
BEGIN
SET @tmp = @tmp + @tmp * @perc / 100;
SET @years = @years + 1
SET @club_profit = @club_profit - @tmp
END
PRINT @years
RETURN @years
END

EXEC club_years_of_survivability 1, 100
