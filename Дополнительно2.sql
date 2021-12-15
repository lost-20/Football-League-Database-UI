create proc player_names @name nvarchar(50)
as
begin
select * from Players where name = @name
end

exec player_names 'L. Messi'

create proc player_names_clubs @name nvarchar(50), @club_name nvarchar(30)
as
begin
select * from Players where name = @name and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_names_clubs'L. Messi', 'спартак'

create proc player_age_eq @age int
as
begin
select top (100) * from players where age = @age 
end

exec player_age_eq 22

create proc player_age_les @age int
as
begin
select top (100) * from players where age < @age 
end

exec player_age_les 22

create proc player_age_more @age int
as
begin
select top (100) * from players where age > @age 
end

exec player_age_more 22

create proc player_age_eq_cl @age int, @club_name nvarchar(30)
as
begin
select top (100) * from players where age = @age and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_age_eq_cl 22, 'спартак'

create proc player_age_les_cl @age int, @club_name nvarchar(30)
as
begin
select top (100) * from players where age < @age and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_age_les_cl 22, 'зенит'

create proc player_age_more_cl @age int, @club_name nvarchar(30)
as
begin
select top (100) * from players where age > @age and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_age_more_cl 22, 'спартак'

create proc player_nationality @nationality nvarchar(50)
as
begin
select top (100) * from Players where nationality = @nationality
end

exec player_nationality 'Spain'

create proc player_nationality_clubs @nationality nvarchar(50), @club_name nvarchar(50)
as
begin
select top (100) * from Players where nationality = @nationality and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_nationality_clubs 'Spain', 'спартак'

create proc player_wage_eq @wage int
as
begin
select top (100) * from players where wage = @wage 
end

exec player_wage_eq 300


create proc player_wage_les @wage int
as
begin
select top (100) * from players where wage < @wage 
end

exec player_wage_les 300

create proc player_wage_more @wage int
as
begin
select top (100) * from players where wage > @wage 
end

exec player_wage_more 300

create proc player_wage_eq_cl @wage int, @club_name nvarchar(30)
as
begin
select top (100) * from players where wage = @wage and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_wage_eq_cl 300, 'зенит'


create proc player_wage_les_cl @wage int, @club_name nvarchar(30)
as
begin
select top (100) * from players where wage < @wage and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_wage_les_cl 300, 'зенит'


create proc player_wage_more_cl @wage int, @club_name nvarchar(30)
as
begin
select top (100) * from players where wage > @wage and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_wage_more_cl 300, 'зенит'

create proc player_pos @position nvarchar(50)
as
begin
select top (100) * from Players where position_in_team = @position
end

exec player_pos'GK'

create proc player_pos_clubs @pos nvarchar(50), @club_name nvarchar(50)
as
begin
select top (100) * from Players where position_in_team = @pos and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_pos_clubs 'GK', 'спартак'

create proc player_num @num int
as
begin
select top (100) * from Players where number_in_team = @num
end

exec player_num 7

create proc player_num_clubs @num int, @club_name nvarchar(50)
as
begin
select top (100) * from Players where number_in_team = @num and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_num_clubs 7, 'Спартак'

create proc player_height_eq @h int
as
begin
select top (100) * from players where height = @h 
end

exec player_height_eq 180

create proc player_height_les @h int
as
begin
select top (100) * from players where height < @h 
end

exec player_height_les 180

create proc player_height_more @h int
as
begin
select top (100) * from players where height > @h 
end

exec player_height_more 180

create proc player_height_eq_cl @h int, @club_name nvarchar(30)
as
begin
select top (100) * from players where height = @h and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_height_eq_cl 180, 'зенит'

create proc player_height_les_cl @h int, @club_name nvarchar(30)
as
begin
select top (100) * from players where height < @h and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_height_les_cl 180, 'зенит'

create proc player_height_more_cl @h int, @club_name nvarchar(30)
as
begin
select top (100) * from players where height > @h and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_height_more_cl 180, 'зенит'

create proc player_weight_eq @w int
as
begin
select top (100) * from players where weight = @w 
end

exec player_weight_eq 70

create proc player_weight_les @w int
as
begin
select top (100) * from players where weight < @w 
end

exec player_weight_les 80

create proc player_weight_more @w int
as
begin
select top (100) * from players where weight > @w 
end

exec player_weight_more 80

create proc player_weight_eq_cl @w int, @club_name nvarchar(30)
as
begin
select top (100) * from players where weight = @w and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_weight_eq_cl 80, 'зенит'

create proc player_weight_les_cl @w int, @club_name nvarchar(30)
as
begin
select top (100) * from players where weight < @w and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_weight_les_cl 80, 'зенит'

create proc player_weight_more_cl @w int, @club_name nvarchar(30)
as
begin
select top (100) * from players where weight > @w and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec player_weight_more_cl 80, 'зенит'

create proc pl_id @id int
AS
begin
select top (100) * from Players where ID = @id 
end

exec pl_id 2


