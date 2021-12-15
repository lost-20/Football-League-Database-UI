USE Football_League;
GO

CREATE TABLE Sponsors(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Sponsors PRIMARY KEY,
 name nvarchar(30) NOT NULL,
 service nvarchar(30) NOT NULL
 )



CREATE TABLE Stadiums(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Stadiums PRIMARY KEY,
 name nvarchar(30) NOT NULL,
 country nvarchar(30) NOT NULL,
 city nvarchar(30) NOT NULL,
 capacity int NOT NULL
 )
 

CREATE TABLE Clubs(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Clubs PRIMARY KEY,
 date_of_establishment date NOT NULL,
 name nvarchar(30) NOT NULL,
 Stadium_ID int
 )

 ALTER TABLE Clubs ADD FOREIGN KEY(Stadium_ID) REFERENCES Stadiums(ID) ON UPDATE CASCADE;



CREATE TABLE Clubs_Statistics(
 rank int NOT NULL PRIMARY KEY,
 Club_ID int,
 number_of_wins int,
 number_of_lesions int,
 draw_number int
 )

  ALTER TABLE Clubs_Statistics ADD FOREIGN KEY(Club_ID) REFERENCES Clubs(ID) ON UPDATE CASCADE;




CREATE TABLE Owners(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Owners PRIMARY KEY,
 Club_ID int,
 Sponsor_ID int,
 full_name nvarchar(40) NOT NULL,
 date_of_birth date NOT NULL,
 club_Profit decimal NOT NULL,
 club_Purchase_Date date NOT NULL,
 club_Sale_Date date
 )

 ALTER TABLE Owners ADD FOREIGN KEY(Club_ID) REFERENCES Clubs(ID) ON UPDATE CASCADE;
 ALTER TABLE Owners ADD FOREIGN KEY(Sponsor_ID) REFERENCES Sponsors(ID) ON UPDATE CASCADE;






CREATE TABLE Players(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Players PRIMARY KEY,
 Club_ID int,
 name nvarchar(40) NOT NULL,
 age int NOT NULL,
 nationality nvarchar(30) Not NULL,
 wage decimal NOT NULL,
 position_in_team varchar(3) NOT NULL,
 number_in_team int NOT NULL,
 height int NOT NULL,
 weight int NOT NULL
 )

  ALTER TABLE Players ADD FOREIGN KEY(Club_ID) REFERENCES Clubs(ID) ON UPDATE NO ACTION;

 


CREATE TABLE Transfer(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Transfer PRIMARY KEY,
 Player_ID int,
 Club_ID_From int,
 Club_ID_To int,
 transition_Cost decimal NOT NULL,
 transfer_Date_Start date NOT NULL,
 transfer_Date_Over date
 )

   ALTER TABLE Transfer ADD FOREIGN KEY(Player_ID) REFERENCES Players(ID) ON UPDATE NO ACTION;
   ALTER TABLE Transfer ADD FOREIGN KEY(Club_ID_From) REFERENCES Clubs(ID) ON UPDATE NO ACTION;
   ALTER TABLE Transfer ADD FOREIGN KEY(Club_ID_To) REFERENCES Clubs(ID) ON UPDATE NO ACTION;





CREATE TABLE Trainers(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Trainers PRIMARY KEY,
 Club_ID int,
 full_name nvarchar(40) NOT NULL,
 date_of_birth date NOT NULL,
 position nvarchar(30) NOT NULL,
 wage decimal NOT NULL,
 date_of_appointment date NOT NULL,
 dismissal_date date
 )

  ALTER TABLE Trainers ADD FOREIGN KEY(Club_ID) REFERENCES Clubs(ID) ON UPDATE NO ACTION;

 




