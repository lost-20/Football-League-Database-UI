use Football_League
---------------Stadium
DECLARE @n int = 0;
declare @Name nvarchar (50) = 'a';
declare @Capacity int;
declare @a char = 'А', @z char = 'я', @w int, @l int
SET @w = ascii(@z) - ascii(@a);
SET @l = ascii(@a);

while (@n < 100000)
begin
	if (len(@Name)>20) SET @Name = Convert(nvarchar, round(RAND() * 100, 0)) else SET @Name = @Name+char(round(rand() * @w, 0) + @l)
	SET @Capacity = round(RAND() * 100000, 0);
	insert into Stadiums
	values (@Name, @Capacity, @n)
	SET @n = @n + 1;
end

select * from Stadiums

----------------------CLUBS
DECLARE @n int = 0;
declare @Name nvarchar (50) = 'a';
declare @a char = 'А', @z char = 'я', @w int, @l int
declare @Income int;
SET @w = ascii(@z) - ascii(@a);
SET @l = ascii(@a);

while (@n < 100000)
begin
	if (len(@Name)>20) SET @Name = Convert(nvarchar, round(RAND() * 100, 0)) else SET @Name = @Name+char(round(rand() * @w, 0) + @l)
	SET @Income = round(RAND() * 100000000, 0);
	insert into Clubs
	values (@Name, @n, @Income, @n)
	SET @n = @n + 1;
end

select * from clubs

---------------------------------------Trainers
declare @n int  = 0;
declare @Name nvarchar (50) = 'a';
declare @a char = 'А', @z char = 'я', @w int, @l int
SET @w = ascii(@z) - ascii(@a);
SET @l = ascii(@a);
declare @wage int;

while (@n < 100000)
begin
	if (len(@Name)>20) SET @Name = 'a' else SET @Name = @Name + char(round(rand() * @w, 0) + @l)
	SET @wage = round(rand() * 100000, 0 )
	insert into Trainers
	values (@Name, @n, @wage, @n)
	SET @n = @n + 1;
end

    alter table Trainers
  add bkey int 

    alter table Trainers
  add flag bit

select * from Trainers
--------------Ranking
declare @n int  = 0;
declare @r int  = 100000;
declare @Name nvarchar (50);
declare @a char = 'А', @z char = 'я', @w int, @l int
SET @w = ascii(@z) - ascii(@a);
SET @l = ascii(@a);
declare @lo int;
declare @dr int;
declare @wi int;
while (@n < 100000)
begin
	SELECT @Name = Name FROM Clubs where ID = @n
	Set @wi = @n / 2;
	set @lo = (100000 - @wi) / 2;
	set @dr = @lo / 2;
	insert into Ranking
	values (@Name, @wi, @lo,@dr,@r,  @n)
	SET @n = @n + 1;
	SET @r = @r - 1;
end



select * from Ranking

---------------------Players
DECLARE @n int = 0;
declare @Name nvarchar (50) = 'a';
declare @club int = 0;
declare @a char = 'А', @z char = 'я', @w int, @l int
SET @w = ascii(@z) - ascii(@a);
SET @l = ascii(@a);
DECLARE @age int = 20;
Declare @nat nvarchar(30);
declare @wage int;
declare @height int;
declare @weight int;
declare @counter3 int = 1;
declare @c int = 0;

while (@n < 2000000)
begin
	if (len(@Name)>20) SET @Name = 'a' else SET @Name = @Name + char(round(rand() * @w, 0) + @l)
	if (@age > 35) SET @age = 20 else SET @age = @age + 1
	SET @nat = CHOOSE (@counter3, 'Brazil', 'Spain', 'Belgium', 'Croatia', 'Uruguay', 'Slovenia', 'Poland', 'Germany', 'France', 'England', 'Russia', 'Italy')
	SET @height = 165 + 2 * round(rand() * 10, 0)
	SET @weight = 70 + round(rand() * 10, 0)
	SET @wage = round(rand() * 100000 + 4230, 0)
	insert into Players
	values (@c, @Name, @age, @nat, @height, @weight, @wage, @n)
	SET @n = @n + 1;
	IF (@counter3 = 11) SET @counter3 = 1 ELSE SET @counter3 = @counter3 + 1;
	IF (@club = 20) SET @c = @c + 1
	IF (@club = 20) SET @club = 1 ELSE SET @club = @club + 1;
end

select * from Players
---------------------Matches
declare @n int = 0;
declare @club int = 0;
declare @stadium int;
declare @home int;
declare @away int;
declare @champ nvarchar (50);
declare @counter3 int = 1;
declare @name1 nvarchar (50);
declare @name2 nvarchar (50);
declare @stadname nvarchar (50);
declare @sold int;
declare @cap int
declare @k nvarchar(10)

