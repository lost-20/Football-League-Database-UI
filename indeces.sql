select AVG(Number_Of_Tickets_Sold) AS '—редн€€ число проданных билетов за год', datepart(yy, cast(Convert(nvarchar(60), [KeyDate]) AS DATE)) AS 'ѕериод' from Matches
where YEAR(CAST(Convert(NVarchar(60), [KeyDate]) AS DATE)) <= '2000'
group by datepart(yy, cast(Convert(nvarchar(60), [KeyDate]) AS DATE))
order by 'ѕериод'

CREATE CLUSTERED COLUMNSTORE INDEX cci ON Matches 

select * from Matches

drop index cci on Matches 

create nonclustered columnstore index ncci on Matches(Number_Of_Tickets_Sold, [KeyDate])

select AVG(Number_Of_Goals) AS '—реднее число голов у CB', datepart(yy, cast(Convert(nvarchar(60), [KeyDate]) AS DATE)) AS 'ѕериод' from Players_In_Match
where YEAR(CAST(Convert(NVarchar(60), [KeyDate]) AS DATE)) IN ('1960', '2019') and Position = 'CB'
group by datepart(yy, cast(Convert(nvarchar(60), [KeyDate]) AS DATE))
order by 'ѕериод'

CREATE CLUSTERED COLUMNSTORE INDEX cci ON Matches WITH ( DROP_EXISTING = ON );

create nonclustered columnstore index ncci on Players_In_Match(Number_Of_Goals, [KeyDate], Number_Of_Violances, Number_Of_Yellow_Cards)

select —apacity from Stadiums
where Name = 'aеярдЋщў…'                                        

CREATE NONCLUSTERED INDEX ncci   
    ON Stadiums (Name);

drop index ncci on Stadiums

select * from Clubs
where Name = 'a»гЌъоо Џ‘и÷р'     

CREATE NONCLUSTERED INDEX ncci   
    ON Clubs (Name);

select Name from Trainers
where Wage > 50000     

CREATE NONCLUSTERED INDEX fncci   
    ON Trainers(Name)
	where Wage > 50000


select Name from Players
where Name = 'a«ыейфбќ√ма’—'                                     

CREATE NONCLUSTERED INDEX nci   
    ON Players(Name, Wage)

CREATE NONCLUSTERED INDEX fnci   
    ON Players(Wage)
	where Wage > 50000

CREATE NONCLUSTERED INDEX nameci   
    ON Players(Name)


CREATE PARTITION FUNCTION PartFunctionMatches_Date3 (bigint) AS RANGE RIGHT FOR VALUES (19600101, 19800101, 20000101, 20200101, 20400101, 20600101, 20800101, 21000101) 

CREATE PARTITION SCHEME PartSchMatches_Date3 AS PARTITION PartFunctionMatches_Date3 TO ([Fast_Growing], [Fast_Growing],[Fast_Growing],[Fast_Growing],[Fast_Growing],[Fast_Growing], [Frequently_Requested], [Frequently_Requested], [Frequently_Requested])

alter table ћatches
add PRIMARY KEY (KeyDate) ON PartSchMatches_Date3(KeyDate)

select * from ћatches
where Keydate >= 20500101 AND KeyDate <= 21000101

------------------------метод скольз€щего окна
CREATE PARTITION FUNCTION PartFunctionForArchivalTable (bigint) AS RANGE RIGHT FOR VALUES (19600101)
CREATE PARTITION SCHEME PartSchForArchivalTable AS PARTITION PartFunctionForArchivalTable TO ([Fast_Growing], [Fast_Growing]) 
Create table Archive
(
	[Team2_Name] [nchar](30) NOT NULL,
	[ID_Trainer1] [int] NOT NULL,
	[ID_Trainer2] [int] NOT NULL,
	[First_Team_Score] [int] NOT NULL,
	[Second_Team_Score] [int] NOT NULL,
	[ChampionShip] [nchar](30) NOT NULL,
	[Stadium_Name] [nchar](30) NOT NULL,
	[Number_Of_Tickets_Sold] [int] NOT NULL,
	[ID_Match] [int] NOT NULL,
	[Team1_Name] [nchar](30) NOT NULL,
	[Stadium_ID] [int] NOT NULL,
	[Team1_ID] [int] NOT NULL,
	[Team2_ID] [int] NOT NULL,
	[KeyDate] [bigint] NOT NULL,
	CONSTRAINT PKDW_13 PRIMARY KEY (KeyDate)
	) ON [PartSchForArchivalTable](KeyDate)


