SELECT * FROM View_info
EXEC sp_helptext 'View_info' 

ALTER View View_info 
with encryption 
AS
SELECT
ID
FROM Players


Insert into View_info
values
('Кудинов Тихон Дмитриевич', 19, 'Russia', 300, 'RW', '7', 190, 80)


Insert into View_info
values
('Кудинов Тихон Дмитриевич', 19, 'Spain', 300, 'RW', '7', 190, 80)

SELECT * FROM View_info
WHERE [Player's name'] = 'Кудинов Тихон Дмитриевич'

SET NUMERIC_ROUNDABORT OFF;

SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL,

ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON;

GO

CREATE UNIQUE CLUSTERED INDEX
    View_info_Index ON View_Schemabinding (ID);

SELECT DISTINCT ID FROM View_Schemabinding with (noexpand)
SELECT DISTINCT ID FROM View_Schemabinding with (index(View_info_Index))