CREATE TABLE Match(
ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Match PRIMARY KEY,
Club_ID_First int,
Club_ID_Second int,
Trainer_ID_First int,
Trainer_ID_Second int,
Stadium_ID int,
date_of_match datetime NOT NULL,
home_score int,
away_score int
)

  ALTER TABLE Match ADD FOREIGN KEY(Trainer_ID_First) REFERENCES Trainers(ID) ON UPDATE NO ACTION;
  ALTER TABLE Match ADD FOREIGN KEY(Trainer_ID_Second) REFERENCES Trainers(ID) ON UPDATE NO ACTION;
  ALTER TABLE Match ADD FOREIGN KEY(Club_ID_First) REFERENCES Clubs(ID) ON UPDATE NO ACTION;
  ALTER TABLE Match ADD FOREIGN KEY(Club_ID_Second) REFERENCES Clubs(ID) ON UPDATE NO ACTION;
  ALTER TABLE Match ADD FOREIGN KEY(Stadium_ID) REFERENCES Stadiums(ID) ON UPDATE CASCADE;




CREATE TABLE Players_In_Match(
Match_ID int,
Player_ID int,
composition nvarchar(10) NOT NULL,
position_in_match nvarchar(5) NOT NULL,
number_of_goals int NOT NULL,
number_of_violations int NOT NULL,
number_of_yellow_cards int NOT NULL,
number_of_red_cards int NOT NULL
CONSTRAINT PK_Players_In_Match PRIMARY KEY (Match_ID, Player_ID)
)


 ALTER TABLE Players_In_Match ADD FOREIGN KEY(Match_ID) REFERENCES Match(ID) ON UPDATE CASCADE;
 ALTER TABLE Players_In_Match ADD FOREIGN KEY(Player_ID) REFERENCES Players(ID) ON UPDATE CASCADE;