CREATE PROCEDURE Pr_SlidingWindow  AS 
DECLARE @DayForMaxPartMatches_Date VARCHAR(8) 
DECLARE @DayForMaxPartArchival VARCHAR(8)
DECLARE @DayForMinPartMatches_Date VARCHAR(8) 
DECLARE @DayForMinPartArchival VARCHAR(8)

select * from sys.partition_range_values 

SET @DayForMaxPartMatches_Date = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values   
WHERE function_id = (SELECT function_id  FROM sys.partition_functions
	WHERE name = 'PartFunctionMatches_Date')     
		ORDER BY boundary_id DESC) AS VARCHAR(8)) 

SET @DayForMaxPartArchival = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values    
WHERE function_id = (SELECT function_id     FROM sys.partition_functions            
	WHERE name = 'PartFunctionForArchivalTable')
		ORDER BY boundary_id DESC) AS VARCHAR(8))

DECLARE @Day_DT DATE SET @Day_DT = DATEADD(YEAR, 1, CAST(@DayForMaxPartMatches_Date AS DATE)) 
DECLARE @DayArchival_DT DATE SET @DayArchival_DT = DATEADD(YEAR, 1, CAST(@DayForMaxPartArchival AS DATE))

ALTER PARTITION SCHEME PartSchMatches_Date NEXT USED [Frequently_Requested]; 
 
ALTER PARTITION SCHEME PartSchForArchivalTable NEXT USED [Frequently_Requested] 

ALTER PARTITION FUNCTION PartFunctionMatches_Date() SPLIT RANGE (CAST(CONVERT (VARCHAR(8),@Day_DT, 112) AS BIGINT)) 
 
ALTER PARTITION FUNCTION PartFunctionForArchivalTable() SPLIT RANGE (CAST(CONVERT (VARCHAR(8),@DayArchival_DT, 112) AS BIGINT))

ALTER TABLE ћatches SWITCH PARTITION 2 TO ArchivalFactSales PARTITION 2

SET @DayForMinPartMatches_Date = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values    
WHERE function_id = (SELECT function_id         FROM sys.partition_functions     
	WHERE name = 'PartFunctionMatches_Date')      
		ORDER BY boundary_id) AS VARCHAR(8))


SET @DayForMinPartArchival = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values   
WHERE function_id = (SELECT function_id                 FROM sys.partition_functions     
	WHERE name = 'PartFunctionForArchivalTable')     
		ORDER BY boundary_id) AS VARCHAR(8))

ALTER PARTITION FUNCTION PartFunctionMatches_Date()  MERGE RANGE (CAST(@DayForMinPartMatches_Date AS BIGINT))

ALTER PARTITION FUNCTION PartFunctionForArchivalTable()  MERGE RANGE (CAST(@DayForMinPartArchival AS BIGINT));

Select 
	prt.partition_number
	, prt.rows
	,prv.value low_boundary
	,flg.name name_filegroup
from sys.partitions prt
	join sys.indexes idx on prt.object_id = idx.object_id
	join sys.data_spaces dts on dts.data_space_id = idx.data_space_id
	left join sys.partition_schemes prs on prs.data_space_id = dts.data_space_id
	left join sys.partition_range_values prv on prv.function_id = prs.function_id AND prv.boundary_id = prt.partition_number - 1
	left join sys.destination_data_spaces dds on dds.partition_scheme_id = prs.data_space_id and dds.destination_id = prt.partition_number
	left join sys.filegroups flg on flg.data_space_id = dds.data_space_id
where prt.object_id = (Select object_id from sys.tables where name = 'Matches')

alter PROCEDURE Pr_SlidingWindow  AS 
DECLARE @DayForMaxPartMatches_Date VARCHAR(8) 
DECLARE @DayForMaxPartArchival VARCHAR(8)
DECLARE @DayForMinPartMatches_Date VARCHAR(8) 
DECLARE @DayForMinPartArchival VARCHAR(8)
begin
select * from sys.partition_range_values 

