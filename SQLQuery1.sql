CREATE TABLE Sponsors(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Sponsors PRIMARY KEY,
 name nvarchar(30) NOT NULL,
 service nvarchar(30) NOT NULL
 )
--Создание экземпляров
 INSERT Sponsors
	(name, service)
 VALUES
	('Лукойл', 'Топливо');

 INSERT Sponsors
	(name, service)
 VALUES
	('Газпром', 'Топливо');

 INSERT Sponsors
	(name, service)
 VALUES
	('Леон', 'Букмекер');


 INSERT Sponsors
	(name, service)
 VALUES
	('РЖД', 'Транспорт');

--Проверка
SELECT * FROM Sponsors

--Удаление экземпляра
DELETE FROM Sponsors
WHERE name = 'Леон';


CREATE TABLE Stadiums(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Stadiums PRIMARY KEY,
 name nvarchar(30) NOT NULL,
 country nvarchar(30) NOT NULL,
 city nvarchar(30) NOT NULL,
 capacity int NOT NULL
 )
 
 --Создание Экземпляров
 INSERT Stadiums
	(name, country, city, capacity)
 VALUES
	('Открытие Арена', 'Россия', 'Москва', 45360);


 INSERT Stadiums
	(name, country, city, capacity)
 VALUES
	('Газпром Арена', 'Россия', 'Санкт-Петербург', 62315);

 INSERT Stadiums
	(name, country, city, capacity)
 VALUES
	('Камп Ноу', 'Испания', 'Барселона', 99354);

 INSERT Stadiums
	(name, country, city, capacity)
 VALUES
	('Парк де Пренс', 'Франция', 'Париж', 49691);


--Удаление экземпляра
DELETE FROM Stadiums
WHERE capacity > 50000;

--Проверка
SELECT * FROM Stadiums

CREATE TABLE Clubs(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Clubs PRIMARY KEY,
 CONSTRAINT FK_Stadiums_StadiumsID FOREIGN KEY (Stadium_ID) REFERENCES Stadiums(ID) ON DELETE CASCADE,
 date_of_establishment date NOT NULL,
 name nvarchar(30) NOT NULL,
 )

  --Создание Экземпляров
 INSERT Clubs
	(date_of_establishment, name)
 VALUES
	(1922-04-18, 'Спартак');

 INSERT Clubs
	(date_of_establishment, name)
 VALUES
	(1925-05-25, 'Зенит');


 INSERT Clubs
	(date_of_establishment, name)
 VALUES
	(1899-11-29, 'Барселона');

 INSERT Clubs
	(date_of_establishment, name)
 VALUES
	(1970-08-12, 'Пари Сен-Жермен');



CREATE TABLE Clubs_Statistics(
 CONSTRAINT FK_Clubs_ClubID FOREIGN KEY (Club_ID) REFERENCES Clubs(ID) ON DELETE CASCADE,
 number_Of_Wins int,
 number_Of_Lesions int,
 draw_Number int,
 rank int
 )





CREATE TABLE Owners(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Owners PRIMARY KEY,
 CONSTRAINT FK_Owners_ClubID FOREIGN KEY (Club_ID) REFERENCES Clubs(ID) ON DELETE CASCADE,
 CONSTRAINT FK_Sponsors_Sponsor_ID FOREIGN KEY (Sponsor_ID) REFERENCES Sponsors(ID) ON DELETE CASCADE,
 full_name nvarchar(40) NOT NULL,
 date_of_birth date NOT NULL,
 club_Profit decimal NOT NULL,
 club_Purchase_Date date NOT NULL,
 club_Sale_Date date
 )

CREATE TABLE Players(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Players PRIMARY KEY,
 CONSTRAINT FK_Players_ClubID FOREIGN KEY (Club_ID) REFERENCES Clubs(ID) ON DELETE CASCADE,
 full_name nvarchar(40) NOT NULL,
 date_of_birth date NOT NULL,
 nationality nvarchar(20) Not NULL,
 height int NOT NULL,
 weight int NOT NULL,
 position_in_team nvarchar(3) NOT NULL,
 wage decimal NOT NULL,
 number_in_team int NOT NULL
 )

CREATE TABLE Transfer(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Transfer PRIMARY KEY,
 CONSTRAINT FK_Transfer_PlayerID FOREIGN KEY (Player_ID) REFERENCES Players(ID) ON DELETE CASCADE,
 CONSTRAINT FK_Transfer_ClubID_From FOREIGN KEY (Club_ID_From) REFERENCES Clubs(ID) ON DELETE CASCADE,
 CONSTRAINT FK_Transfer_ClubID_To FOREIGN KEY (Club_ID_To) REFERENCES Clubs(ID) ON DELETE CASCADE,
 transition_Cost decimal NOT NULL,
 transfer_Date_Start date NOT NULL,
 transfer_Date_Over date
 )

CREATE TABLE Trainers(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Trainers PRIMARY KEY,
 CONSTRAINT FK_Trainers_ClubID FOREIGN KEY (Club_ID) REFERENCES Clubs(ID) ON DELETE CASCADE,
 full_name nvarchar(40) NOT NULL,
 date_of_birth date NOT NULL,
 position nvarchar(30) NOT NULL,
 wage decimal NOT NULL,
 date_of_appointment date NOT NULL,
 dismissal_date date
 )
CREATE TABLE Match(
ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Match PRIMARY KEY,
CONSTRAINT FK_Match_ClubID_First FOREIGN KEY (Club_ID_First) REFERENCES Clubs(ID) ON DELETE CASCADE,
CONSTRAINT FK_Match_ClubID_Second FOREIGN KEY (Club_ID_Second) REFERENCES Clubs(ID) ON DELETE CASCADE,
CONSTRAINT FK_Match_TrainerID_First FOREIGN KEY (Trainer_ID_First) REFERENCES Trainers(ID) ON DELETE CASCADE,
CONSTRAINT FK_Match_TrainerID_Second FOREIGN KEY (Trainer_ID_Second) REFERENCES Trainers(ID) ON DELETE CASCADE,
CONSTRAINT FK_Match_StadiumsID FOREIGN KEY (Stadium_ID) REFERENCES Stadiums(ID) ON DELETE CASCADE,
date_of_match datetime NOT NULL,
score nvarchar(5)
)
CREATE TABLE Players_In_Match(
CONSTRAINT FK_Players_In_Match_MatchID FOREIGN KEY (Match_ID) REFERENCES Match(ID) ON DELETE CASCADE,
CONSTRAINT FK_Players_In_Match_PlayerID FOREIGN KEY (Player_ID) REFERENCES Players(ID) ON DELETE CASCADE,
composition nvarchar(10) NOT NULL,
position_in_match nvarchar(5) NOT NULL,
number_of_goals int NOT NULL,
number_of_violations int NOT NULL,
number_of_yellow_cards int NOT NULL,
number_of_red_cards int NOT NULL
)
CREATE TABLE Injured_Players(
CONSTRAINT FK_Injured_Players_PlayerID FOREIGN KEY (Player_ID) REFERENCES Players(ID) ON DELETE CASCADE,
CONSTRAINT FK_Injured_Players_MatchID FOREIGN KEY (Match_ID) REFERENCES Match(ID) ON DELETE CASCADE,
type_of_injury nvarchar(20) NOT NULL,
recovery_time int NOT NULL
)