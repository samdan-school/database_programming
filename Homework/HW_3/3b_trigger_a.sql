USE social;
CREATE TABLE Highschooler_history (
	ID INT,
	name VARCHAR(50),
	grade INT
)
-- 1
CREATE TRIGGER trigger_1 ON Highschooler
AFTER INSERT 
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE name = 'Friendly')
		INSERT INTO Likes(ID1, ID2) VALUES (
			(SELECT ID FROM inserted WHERE name = 'Friendly'),
			(SELECT ID FROM Highschooler WHERE grade IN (SELECT grade FROM inserted WHERE name = 'Friendly'))
		)
END
GO

-- 2
DROP TRIGGER trigger_2_a;
DROP TRIGGER trigger_2_b;
CREATE TRIGGER trigger_2_a ON Highschooler
AFTER INSERT 
AS
BEGIN
	UPDATE Highschooler SET grade = NULL WHERE grade < 9 OR grade > 12;
END
GO

CREATE TRIGGER trigger_2_b ON Highschooler
AFTER UPDATE 
AS
BEGIN
	UPDATE Highschooler SET grade = 9 WHERE grade IS NULL;
END
GO

select * from Highschooler
INSERT INTO Highschooler VALUES(0, 'sam', 7);
DELETE Highschooler WHERE ID = 0;

-- 3
DROP TRIGGER trigger_3
CREATE TRIGGER trigger_3 ON Highschooler
AFTER UPDATE 
AS
BEGIN
	IF (UPDATE(grade))
		BEGIN
			UPDATE Highschooler SET grade = grade + 1 WHERE ID IN (		
				SELECT DISTINCT ID FROM (
					(SELECT ID1 as ID FROM Friend WHERE ID1 in (SELECT ID FROM inserted) OR ID2 in (SELECT ID FROM inserted))
					UNION				
					(SELECT ID2 as ID FROM Friend WHERE ID1 in (SELECT ID FROM inserted) OR ID2 in (SELECT ID FROM inserted))			
				) as un) AND
				ID NOT IN (SELECT ID FROM inserted)

			INSERT INTO Highschooler_history SELECT * FROM Highschooler WHERE grade > 12;
			DELETE Highschooler WHERE grade > 12;
		END
END
GO

UPDATE Highschooler SET grade = grade + 1 WHERE ID > 1600;
SELECT * FROM Highschooler
SELECT * FROM Highschooler_history
DELETE Highschooler_history

-- 4
CREATE TRIGGER trigger_4 ON Friend
AFTER INSERT, DELETE
AS
BEGIN	
	IF EXISTS (SELECT * FROM INSERTED)
		IF NOT EXISTS (
			SELECT * FROM Friend 
			WHERE
				ID1 = (SELECT ID2 FROM INSERTED) AND
				ID2 = (SELECT ID1 FROM INSERTED)
		)
			INSERT INTO Friend SELECT ID2, ID1 FROM INSERTED

	IF EXISTS (SELECT * FROM DELETED)
		IF EXISTS (
			SELECT * FROM Friend 
			WHERE
				ID1 = (SELECT ID2 FROM DELETED) AND
				ID2 = (SELECT ID1 FROM DELETED)
		)
			DELETE Friend WHERE
				ID1 = (SELECT ID2 FROM DELETED) AND
				ID2 = (SELECT ID1 FROM DELETED)
END
GO

INSERT INTO Highschooler VALUES(0, 'sam', 7);
SELECT * FROM Friend WHERE ID1 = 0 OR ID2 = 0;
INSERT INTO Friend VALUES(0, 1510);
INSERT INTO Friend VALUES(1510, 0);
DELETE Friend WHERE ID1 = 0 AND ID2 = 1510
DELETE Friend WHERE ID1 = 1510 AND ID2 = 0