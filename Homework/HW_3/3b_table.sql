USE master;
DROP DATABASE IF EXISTS scholarship;

CREATE DATABASE scholarship;
USE scholarship;

CREATE TABLE APPLICATION (StudentID VARCHAR(100), Date INT, State VARCHAR(100));
CREATE TABLE COURSE (CourseID VARCHAR(100), Title VARCHAR(100), Credits INT);
CREATE TABLE RANKING (StudentID VARCHAR(100), Average DECIMAL, Credits INT, Rank INT);
CREATE TABLE EXAM (CourseID VARCHAR(100), StudentID VARCHAR(100), Date INT, Grade INT);

INSERT INTO EXAM VALUES 
	('c1', 's1', 2019, 95),
	('c1', 's1', 2019, 95),
	('c2', 's1', 2018, 95),
	('c2', 's2', 2019, 95),
	('c3', 's2', 2018, 95),
	('c1', 's3', 2019, 80),
	('c2', 's3', 2018, 80),
	('c1', 's4', 2019, 95),
	('c2', 's4', 2018, 95);
INSERT INTO EXAM VALUES
	('c1', 's5', 2019, 100),
	('c2', 's5', 2018, 100);

INSERT INTO COURSE VALUES 
	('c1', 'Hard Cource', 40),
	('c2', 'Meduim Cource', 20),
	('c3', 'Easy Cource', 10);
	
INSERT INTO APPLICATION VALUES('s1', 2019, null);
INSERT INTO APPLICATION VALUES('s5', 2019, null);
INSERT INTO APPLICATION VALUES('s2', 2018, null);
INSERT INTO APPLICATION VALUES('s3', 2018, null);
INSERT INTO APPLICATION VALUES('s4', 2000, null);

SELECT * FROM APPLICATION;
SELECT * FROM RANKING;
DELETE APPLICATION;
DELETE RANKING;

UPDATE APPLICATION SET state = 'dropout' WHERE StudentID = 's1';