CREATE TABLE Injured_Players(
Player_ID int,
Match_ID int,
type_of_injury nvarchar(40) NOT NULL,
recovery_time int NOT NULL,
CONSTRAINT PK_Injured_Players PRIMARY KEY (Match_ID, Player_ID)
)


 ALTER TABLE Injured_Players ADD FOREIGN KEY(Match_ID) REFERENCES Match(ID) ON UPDATE CASCADE;
 ALTER TABLE Injured_Players ADD FOREIGN KEY(Player_ID) REFERENCES Players(ID) ON UPDATE CASCADE;






 ---------------------------------------------------------------------------------------------------Создание экземпляров
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
	('The Coca-Cola Company', 'Напиток');

 INSERT Sponsors
	(name, service)
 VALUES
	('PepsiCo', 'Напиток');


 INSERT Sponsors
	(name, service)
 VALUES
	('РЖД', 'Транспорт');


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




  --Создание Экземпляров
 INSERT Clubs
	(date_of_establishment, name, Stadium_ID)
 VALUES
	('1922-04-18', 'Спартак', 1);


 INSERT Clubs
	(date_of_establishment, name, Stadium_ID)
 VALUES
	('1925-05-25', 'Зенит', 2);


 INSERT Clubs
	(date_of_establishment, name, Stadium_ID)
 VALUES
	('1899-11-29', 'Барселона', 3);

 INSERT Clubs
	(date_of_establishment, name, Stadium_ID)
 VALUES
	('1970-08-12', 'Пари Сен-Жермен', 4);


	  --Заполнение

 INSERT Clubs_Statistics
	(rank, Club_ID, number_of_wins, number_of_lesions, draw_number)
 VALUES
	(1, 1, 3, 0, 0);

 INSERT Clubs_Statistics
	(rank, Club_ID, number_of_wins, number_of_lesions, draw_number)
 VALUES
	(2, 3, 2, 1, 0);

 INSERT Clubs_Statistics
	(rank, Club_ID, number_of_wins, number_of_lesions, draw_number)
 VALUES
	(3, 4, 0, 2, 1);

 INSERT Clubs_Statistics
	(rank, Club_ID, number_of_wins, number_of_lesions, draw_number)
 VALUES
	(4, 2, 0, 2, 1);




  --Заполнение
  INSERT Owners
	(Club_ID, Sponsor_ID, full_name, date_of_birth, club_Profit, club_Purchase_Date)
 VALUES
	(1, 1, 'Федун Леонид Арнольдович', '1956-04-05', 130900000, '2003-01-01');

  INSERT Owners
	(Club_ID, Sponsor_ID, full_name, date_of_birth, club_Profit, club_Purchase_Date)
 VALUES
	(2, 2, 'Медведев Александр Иванович', '1955-08-14', 167800000, '2019-01-01');

  INSERT Owners
	(Club_ID, Sponsor_ID, full_name, date_of_birth, club_Profit, club_Purchase_Date)
 VALUES
	(3, 5, 'Жозеп Мария Бартомеу-и-Флорета', '1963-02-06', 608000000, '2014-01-23');

  INSERT Owners
	(Club_ID, Sponsor_ID, full_name, date_of_birth, club_Profit, club_Purchase_Date)
 VALUES
	(4, 6, 'Рыболовлев Дмитрий Евгеньевич', '1966-11-22', 557000000, '2011-01-01');





  --Заполнение
    INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'L. Messi',	31,	'Argentina',	565,	'RF',	10,	180,	80);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'Cristiano Ronaldo',	33,	'Portugal',	405,	'ST',	7,	190,	80);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'Neymar Jr',	26,	'Brazil',	290,	'LW',	10,	178,	78);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'De Gea',	27,	'Spain',	260,	'GK',	1,	180,	80);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1, 	'K. De Bruyne',	27,	'Belgium',	355,	'RCM',	7,	190,	88);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'E. Hazard',	27,	'Belgium',	340,	'LF',	10,	160,	70);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'L. Modrić',	32,	'Croatia',	420,	'RCM',	10,	183,	75);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'L. Suárez',	31,	'Uruguay',	455,	'RS',	9,	184,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'Sergio Ramos',	32,	'Spain',	380,	'RCB',	15,	180,	88);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'J. Oblak',	25,	'Slovenia',	94,	'GK',	1,	178,	90);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,'R. Lewandowski',	29,	'Poland',	205,	'ST',	9,	175,	76);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'T. Kroos',	28,	'Germany',	355,	'LCM',	8,	177,	82);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'D. Godín',	32,	'Uruguay',	125,	'CB',	10,	183,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 1,	'David Silva',	32,	'Spain',	285,	'LCM',	21,	180,	74);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 1,	'N. Kanté',	27,	'France',	225,	'LDM',	13,	169,	72);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 1,	'P. Dybala',	24,	'Argentina',	205,	'LF',	21,	173,	80);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 1,	'H. Kane',	24,	'England',	205,	'ST',	9,	192,	89);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'A. Griezmann',	27,	'France',	145,	'CAM',	7,	179,	84);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(1,	'M. ter Stegen',	26,	'Germany',	240,	'GK',	22,	177,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 1,	'T. Courtois',	26,	'Belgium',	240,	'GK',	1,	185,	80);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 2,	'Sergio Busquets',	29,	'Spain',	315,	'CDM',	5,	181,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'E. Cavani',	31,	'Uruguay',	200,	'LS',	21,	189,	90);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'M. Neuer',	32,	'Germany',	130,	'GK',	1,	177,	74);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 2,	'S. Agüero',	30,	'Argentina',	300,	'ST',	10,	187,	87);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 2,	'G. Chiellini',	33,	'Italy',	215,	'LCB',	3,	189,	90);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 2,	'K. Mbappé',	19,	'France',	100,	'RM',	10,	166,	70);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 2,	'M. Salah',	26,	'Egypt',	255,	'RM',	10,	188,	80);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'Casemiro',	26,	'Brazil',	285,	'CDM',	14,	183,	79);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'J. Rodríguez',	26,	'Colombia',	315,	'LAM',	10,	179,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'L. Insigne',	27,	'Italy',	165,	'LW',	10,	178,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'Isco',	26,	'Spain',	315,	'LW',	22,	168,	70);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'C. Eriksen',	26,	'Denmark',	205,	'CAM',	10,	180,	78);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'Coutinho',	26,	'Brazil',	340,	'LW',	7,	168,	72);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'P. Aubameyang',	29,	'Gabon',	265,	'LM',	14,	177,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'M. Hummels',	29,	'Germany',	160,	'LCB',	5,	188,	88);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'Marcelo',	30,	'Brazil',	285,	'LB',	12,	184,	84);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'G. Bale',	28,	'Wales',	355,	'ST',	11,	177,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'H. Lloris',	31,	'France',	150,	'GK',	1,	190,	90);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'G. Higuaín',	30,	'Argentina',	245,	'LS',	9,	179,	79);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(2,	'Thiago Silva',	33,	'Brazil',	165,	'RCB',	2,	188,	88);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'S. Handanovič',	33,	'Slovenia',	110,	'GK',	1,	174,	74);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'G. Buffon',	40,	'Italy',	77,	'GK',	1,	182,	82);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'S. Umtiti',	24,	'France',	205,	'CB',	23,	194,	90);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'M. Icardi',	25,	'Argentina',	130,	'ST',	9,	189,	89);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'K. Koulibaly',	27,	'Senegal',	115,	'LCB',	26,	169,	72);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'P. Pogba',	25,	'France',	210,	'RDM',	6,	177,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'K. Navas',	31,	'Costa Rica',	195,	'GK',	1,	167,	73);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'R. Lukaku',	25,	'Belgium',	230,	'ST',	9,	182,	82);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'C. Immobile',	28,	'Italy',	115,	'ST',	17,	180,	80);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'Jordi Alba',	29,	'Spain',	250,	'LB',	18,	179,	79);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'D. Mertens',	31,	'Belgium',	135,	'RF',	14,	193,	90);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'J. Vertonghen',	31,	'Belgium',	155,	'LCB',	5,	183,	79);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'M. Hamšík',	30,	'Slovakia',	125,	'LCM',	17,	188,	88);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'I. Rakitić',	30,	'Croatia',	260,	'RCM',	4,	176,	76);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'Piqué',	31,	'Spain',	240,	'RCB',	3,	165,	70);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'L. Sané',	22,	'Germany',	195,	'LW',	19,	188,	88);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'Bernardo Silva',	23,	'Portugal',	180,	'RW',	11,	189,	89);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'Ederson',	24,	'Brazil',	125,	'GK',	31,	187,	80);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'S. Mané',	26,	'Senegal',	195,	'LM',	10,	178,	72);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(3,	'V. van Dijk',	26,	'Netherlands',	165,	'LCB',	4,	187,	83);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'R. Sterling',	23,	'England',	195,	'RW',	10,	174,	77);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'Roberto Firmino',	26,	'Brazil',	195,	'CAM',	9,	178,	78);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'R. Varane',	25,	'France',	210,	'RCB',	4,	190,	90);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'M. Verratti',	25,	'Italy',	135,	'LCM',	6,	176,	77);


      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'Alex Sandro',	27,	'Brazil',	160,	'LB',	12,	155,	70);

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'Douglas Costa',	27,	'Brazil',	175,	'LM',	11,	176,	77)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'T. Müller',	28,	'Germany',	135,	'CAM',	13,	188,	90)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 4,	'Thiago',	27,	'Spain',	130,	'CM',	19,	175,	77)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 4,	'M. Reus',	29,	'Germany',	100,	'LM',	11,	169,	70)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'Azpilicueta',	28,	'Spain',	175,	'RB',	14,	174,	80)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'L. Bonucci',	31,	'Italy',	160,	'RCB',	19,	174,	76)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'T. Alderweireld',	29,	'Belgium',	150,	'RCB',	2,	179,	80)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'M. Pjanić',	28,	'Bosnia Herzegovina',	180,	'CDM',	5,	165,	78)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 4,	'M. Benatia',	31,	'Morocco',	160,	'CB',	4,	188,	89)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	( 4,	'M. Özil',	29,	'Germany',	190,	'CAM',	10,	174,	77)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'Fernandinho',	33,	'Brazil',	185,	'CDM',	25,	198,	94)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'Iniesta',	34,	'Spain',	21,	'LF',	8,	178,	77)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'M. Škriniar',	23,	'Slovakia',	82,	'LCB',	37,	186,	90)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'S. Milinković-Savić',	23,	'Serbia',	73,	'CM',	21,	167,	72)

      INSERT Players
	(Club_ID, name, age, nationality, wage, position_in_team, number_in_team, height, weight)
 VALUES
	(4,	'Marco Asensio',	22,	'Spain',	215,	'RW',	10,	178,	85)











    --Заполнение

    INSERT Trainers
	(Club_ID, full_name, date_of_birth, position, wage, date_of_appointment)
 VALUES
	(1, 'Кононов Олег Георгиевич', '1966-03-23', 'Главный тренер', 250000, '2014-11-12');

    INSERT Trainers
	(Club_ID, full_name, date_of_birth, position, wage, date_of_appointment)
 VALUES
	(2, 'Семак Сергей Богданович', '1976-02-27', 'Главный тренер', 2000000, '2018-05-29');

    INSERT Trainers
	(Club_ID, full_name, date_of_birth, position, wage, date_of_appointment)
 VALUES
	(3, 'Вальверде Эрнесто', '1964-02-09', 'Тренер', 3500000, '2017-01-01');

    INSERT Trainers
	(Club_ID, full_name, date_of_birth, position, wage, date_of_appointment)
 VALUES
	(4, 'Тухель Томас', '1973-08-29', 'Главный тренер', 2500000, '2018-05-14');

 



 --Заполнение
      INSERT Transfer
	(Player_ID, Club_ID_From, Club_ID_To, transition_Cost, transfer_Date_Start, transfer_Date_Over)
 VALUES
	(1,	3,	1,	2000000, '2018-05-06',	'2018-12-12');

      INSERT Transfer
	(Player_ID, Club_ID_From, Club_ID_To, transition_Cost, transfer_Date_Start, transfer_Date_Over)
 VALUES
	(56,	1,	3,	2500000, '2019-05-06',	NULL);

      INSERT Transfer
	(Player_ID, Club_ID_From, Club_ID_To, transition_Cost, transfer_Date_Start, transfer_Date_Over)
 VALUES
	(30,	4,	2,	1000000, '2018-05-06',	'2019-01-01');



  --Заполнение
 INSERT Match
	(Club_ID_First, Club_ID_Second, Trainer_ID_First, Trainer_ID_Second, Stadium_ID, date_of_match, home_score, away_score)
 VALUES
	(1, 3, 1, 3, 1, '2019-05-23T14:25:10', 2, 1);

 INSERT Match
	(Club_ID_First, Club_ID_Second, Trainer_ID_First, Trainer_ID_Second, Stadium_ID, date_of_match, home_score, away_score)
 VALUES
	(1, 4, 1, 4, 4, '2019-05-27T14:25:10', 1, 0);

 INSERT Match
	(Club_ID_First, Club_ID_Second, Trainer_ID_First, Trainer_ID_Second, Stadium_ID, date_of_match, home_score, away_score)
 VALUES
	(1, 2, 1, 2, 1, '2019-06-23T14:25:10', 1, 0);


 INSERT Match
	(Club_ID_First, Club_ID_Second, Trainer_ID_First, Trainer_ID_Second, Stadium_ID, date_of_match, home_score, away_score)
 VALUES
	(3, 4, 3, 4, 3, '2019-05-23T18:25:10', 3, 2);

 INSERT Match
	(Club_ID_First, Club_ID_Second, Trainer_ID_First, Trainer_ID_Second, Stadium_ID, date_of_match, home_score, away_score)
 VALUES
	(3, 2, 3, 2, 2, '2019-07-23T15:25:10', 2, 0);

