SET STATISTICS IO ON;
SET STATISTICS TIME ON;




SELECT ID, name FROM Sponsors
WHERE ID = 100003;



CREATE CLUSTERED Index Cl_Pl ON Players(ID)
CREATE CLUSTERED Index Cl_Cl ON Clubs(ID)


SELECT * FROM Players
WHERE ID = 300003

SELECT * FROM Clubs
WHERE ID = 150008



SELECT name, age, position_in_team
FROM Players
Where name like 'aa%' AND age < 30






CREATE Index N_Index_Pl ON Players (name, age)



SELECT Stadium_ID, date_of_establishment
FROM Clubs
Where name like '1%'


CREATE Index N_Index_Cl ON Clubs (name) INCLUDE (date_of_establishment, Stadium_ID)


CREATE UNIQUE Index N_Index_Uniq ON Trainers (date_of_birth);

SELECT full_name, date_of_birth FROM Trainers
WHERE date_of_birth = '1969-01-02'


SELECT Club_ID, Sponsor_ID, date_of_birth, club_Profit, club_Purchase_Date,full_name FROM Owners
WHERE full_name like 'aÅ%'


CREATE INDEX N_Index_Own 
ON Owners (full_name)  
INCLUDE (Club_ID, Sponsor_ID, date_of_birth, club_Profit, club_Purchase_Date);  



SELECT wage FROM Trainers
WHERE wage > 800



CREATE NONCLUSTERED INDEX N_Index_trainers
    ON Trainers (wage)  
    WHERE wage > 800; 

--UPDATE Trainers
--SET date_of_birth = '1949-01-01'
--WHERE ID = 1

--UPDATE Trainers
--SET date_of_birth = '1949-02-01'
--WHERE ID = 2

--UPDATE Trainers
--SET date_of_birth = '1949-03-01'
--WHERE ID = 3

--UPDATE Trainers
--SET date_of_birth = '1949-04-01'
--WHERE ID = 4

