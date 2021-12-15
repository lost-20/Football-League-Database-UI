USE Football_League;
GO

-----------------------------Join

SELECT Clubs.name, Trainers.full_name
FROM Clubs INNER JOIN Trainers
ON Clubs.ID = Trainers.Club_ID;

SELECT Players.name, Transfer.transition_Cost
FROM Players Left JOIN Transfer
ON Players.ID = Transfer.Player_ID;

SELECT Players.name, Transfer.transition_Cost
FROM Transfer Right JOIN Players
ON Players.ID = Transfer.Player_ID;

SELECT *
FROM Sponsors FULL JOIN Owners
ON Sponsors.ID = Owners.Sponsor_ID;

SELECT *
FROM Sponsors CROSS JOIN Owners;

---Функция вывода всех игроков выбранного клуба

CREATE FUNCTION player_info
	(@ID int)
	RETURNS TABLE
RETURN
	SELECT name FROM Players
	WHERE Club_ID = @ID


SELECT * FROM player_info(1)

SELECT *
FROM Clubs AS cl CROSS APPLY player_info(cl.ID)

SELECT F.ID AS Number, F.Club_ID_First AS Home_Team, S.Stadium_ID AS Stadium
FROM Match AS F
LEFT JOIN Match S
ON F.Club_ID_First = S.Stadium_ID

----------------------------------------UNION

SELECT name, wage FROM Players
	UNION
SELECT full_name, wage FROM Trainers
ORDER BY wage

SELECT name, wage FROM Players
	UNION ALL
SELECT full_name, wage FROM Trainers
ORDER BY wage DESC

SELECT Player_ID FROM Players_In_Match
EXCEPT
SELECT Player_ID FROM Injured_Players

SELECT Player_ID FROM Players_In_Match
INTERSECT
SELECT Player_ID FROM Injured_Players


-------------EXISTS

SELECT DISTINCT name FROM Players
WHERE position_in_team = 'RF' AND
EXISTS (Select name
FROM Players
WHERE Club_ID = 1
)

SELECT name FROM Players
WHERE nationality IN ('Argentina', 'Spain')

SELECT full_name FROM Trainers
WHERE wage > ALL (SELECT wage FROM Players);

SELECT full_name FROM Trainers
WHERE wage < ANY (SELECT wage FROM Players);

SELECT full_name FROM Trainers
WHERE wage BETWEEN 500 AND 3000;


SELECT name, nationality FROM Players
WHERE nationality LIKE 'S%'

----------------------------------Case

SELECT name, wage,
	CASE
		WHEN wage > 300 THEN 'The wage is higher than 300 000 euros per year'
		WHEN wage = 300 THEN 'The wage is 300 000 euros per year'
		ELSE 'The wage is lower than 300 000 euros per year'
	END AS Wage_Text
	FROM Players;



------------------------------------Convert

SELECT CAST (25.65 AS INT) AS TEST

SELECT CONVERT (varchar, 25.65) AS TEST

SELECT ISNULL (NULL, 'It is a NULL') AS TEST

SELECT NULLIF (25, 26) AS TEST
SELECT NULLIF (25, 25) AS TEST

SELECT COALESCE(IIF(55 > 20, NULL, 'False'), NULL, NULL, IIF(55 < 20, NULL, 'False'), NULL, 'NOT NULL') AS TEST

SELECT name, 
CHOOSE (Club_ID, COALESCE(NULL, NULL, 'Спартак', 'ЦСК'), 'Зенти', 'Барселона', 'ПСЖ') AS TEST
FROM Players;



---------------------------------String

SELECT REPLACE ('ПСЖ', 'П', 'А') AS TEST

SELECT SUBSTRING ('Спартак', 1, 4) AS TEST

SELECT STUFF ('Спартак', 2, 4, 'Зенит') AS TEST

SELECT STR (25.5, 4, 1) AS TEST

SELECT UNICODE ('Спартак') AS TEST

SELECT LOWER ('СПАРТАК') AS TEST

SELECT UPPER ('спартак') AS TEST


------------------------------------------Date

SELECT DATEPART(year, '2019-09-21') AS TEST

SELECT full_name, date_of_birth,
DATEADD(year, 100, date_of_birth) AS TEST
FROM Trainers

SELECT DATEDIFF (year, '2019-09-21', '2012-09-21') AS TEST


SELECT GETDATE()

SELECT SYSDATETIMEOFFSET()

--------------------------------------------GROUP

SELECT nationality, COUNT(ID) AS Count
FROM Players
GROUP BY nationality

SELECT nationality, COUNT(ID) AS Count
FROM Players
GROUP BY nationality
HAVING COUNT(ID) >= 5




SELECT * FROM Injured_Players; 

SELECT * FROM Players;

SELECT * FROM Clubs;

SELECT * FROM Trainers;

SELECT * FROM Transfer;

SELECT * FROM Owners;

SELECT * FROM Match;

SELECT * FROM Clubs_Statistics;

UPDATE Trainers
SET wage = 250
WHERE ID = 1

UPDATE Trainers
SET wage = 2000
WHERE ID = 2

UPDATE Trainers
SET wage = 3500
WHERE ID = 3

UPDATE Trainers
SET wage = 2500
WHERE ID = 4