create proc pl_id_clubs @id int, @club_name nvarchar (30)
AS
begin
select top (100) * from Players where ID = @id and (Select ID From Clubs where Clubs.name = @club_name) = Club_ID
end

exec pl_id_clubs 2, 'спартак'

create proc sp_id @id int
as
begin
select * from Sponsors where ID = @id
end

exec sp_id 2

create proc sp_name @name nvarchar(50)
as
begin
select * from Sponsors where name = @name
end

exec sp_name 'лукойл'

create proc sp_service @service nvarchar(50)
as
begin
select * from Sponsors where service = @service
end

exec sp_service 'топливо'

create proc sp_id_name @id int, @name nvarchar(50)
as
begin
select * from Sponsors where name = @name and ID = @id
end

exec sp_id_name 1, 'лукойл'

create proc sp_id_service @id int, @service nvarchar(50)
as
begin
select * from Sponsors where service = @service and ID = @id
end

exec sp_id_service 1, 'топливо'

create proc sp_name_service @name nvarchar(40), @service nvarchar(50)
as
begin
select * from Sponsors where service = @service and name = @name
end

exec sp_name_service 'лукойл', 'топливо'

create proc sp_id_name_service @id int, @name nvarchar(40), @service nvarchar(50)
as
begin
select * from Sponsors where service = @service and name = @name and @id = ID 
end

exec sp_id_name_service 1, 'лукойл', 'топливо'

alter VIEW [dbo].[Players_Trainers]
AS
SELECT        dbo.Players.name, dbo.Players.age, dbo.Players.nationality, dbo.Players.wage, dbo.Players.position_in_team, dbo.Players.number_in_team, dbo.Players.height, dbo.Players.weight, 
                         dbo.Trainers.date_of_birth, dbo.Trainers.full_name, dbo.Trainers.position, dbo.Trainers.wage AS Trainer_wage, dbo.Trainers.date_of_appointment, dbo.Players.ID, dbo.Players.Club_ID, dbo.Trainers.Club_ID as Tr_Club 
FROM            dbo.Players INNER JOIN
                         dbo.Trainers ON dbo.Players.Club_ID = dbo.Trainers.Club_ID

alter trigger isrt on Players_Trainers instead of Insert
AS
begin
declare @name nvarchar (30), @age int, @nationality nvarchar(30), @wage decimal, @position nvarchar(4), @number int, @height int, @weight int, @club_id int
declare @date date, @full_name nvarchar (30), @pos nvarchar (40), @tr_wage decimal, @date_of_app date, @tr_club int
select @name = inserted.name, @age = inserted.age, @nationality = inserted.nationality, @wage = inserted.wage, @position = inserted.position_in_team,
@number = inserted.number_in_team, @height = inserted.height, @weight = inserted.weight, @club_id = inserted.Club_ID from inserted 
select @date = inserted.date_of_birth, @full_name = inserted.full_name, @pos = inserted.position, @tr_wage = inserted.Trainer_wage, @date_of_app = inserted.date_of_appointment, @tr_club = inserted.Tr_club from inserted
Insert into Players
(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
values
(@club_id, @name, @age, @nationality, @wage, @position, @number, @height, @weight)
insert into Trainers
(Club_ID, full_name, date_of_birth, position, wage, date_of_appointment)
values 
(@tr_club, @full_name, @date, @pos, @tr_wage, @date_of_app)
end

insert into Players_Trainers
(name, age, nationality, wage, position_in_team, number_in_team, height, weight, date_of_birth, full_name, position, Trainer_wage, date_of_appointment, Club_ID, Tr_Club)
values
('A', 12, 'A', 124, 'GK', 7, 170, 90, '2090-10-10', 'aaa', 'Тренер', 227, '2136-11-23', 7, 7)

select top (10) * from Players_Trainers order by ID desc

select top (10) * from Trainers order by id desc

create proc trplinsert @name nvarchar (30), @age int, @nationality nvarchar(30), @wage decimal, @position nvarchar(4), @number int, @height int, @weight int, @club_id int, @date date, @full_name nvarchar (30), @pos nvarchar (40), @tr_wage decimal, @date_of_app date, @tr_club int, @ID int, @Cl int
AS
begin
if @ID = 0
begin
Insert into Players
(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
values
(@club_id, @name, @age, @nationality, @wage, @position, @number, @height, @weight)
insert into Trainers
(Club_ID, full_name, date_of_birth, position, wage, date_of_appointment)
values 
(@tr_club, @full_name, @date, @pos, @tr_wage, @date_of_app)
end
else
begin
Update Players
Set 
Club_ID = @club_id,
name = @name,
nationality = @nationality,
wage = @wage,
position_in_team = @position,
number_in_team = @number,
height = @height,
weight = @weight
Where ID = @ID
Update Trainers
SET
Club_ID = @tr_club,
full_name = @full_name,
date_of_birth = @date,
position = @pos,
wage = @tr_wage,
date_of_appointment = @date_of_app
Where ID = @
end
end