while (@n < 21915)
begin
	SELECT @name1 = Name FROM Clubs where ID = @club
	SELECT @name2 = Name FROM Clubs where ID = (@club + 1)
	SET @home = @n % 10
	SET @away = @home + 1;
	SET @stadium = IIF(@n % 2 = 0, @club, @club + 1)
	SELECT @stadname = Name FROM Stadiums where ID = @stadium
	SET @champ = CHOOSE (@counter3, 'Кубок мира', 'Кубок России', 'Матч Премьер', 'Лига Европы УЕФА', 'Кубок Испании', 'Кубок Англии', 'Товарищеский матч', 'Суперкубок Европы по футзалу', 'Кубок Германии', 'Кубок Бельгии', 'Кубок Хорватии', 'Кубок Аргентины')
	SELECT @cap = [Сapacity] FROM Stadiums where ID = @stadium
	Set @sold = @cap - round(rand() * 100 + 7, 0)
	select @k = KeyDate from [Date/Time] where @n = Match_ID
	insert into Matches
	values (@n, @club, @club + 1, @club, @club + 1, @stadium, @name1, @name2, @home, @away, @champ, @stadname, @sold, cast(@k as bigint))
	SET @n = @n + 1
	SET @club = @club + 2;
	IF (@counter3 = 11) SET @counter3 = 1 ELSE SET @counter3 = @counter3 + 1;
end

select * from Matches
delete from Matches
----------------------------DATE
declare @n int = 0;
declare @date date = '2000-01-01';
declare @mname nvarchar (50);
declare @dname nvarchar (50);
declare @year int
declare @quarter int
declare @month int
declare @week int
declare @day int
declare @time time
declare @key nvarchar(60)

while (@n < 6000)
begin
	set @year = YEAR(@date)
	set @month = MONTH(@date)
	set @day = DAY(@date)
	set @time = '17:00:00'
	if (@month < 4) set @quarter = 1
	if (@month > 9) set @quarter = 4
	if (@month > 3) and (@month < 7) set @quarter = 2
	if (@month > 6) and (@month < 10) set @quarter = 3
	set @week = DATEPART(wk, @date)
	set @mname = DATENAME(month,@date)
	set @dname = DATENAME(weekday, @date)
	if (@month < 10 and @day < 10)
	set @key = CAST(@year AS nvarchar(20)) + '0' + CAST(@month AS nvarchar(10)) + '0' + CAST(@day AS nvarchar(20))
	if (@month >= 10 and @day < 10)
	set @key = CAST(@year AS nvarchar(20)) + CAST(@month AS nvarchar(10)) + '0' + CAST(@day AS nvarchar(20))
	if (@month < 10 and @day >= 10)
	set @key = CAST(@year AS nvarchar(20)) + '0' + CAST(@month AS nvarchar(10)) + CAST(@day AS nvarchar(20))
	if (@month >= 10 and @day >= 10)
	set @key = CAST(@year AS nvarchar(20)) + CAST(@month AS nvarchar(10)) + CAST(@day AS nvarchar(20))
	insert into [Date/Time]
	values (@date, @year, @quarter, @month, @week, @day, @mname, @dname, cast(@key as bigint), @time)
	SET @n = @n + 1
	SET @date = dateADD(day, 1, @date)
end

select * from [Date/Time]
where Keydate = '20070509'
delete from [Date/Time]
where KeyDate > 20200101

alter table [Date/Time]
drop column Match_ID


    alter table Players
  drop column year

    alter table Players
  add bkey int 

    alter table Players
  add flag bit
--------------------PlayersInMatch
declare @n int = 0;
declare @pos nvarchar(5)
declare @g int = 0
declare @v int = 0
declare @r int = 0
declare @y int = 0
declare @m int
declare @p int
declare @counter3 int = 1;
declare @used int
declare @1 int
declare @2 int
declare @pl int = 0
declare @c int = 1
declare @id1 int
declare @id2 int
declare @k int
while (@n < 500000)
begin
	SET @pos = CHOOSE (@counter3, 'LW', 'GK', 'RCM', 'LF', 'RS', 'RCB', 'ST', 'CAM', 'CDM', 'LAM', 'CB')
	Select @1 = First_Team_Score from Matches where ID_Match = (@n / 22) 
	Select @2 = Second_Team_Score from Matches where ID_Match = (@n / 22) 
	Select @id1 = ID_Team1 from Matches where ID_Match = (@n / 22)
	Select @id2 = ID_Team2 from Matches where ID_Match = (@n / 22)
	if (@pl / 22 = @id1) SET @used = @1 else set @used = @2
	if (@c % 11 = 0) set @g = @used
	set @v = @n % 2
	select @k = KeyDate from [Date/Time] where @n / 22 = Match_ID
	if (@c % 10 = 0) set @r = 1
	if (@c % 5 = 0) set @y = 1
	insert into Players_In_Match
	values (@pl, cast(@k as bigint), @pos, @g, @v, @y, @r)
	SET @n = @n + 1
	IF (@counter3 = 11) SET @counter3 = 1 ELSE SET @counter3 = @counter3 + 1;
	IF (@c % 11 = 0) SET @pl = @pl + 11 ELSE SET @pl = @pl + 1;
	SET @c = @c + 1
	set @r = 0
	set @y = 0
	set @g = 0
end

select * from Players_In_Match