INSERT Match
	(Club_ID_First, Club_ID_Second, Trainer_ID_First, Trainer_ID_Second, Stadium_ID, date_of_match, home_score, away_score)
 VALUES
	(4, 2, 4, 2, 4, '2019-05-17T14:25:10', 1, 1);






 --Заполнение

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 1, 'Primary', 'CAM', 1, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 2, 'Primary', 'CB', 1, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 3, 'Primary', 'CDM', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 4, 'Primary', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 5, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 6, 'Primary', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 7, 'Primary', 'LAM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 8, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 9, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 10, 'Primary', 'ST', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 11, 'Primary', 'RF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 12, 'Alternate', 'ST', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 13, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 14, 'Alternate', 'RF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 15, 'Reserve', 'CF', 0, 0, 0, 0);


INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 41, 'Primary', 'CAM', 1, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 42, 'Primary', 'CB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 43, 'Primary', 'CDM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 44, 'Primary', 'CF', 0, 2, 2, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 45, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 46, 'Primary', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 47, 'Primary', 'LAM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 48, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 49, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 50, 'Primary', 'ST', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 51, 'Primary', 'RF', 0, 0, 0, 0);


INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 52, 'Alternate', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 54, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 55, 'Alternate', 'CAM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(1, 56, 'Reserve', 'CF', 0, 0, 0, 0);