SET @DayForMaxPartMatches_Date = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values   
WHERE function_id = (SELECT function_id  FROM sys.partition_functions
	WHERE name = 'PartFunctionMatches_Date3')     
		ORDER BY boundary_id DESC) AS VARCHAR(8)) 

SET @DayForMaxPartArchival = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values    
WHERE function_id = (SELECT function_id     FROM sys.partition_functions            
	WHERE name = 'PartFunctionForArchivalTable')
		ORDER BY boundary_id DESC) AS VARCHAR(8))

DECLARE @Day_DT DATE SET @Day_DT = DATEADD(YEAR, 20, CAST(@DayForMaxPartMatches_Date AS DATE)) 
DECLARE @DayArchival_DT DATE SET @DayArchival_DT = DATEADD(YEAR, 20, CAST(@DayForMaxPartArchival AS DATE))

ALTER PARTITION SCHEME PartSchMatches_Date3 NEXT USED [Frequently_Requested]; 
 
ALTER PARTITION SCHEME PartSchForArchivalTable NEXT USED [Frequently_Requested] 

ALTER PARTITION FUNCTION PartFunctionMatches_Date3() SPLIT RANGE (CAST(CONVERT (VARCHAR(8),@Day_DT, 112) AS BIGINT)) 
 
ALTER PARTITION FUNCTION PartFunctionForArchivalTable() SPLIT RANGE (CAST(CONVERT (VARCHAR(8),@DayArchival_DT, 112) AS BIGINT))

ALTER TABLE ћatches SWITCH PARTITION 2 TO Archive PARTITION 2

SET @DayForMinPartMatches_Date = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values    
WHERE function_id = (SELECT function_id         FROM sys.partition_functions     
	WHERE name = 'PartFunctionMatches_Date3')      
		ORDER BY boundary_id) AS VARCHAR(8))


SET @DayForMinPartArchival = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values   
WHERE function_id = (SELECT function_id                 FROM sys.partition_functions     
	WHERE name = 'PartFunctionForArchivalTable')     
		ORDER BY boundary_id) AS VARCHAR(8))

ALTER PARTITION FUNCTION PartFunctionMatches_Date3()  MERGE RANGE (CAST(@DayForMinPartMatches_Date AS BIGINT))

ALTER PARTITION FUNCTION PartFunctionForArchivalTable()  MERGE RANGE (CAST(@DayForMinPartArchival AS BIGINT));

Select 
	prt.partition_number
	, prt.rows
	,prv.value low_boundary
	,flg.name name_filegroup
from sys.partitions prt
	join sys.indexes idx on prt.object_id = idx.object_id
	join sys.data_spaces dts on dts.data_space_id = idx.data_space_id
	left join sys.partition_schemes prs on prs.data_space_id = dts.data_space_id
	left join sys.partition_range_values prv on prv.function_id = prs.function_id AND prv.boundary_id = prt.partition_number - 1
	left join sys.destination_data_spaces dds on dds.partition_scheme_id = prs.data_space_id and dds.destination_id = prt.partition_number
	left join sys.filegroups flg on flg.data_space_id = dds.data_space_id
where prt.object_id = (Select object_id from sys.tables where name = 'ћatches')

end

exec Pr_SlidingWindow




----------------------2
CREATE PARTITION FUNCTION PartFunctionMatches_Date5 (bigint) AS RANGE RIGHT FOR VALUES (19600101, 19800101, 20000101, 20200101) 

CREATE PARTITION SCHEME PartSchMatches_Date5 AS PARTITION PartFunctionMatches_Date5 TO ([Fast_Growing], [Fast_Growing], [Frequently_Requested], [Frequently_Requested], [Frequently_Requested])



alter table Players_In_Match
add PRIMARY KEY (KeyDate, ID_Player) ON PartSchMatches_Date5(KeyDate)

