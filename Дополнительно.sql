alter proc calc_cost_pl @clubName nvarchar(30), @yearFrom int
AS
BEGIN
Declare @year INT = year(GETDATE()) - @yearFrom + 1
SELECT sum (wage * 1000 * @year) From report1 WHERE  Player_club_ID = (Select ID FROm Clubs where name = @clubName)
END

exec calc_cost_pl 'спартак', 2017

SELECT sum (Player_wage * 1000 * 3) as cost From report1 WHERE  Player_club_ID = (Select ID FROm Clubs where name = 'Спартак')

SELECt club_Profit From Owners where Club_ID = (SELECT ID FROM Clubs where name = 'спартак' )

ALTER VIEW [dbo].[report1]
AS
SELECT        dbo.Players.ID AS Player_ID, dbo.Players.Club_ID AS Player_club_ID, dbo.Players.name, dbo.Players.wage AS Player_wage, dbo.Players.position_in_team, dbo.Trainers.ID AS Trainer_ID, 
                         dbo.Trainers.Club_ID AS Trainer_Club_ID, dbo.Trainers.full_name, dbo.Trainers.position, dbo.Trainers.wage
FROM            dbo.Players inner join
                         dbo.Trainers
						 on Players.Club_ID = Trainers.Club_ID
GO

ALTER proc [dbo].[calc_cost_pl] @clubName nvarchar(30), @yearFrom int
AS
BEGIN
Declare @year INT = year(GETDATE()) - @yearFrom + 1
SELECT sum (Player_wage * 1000 * @year) From report1 WHERE  Player_club_ID = (Select ID FROm Clubs where name = @clubName)
END
GO

ALTER proc [dbo].[insertplv] @Name nvarchar(30), @Age int, @Nationality nvarchar(30), @Wage int, @PositionInTeam nvarchar(3), @NumberInTeam int, @Height int, @Weight int
AS
BEGIN
INsert into View_info values (@Name, @Age, @Nationality, @Wage, @PositionInTeam, @NumberInTeam, @Height, @Weight)
END
GO


ALTER Proc [dbo].[stadium_insert] @name nvarchar(30), @country nvarchar(20), @city nvarchar(30), @capacity int
AS
BEGIN
INSERT INTO Stadiums values (@name, @country, @city, @capacity)
END
GO



ALTER VIEW [dbo].[Search]
AS
SELECT        dbo.Clubs.ID AS Clubs_ID, dbo.Clubs.date_of_establishment, dbo.Clubs.name AS Clubs_name, dbo.Clubs.Stadium_ID, dbo.Owners.ID AS Owners_ID, dbo.Owners.Club_ID AS Owners_Club_ID, dbo.Owners.Sponsor_ID, 
                         dbo.Owners.full_name AS Owners_full_name, dbo.Owners.date_of_birth AS Owners_date_of_birth, dbo.Owners.club_Profit, dbo.Owners.club_Purchase_Date, dbo.Owners.club_Sale_Date, dbo.Players.ID AS Players_ID, 
                         dbo.Players.Club_ID AS Players_Club_ID, dbo.Players.name AS Players_Name, dbo.Players.age, dbo.Players.nationality, dbo.Players.wage AS Players_wage, dbo.Players.position_in_team, dbo.Players.number_in_team, 
                         dbo.Players.weight, dbo.Players.height, dbo.Sponsors.ID AS Sponsors_ID, dbo.Sponsors.name AS Sponsors_name, dbo.Sponsors.service, dbo.Stadiums.ID AS Stad_ID, dbo.Stadiums.name, dbo.Stadiums.country, 
                         dbo.Stadiums.city, dbo.Stadiums.capacity, dbo.Trainers.ID, dbo.Trainers.Club_ID, dbo.Trainers.full_name, dbo.Trainers.date_of_birth, dbo.Trainers.position, dbo.Trainers.wage, dbo.Trainers.date_of_appointment, 
                         dbo.Trainers.dismissal_date
FROM            dbo.Clubs INNER JOIN
                         dbo.Owners ON dbo.Clubs.ID = dbo.Owners.Club_ID INNER JOIN
                         dbo.Players ON dbo.Clubs.ID = dbo.Players.Club_ID INNER JOIN
                         dbo.Sponsors ON dbo.Owners.Sponsor_ID = dbo.Sponsors.ID INNER JOIN
                         dbo.Stadiums ON dbo.Clubs.Stadium_ID = dbo.Stadiums.ID INNER JOIN
                         dbo.Trainers ON dbo.Clubs.ID = dbo.Trainers.Club_ID
GO


