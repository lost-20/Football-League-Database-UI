select top (10) * from Stadiums;


delete from Stadiums where ID = 5 AND name = 'aх' and country = 'aaaФ' and city = 'aaщ' and capacity = 56394; 

alter trigger del ON Stadiums Instead of DELETE
AS
Begin
declare @id int, @name nvarchar(50), @country nvarchar(50), @city nvarchar(30), @capacity int
select @id = deleted.ID, @name = deleted.name, @country = deleted.country, @city = deleted.city, @capacity = deleted.capacity from deleted
Update Clubs
SET Stadium_ID = NULL
where Stadium_ID = @id
Update Match
SET Stadium_ID = NULL
WHERE Stadium_ID = @ID
DELETE FROM Stadiums where ID = @id AND name = @name and country = @country and city = @city and capacity = @capacity; 
END

create proc seacrhclub @name nvarchar(30)
AS
begin
select * from clubs where name = @name
end

create proc viewpltr @ID int
AS
BEGIN
DELETE FROM Players_Trainers WHERE ID = @ID
END


ALTER Proc [dbo].[stadium_insert]@id int, @name nvarchar(30), @country nvarchar(20), @city nvarchar(30), @capacity int
AS
BEGIN
if @ID = 0
INSERT INTO Stadiums values (@name, @country, @city, @capacity)
else
Update Stadiums
Set 
name = @name,
country = @country,
city = @city,
capacity = @capacity
Where ID = @id
END

alter proc injured_insert @help int, @ID int, @match int, @type nvarchar(40), @rec int
as
begin
if @help = 0
insert into Injured_Players values (@ID, @match, @type, @rec)
else 
Update Injured_Players
Set Player_ID = @ID,
Match_ID = @match,
type_of_injury = @type,
recovery_time = @rec
where Player_ID = @ID and Match_ID = @match
end

select  * from Injured_Players order by Player_ID

exec injured_insert 3, 31, 7, 'Перелом руки', 10

create proc sponsors_insert @ID int, @name nvarchar(30), @service nvarchar (30) 
as
begin
if @ID = 0
insert into Sponsors values (@name, @service)
else 
Update Sponsors
Set name = @name,
service = @service
where ID =  @ID
end

exec sponsors_insert 1000007, 'ZZZZZ', 'Напиток'
select top(100) * from Sponsors order by ID desc

create proc delete_sp @ID int
as
begin
delete from Sponsors where ID = @ID
end

exec delete_sp 1000007