--2


INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 1, 'Primary', 'CAM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 2, 'Primary', 'CB', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 3, 'Primary', 'CDM', 1, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 4, 'Primary', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 5, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 6, 'Primary', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 7, 'Primary', 'LAM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 8, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 9, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 10, 'Primary', 'ST', 0, 1, 0, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 11, 'Primary', 'RF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 12, 'Alternate', 'ST', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 13, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 14, 'Alternate', 'RF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 15, 'Reserve', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 61, 'Primary', 'CAM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 62, 'Primary', 'CB', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 63, 'Primary', 'CDM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 64, 'Primary', 'CF', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 65, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 66, 'Primary', 'GK', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 67, 'Primary', 'LAM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 68, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 69, 'Primary', 'LCB', 0, 3, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 70, 'Primary', 'ST', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 71, 'Primary', 'RF', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 72, 'Alternate', 'RF', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 73, 'Alternate', 'LB', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 74, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(2, 75, 'Reserve', 'ST', 0, 0, 0, 0);

--3

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 1, 'Primary', 'CAM', 1, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 2, 'Primary', 'CB', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 3, 'Primary', 'CDM', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 4, 'Primary', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 5, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 6, 'Primary', 'GK', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 7, 'Primary', 'LAM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 8, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 9, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 10, 'Primary', 'ST', 0, 1, 0, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 11, 'Primary', 'RF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 12, 'Alternate', 'ST', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 13, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 14, 'Alternate', 'RF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 15, 'Reserve', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 21, 'Primary', 'CAM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 22, 'Primary', 'CB', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 23, 'Primary', 'CDM', 0, 1, 0, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 24, 'Primary', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 25, 'Primary', 'CM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 26, 'Primary', 'GK', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 27, 'Primary', 'LAM', 0, 2, 2, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 28, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 29, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 30, 'Primary', 'ST', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 31, 'Primary', 'RF', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 32, 'Alternate', 'LAM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 33, 'Alternate', 'CDM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 34, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(3, 35, 'Reserve', 'LAM', 0, 0, 0, 0);

