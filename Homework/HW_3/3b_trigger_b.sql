USE scholarship;

-- 3b 1
DROP TRIGGER tb_1;
CREATE TRIGGER tb_1
ON APPLICATION
AFTER INSERT
AS
BEGIN
	IF EXISTS (SELECT * FROM INSERTED WHERE state IS NULL)
		IF (
			(SELECT SUM(c.Credits) FROM EXAM as e
			JOIN COURSE as c ON e.CourseID = c.CourseID
			WHERE e.StudentID = (SELECT StudentID FROM inserted)) > 50
			AND
			(SELECT AVG(e.Grade) FROM EXAM as e
			WHERE e.StudentID = (SELECT StudentID FROM inserted)) > 90						
		)
			UPDATE APPLICATION SET State = 'accepted' WHERE StudentID = (SELECT StudentID FROM inserted)
		ELSE
			UPDATE APPLICATION SET State = 'rejected' WHERE StudentID = (SELECT StudentID FROM inserted)			
END
GO

-- 3b 2
DROP TRIGGER tb_2;
CREATE TRIGGER tb_2
ON APPLICATION
AFTER UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE State = 'accepted')
		BEGIN
			DECLARE @id VARCHAR(100)
			DECLARE @avg INT
			DECLARE @sum INT
			DECLARE @day INT
			DECLARE @rank INT
			
			SET @id = (SELECT StudentID FROM inserted);
			SET @avg = (SELECT AVG(e.Grade) FROM EXAM as e WHERE e.StudentID = (SELECT StudentID FROM inserted));
			SET @sum = (SELECT SUM(c.Credits) FROM EXAM as e JOIN COURSE as c ON e.CourseID = c.CourseID WHERE e.StudentID = (SELECT StudentID FROM inserted));
			SET @avg = (SELECT AVG(e.Grade) FROM EXAM as e WHERE e.StudentID = (SELECT StudentID FROM inserted));
			SET @day = (SELECT Date FROM inserted);
			SET @rank = (
				SELECT COUNT(*) FROM RANKING as r
				WHERE 
				(r.Average > @avg) OR 
				(r.Average = @avg AND r.Credits > @sum) OR
				(r.Average = @avg AND r.Credits = @sum AND (SELECT date FROM APPLICATION as a WHERE r.StudentID = a.StudentID) > @day)
			) + 1;
			

			INSERT INTO RANKING VALUES (
				@id,
				@avg,
				@sum,
				@rank
			);

			UPDATE RANKING SET RANK = RANK + 1 
			WHERE 
			StudentID <> @id AND
			Rank >= @rank;
		END
END
GO

-- 3b 3
CREATE TRIGGER tb_3
ON APPLICATION
AFTER UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE State = 'dropout')
	BEGIN
		DECLARE @id VARCHAR(100)
		DECLARE @rank INT
		
		SET @id = (SELECT StudentID FROM inserted);
		SET @rank = (SELECT Rank FROM RANKING WHERE StudentID = @id);

		DELETE RANKING WHERE StudentID = @id;

		UPDATE RANKING SET RANK = RANK - 1 
		WHERE Rank >= @rank;
	END
END
GO