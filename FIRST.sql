CREATE TABLE Sponsors(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Sponsors PRIMARY KEY,
 Name nvarchar(30) NOT NULL,
 Service nvarchar(30) NOT NULL
 )

CREATE TABLE Stadiums(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Stadiums PRIMARY KEY,
 Name nvarchar(30) NOT NULL,
 Country nvarchar(30) NOT NULL,
 City nvarchar(30) NOT NULL,
 Capacity int NOT NULL
 )

CREATE TABLE Clubs(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Clubs PRIMARY KEY,
 CONSTRAINT FK_Stadiums_StadiumsID FOREIGN KEY (Stadium_ID) REFERENCES Stadiums(ID) ON DELETE CASCADE,
 Date_Of_Establishment date NOT NULL,
 Name nvarchar(30) NOT NULL,
 Country nvarchar(30) NOT NULL,
 City nvarchar(30) NOT NULL
 )

CREATE TABLE Club_Statistics(
 CONSTRAINT FK_Clubs_ClubID FOREIGN KEY (Club_ID) REFERENCES Clubs(ID) ON DELETE CASCADE,
 Number_Of_Wins int,
 Number_Of_Lesions int,
 Draw_Number int,
 Rank int
 )

CREATE TABLE Owners(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Owners PRIMARY KEY,
 CONSTRAINT FK_Owners_ClubID FOREIGN KEY (Club_ID) REFERENCES Clubs(ID) ON DELETE CASCADE,
 CONSTRAINT FK_Sponsors_Sponsor_ID FOREIGN KEY (Sponsor_ID) REFERENCES Sponsors(ID) ON DELETE CASCADE,
 Full_Name nvarchar(40) NOT NULL,
 Date_Of_Birth date NOT NULL,
 Club_Profit decimal NOT NULL,
 Club_Purchase_Date date NOT NULL,
 Club_Sale_Date date
 )

CREATE TABLE Players(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Players PRIMARY KEY,
 CONSTRAINT FK_Players_ClubID FOREIGN KEY (Club_ID) REFERENCES Clubs(ID) ON DELETE CASCADE,
 Full_Name nvarchar(40) NOT NULL,
 Date_Of_Birth date NOT NULL,
 Nationality nvarchar(20) Not NULL,
 Height int NOT NULL,
 Weight int NOT NULL,
 Position_In_Team nvarchar(3) NOT NULL,
 Wage decimal NOT NULL,
 Number_In_Team int NOT NULL
 )

CREATE TABLE Transfer(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Transfer PRIMARY KEY,
 CONSTRAINT FK_Transfer_PlayerID FOREIGN KEY (Player_ID) REFERENCES Players(ID) ON DELETE CASCADE,
 CONSTRAINT FK_Transfer_ClubID_From FOREIGN KEY (Club_ID_From) REFERENCES Clubs(ID) ON DELETE CASCADE,
 CONSTRAINT FK_Transfer_ClubID_To FOREIGN KEY (Club_ID_To) REFERENCES Clubs(ID) ON DELETE CASCADE,
 Transition_Cost decimal NOT NULL,
 Transfer_Date_Start date NOT NULL,
 Transfer_Date_Over date
 )

CREATE TABLE Trainers(
 ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Trainers PRIMARY KEY,
 CONSTRAINT FK_Trainers_ClubID FOREIGN KEY (Club_ID) REFERENCES Clubs(ID) ON DELETE CASCADE,
 Full_Name nvarchar(40) NOT NULL,
 Date_Of_Birth date NOT NULL,
 Position nvarchar(30) NOT NULL,
 Wage decimal NOT NULL,
 Date_Of_Appointment date NOT NULL,
 Dismissal_Date date
 )
CREATE TABLE Match(
ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Match PRIMARY KEY,
CONSTRAINT FK_Match_ClubID_First FOREIGN KEY (Club_ID_First) REFERENCES Clubs(ID) ON DELETE CASCADE,
CONSTRAINT FK_Match_ClubID_Second FOREIGN KEY (Club_ID_Second) REFERENCES Clubs(ID) ON DELETE CASCADE,
CONSTRAINT FK_Match_TrainerID_First FOREIGN KEY (Trainer_ID_First) REFERENCES Trainers(ID) ON DELETE CASCADE,
CONSTRAINT FK_Match_TrainerID_Second FOREIGN KEY (Trainer_ID_Second) REFERENCES Trainers(ID) ON DELETE CASCADE,
CONSTRAINT FK_Match_StadiumsID FOREIGN KEY (Stadium_ID) REFERENCES Stadiums(ID) ON DELETE CASCADE,
Date_Of_Match datetime NOT NULL,
Score nvarchar(5)
)
CREATE TABLE Players_In_Match(
CONSTRAINT FK_Players_In_Match_MatchID FOREIGN KEY (Match_ID) REFERENCES Match(ID) ON DELETE CASCADE,
CONSTRAINT FK_Players_In_Match_PlayerID FOREIGN KEY (Player_ID) REFERENCES Players(ID) ON DELETE CASCADE,
Composition nvarchar(10) NOT NULL,
Position_In_Match nvarchar(5) NOT NULL,
Number_Of_Goals int NOT NULL,
Number_Of_Violations int NOT NULL,
Number_Of_Yellow_Cards int NOT NULL,
Number_Of_Red_Cards int NOT NULL
)
CREATE TABLE Injured_Players(
CONSTRAINT FK_Injured_Players_PlayerID FOREIGN KEY (Player_ID) REFERENCES Players(ID) ON DELETE CASCADE,
CONSTRAINT FK_Injured_Players_MatchID FOREIGN KEY (Match_ID) REFERENCES Match(ID) ON DELETE CASCADE,
Type_Of_Injury nvarchar(20) NOT NULL,
Recovery_Time int NOT NULL
)