CREATE PARTITION FUNCTION PartFunctionForArchivalTable2 (bigint) AS RANGE RIGHT FOR VALUES (19600101)
CREATE PARTITION SCHEME PartSchForArchivalTable2 AS PARTITION PartFunctionForArchivalTable2 TO ([Fast_Growing], [Fast_Growing]) 
Create table Archive2
(
	[ID_Player] [int] NOT NULL,
	[KeyDate] [bigint] NOT NULL,
	[Position] [nchar](10) NOT NULL,
	[Number_Of_Goals] [int] NOT NULL,
	[Number_Of_Violances] [int] NOT NULL,
	[Number_Of_Yellow_Cards] [int] NOT NULL,
	[Number_Of_Read_Cards] [int] NOT NULL,
	[Club_ID] [int] NULL,
	CONSTRAINT PKDW_15 PRIMARY KEY (KeyDate, ID_Player)
	) ON [PartSchForArchivalTable2](KeyDate)


	Select 
	prt.partition_number
	, prt.rows
	,prv.value low_boundary
	,flg.name name_filegroup
from sys.partitions prt
	join sys.indexes idx on prt.object_id = idx.object_id
	join sys.data_spaces dts on dts.data_space_id = idx.data_space_id
	left join sys.partition_schemes prs on prs.data_space_id = dts.data_space_id
	left join sys.partition_range_values prv on prv.function_id = prs.function_id AND prv.boundary_id = prt.partition_number - 1
	left join sys.destination_data_spaces dds on dds.partition_scheme_id = prs.data_space_id and dds.destination_id = prt.partition_number
	left join sys.filegroups flg on flg.data_space_id = dds.data_space_id
where prt.object_id = (Select object_id from sys.tables where name = 'Players_In_Match')

select * from sys.partition_range_values 

alter PROCEDURE Pr_SlidingWindow  AS 
DECLARE @DayForMaxPartMatches_Date VARCHAR(8) 
DECLARE @DayForMaxPartArchival VARCHAR(8)
DECLARE @DayForMinPartMatches_Date VARCHAR(8) 
DECLARE @DayForMinPartArchival VARCHAR(8)
begin

SET @DayForMaxPartMatches_Date = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values   
WHERE function_id = (SELECT function_id  FROM sys.partition_functions
	WHERE name = 'PartFunctionMatches_Date5')     
		ORDER BY boundary_id DESC) AS VARCHAR(8)) 

SET @DayForMaxPartArchival = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values    
WHERE function_id = (SELECT function_id     FROM sys.partition_functions            
	WHERE name = 'PartFunctionForArchivalTable2')
		ORDER BY boundary_id DESC) AS VARCHAR(8))

DECLARE @Day_DT DATE SET @Day_DT = DATEADD(YEAR, 20, CAST(@DayForMaxPartMatches_Date AS DATE)) 
DECLARE @DayArchival_DT DATE SET @DayArchival_DT = DATEADD(YEAR, 20, CAST(@DayForMaxPartArchival AS DATE))

ALTER PARTITION SCHEME PartSchMatches_Date5 NEXT USED [Frequently_Requested]; 
 
ALTER PARTITION SCHEME PartSchForArchivalTable2 NEXT USED [Frequently_Requested] 

ALTER PARTITION FUNCTION PartFunctionMatches_Date5() SPLIT RANGE (CAST(CONVERT (VARCHAR(8),@Day_DT, 112) AS BIGINT)) 
 
ALTER PARTITION FUNCTION PartFunctionForArchivalTable2() SPLIT RANGE (CAST(CONVERT (VARCHAR(8),@DayArchival_DT, 112) AS BIGINT))

ALTER TABLE Players_In_Match SWITCH PARTITION 2 TO Archive2 PARTITION 2

SET @DayForMinPartMatches_Date = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values    
WHERE function_id = (SELECT function_id         FROM sys.partition_functions     
	WHERE name = 'PartFunctionMatches_Date5')      
		ORDER BY boundary_id) AS VARCHAR(8))


SET @DayForMinPartArchival = CAST((SELECT TOP 1 [value] FROM sys.partition_range_values   
WHERE function_id = (SELECT function_id                 FROM sys.partition_functions     
	WHERE name = 'PartFunctionForArchivalTable2')     
		ORDER BY boundary_id) AS VARCHAR(8))

ALTER PARTITION FUNCTION PartFunctionMatches_Date5()  MERGE RANGE (CAST(@DayForMinPartMatches_Date AS BIGINT))

ALTER PARTITION FUNCTION PartFunctionForArchivalTable2()  MERGE RANGE (CAST(@DayForMinPartArchival AS BIGINT));


end

exec Pr_SlidingWindow