--4

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 41, 'Primary', 'CAM', 1, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 42, 'Primary', 'CB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 43, 'Primary', 'CDM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 44, 'Primary', 'CF', 0, 2, 2, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 45, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 46, 'Primary', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 47, 'Primary', 'LAM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 48, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 49, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 50, 'Primary', 'ST', 1, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 51, 'Primary', 'RF', 0, 0, 0, 0);


INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 52, 'Alternate', 'CF', 1, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 54, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 55, 'Alternate', 'CAM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 56, 'Reserve', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 61, 'Primary', 'CAM', 2, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 62, 'Primary', 'CB', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 63, 'Primary', 'CDM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 64, 'Primary', 'CF', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 65, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 66, 'Primary', 'GK', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 67, 'Primary', 'LAM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 68, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 69, 'Primary', 'LCB', 0, 3, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 70, 'Primary', 'ST', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 71, 'Primary', 'RF', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 72, 'Alternate', 'RF', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 73, 'Alternate', 'LB', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 74, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(4, 75, 'Reserve', 'ST', 0, 0, 0, 0);

--5

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 41, 'Primary', 'CAM', 0, 2, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 42, 'Primary', 'CB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 43, 'Primary', 'CDM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 44, 'Primary', 'CF', 0, 2, 2, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 45, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 46, 'Primary', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 47, 'Primary', 'LAM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 48, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 49, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 50, 'Primary', 'ST', 1, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 51, 'Primary', 'RF', 0, 0, 0, 0);


INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 52, 'Alternate', 'CF', 1, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 54, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 55, 'Alternate', 'CAM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 56, 'Reserve', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 21, 'Primary', 'CAM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 22, 'Primary', 'CB', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 23, 'Primary', 'CDM', 0, 1, 0, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 24, 'Primary', 'CF', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 25, 'Primary', 'CM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 26, 'Primary', 'GK', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 27, 'Primary', 'LAM', 0, 2, 2, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 28, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 29, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 30, 'Primary', 'ST', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 31, 'Primary', 'RF', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 32, 'Alternate', 'LAM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 33, 'Alternate', 'CDM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 34, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(5, 35, 'Reserve', 'LAM', 0, 0, 0, 0);

--6

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 61, 'Primary', 'CAM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 62, 'Primary', 'CB', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 63, 'Primary', 'CDM', 1, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 64, 'Primary', 'CF', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 65, 'Primary', 'CM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 66, 'Primary', 'GK', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 67, 'Primary', 'LAM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 68, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 69, 'Primary', 'LCB', 0, 3, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 70, 'Primary', 'ST', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 71, 'Primary', 'RF', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 72, 'Alternate', 'RF', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 73, 'Alternate', 'LB', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 74, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 75, 'Reserve', 'ST', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 21, 'Primary', 'CAM', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 22, 'Primary', 'CB', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 23, 'Primary', 'CDM', 0, 1, 0, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 24, 'Primary', 'CF', 1, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 25, 'Primary', 'CM', 0, 1, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 26, 'Primary', 'GK', 0, 1, 1, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 27, 'Primary', 'LAM', 0, 2, 2, 1);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 28, 'Primary', 'LB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 29, 'Primary', 'LCB', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 30, 'Primary', 'ST', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 31, 'Primary', 'RF', 0, 2, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 32, 'Alternate', 'LAM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 33, 'Alternate', 'CDM', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 34, 'Alternate', 'GK', 0, 0, 0, 0);

INSERT Players_In_Match
	(Match_ID, Player_ID, composition, position_in_match, number_of_goals, number_of_violations, number_of_yellow_cards, number_of_red_cards)
 VALUES
	(6, 35, 'Reserve', 'LAM', 0, 0, 0, 0);








  --Заполнение
 INSERT Injured_Players
	(Player_ID, Match_ID, type_of_injury, recovery_time)
 VALUES
	(10, 1, 'Вывих колена', 7);

 INSERT Injured_Players
	(Player_ID, Match_ID, type_of_injury, recovery_time)
 VALUES
	(10, 2, 'Растяжение мышц голени', 7);

 INSERT Injured_Players
	(Player_ID, Match_ID, type_of_injury, recovery_time)
 VALUES
	(41, 5, 'Перелом руки', 50);

 INSERT Injured_Players
	(Player_ID, Match_ID, type_of_injury, recovery_time)
 VALUES
	(34, 6, 'Вывих колена', 10);




	-------------------------------------------------------------------------------Проверка и удаление
	SELECT * FROM Sponsors;

	SELECT * FROM Stadiums;

	SELECT * FROM Clubs;

	SELECT * FROM Clubs_Statistics;

	SELECT * FROM Trainers;

	SELECT * FROM Owners;

	SELECT * FROM Transfer;

	SELECT * FROM Players;

	SELECT * FROM Match;

	SELECT * FROM Players_In_Match;

	SELECT * FROM Injured_Players;



	DELETE FROM Injured_Players
	WHERE Match_ID = 2;

	 INSERT Injured_Players
	(Player_ID, Match_ID, type_of_injury, recovery_time)
 VALUES
	(66, 2, 'Растяжение мышц голени', 7);

	DELETE FROM Injured_Players;