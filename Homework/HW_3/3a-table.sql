USE master;
DROP DATABASE IF EXISTS movie_rating; 
CREATE DATABASE movie_rating;
USE movie_rating;
 
/* Create the schema for our tables */
CREATE TABLE Movie(
	MID INT, 
	title NVARCHAR(30), 
	YEAR DATE, 
	director NVARCHAR(30),
	CONSTRAINT movie_pk PRIMARY KEY (mID),
	CONSTRAINT movie_uq_title_year UNIQUE (title, year),
	CONSTRAINT movie_ck_year CHECK (year > '1900'),
	CONSTRAINT movie_ck_director_tp CHECK (
		(director = 'Steven Spielberg' AND year < '1990') OR 		
		(director = 'James Cameron' AND year > '1990')  OR 
		(director <> 'Steven Spielberg' AND director <> 'James Cameron')
	)
);
CREATE TABLE Reviewer(
	rID INT, 
	NAME NVARCHAR(30) NOT NULL,
	CONSTRAINT reviewer_pk PRIMARY KEY (rID)
);
CREATE TABLE Rating(
	rID INT, 
	MID INT, 
	stars INT NOT NULL, 
	ratingDate DATE,
	CONSTRAINT rating_uq_title_year UNIQUE (rID, mID, ratingDate),
	CONSTRAINT rating_ck_stars_value CHECK ((stars >= 1) AND (stars <=5)),
	CONSTRAINT rating_ck_ratingDate CHECK (ratingDate > '2000'),
	CONSTRAINT raintg_fk_mID FOREIGN KEY (MID) REFERENCES Movie(MID) ON DELETE CASCADE ON UPDATE NO ACTION,
	CONSTRAINT raintg_fk_rID FOREIGN KEY (rID) REFERENCES Reviewer(rID) ON DELETE CASCADE ON UPDATE CASCADE
);
 
/* Populate the tables with our data */
INSERT INTO Movie VALUES(101, 'Gone with the Wind', '1939', 'Victor Fleming');
INSERT INTO Movie VALUES(102, 'Star Wars', '1977', 'George Lucas');
INSERT INTO Movie VALUES(103, 'The Sound of Music', '1965', 'Robert Wise');
INSERT INTO Movie VALUES(104, 'E.T.', '1982', 'Steven Spielberg');
INSERT INTO Movie VALUES(105, 'Titanic', '1997', 'James Cameron');
INSERT INTO Movie VALUES(106, 'Snow White', '1937', NULL);
INSERT INTO Movie VALUES(107, 'Avatar', '2009', 'James Cameron');
INSERT INTO Movie VALUES(108, 'Raiders of the Lost Ark', '1981', 'Steven Spielberg');
 
INSERT INTO Reviewer VALUES(201, 'Sarah Martinez');
INSERT INTO Reviewer VALUES(202, 'Daniel Lewis');
INSERT INTO Reviewer VALUES(203, 'Brittany Harris');
INSERT INTO Reviewer VALUES(204, 'Mike Anderson');
INSERT INTO Reviewer VALUES(205, 'Chris Jackson');
INSERT INTO Reviewer VALUES(206, 'Elizabeth Thomas');
INSERT INTO Reviewer VALUES(207, 'James Cameron');
INSERT INTO Reviewer VALUES(208, 'Ashley White');
 
INSERT INTO Rating VALUES(201, 101, 2, '2011-01-22');
INSERT INTO Rating VALUES(201, 101, 4, '2011-01-27');
INSERT INTO Rating VALUES(202, 106, 4, NULL);
INSERT INTO Rating VALUES(203, 103, 2, '2011-01-20');
INSERT INTO Rating VALUES(203, 108, 4, '2011-01-12');
INSERT INTO Rating VALUES(203, 108, 2, '2011-01-30');
INSERT INTO Rating VALUES(204, 101, 3, '2011-01-09');
INSERT INTO Rating VALUES(205, 103, 3, '2011-01-27');
INSERT INTO Rating VALUES(205, 104, 2, '2011-01-22');
INSERT INTO Rating VALUES(205, 108, 4, NULL);
INSERT INTO Rating VALUES(206, 107, 3, '2011-01-15');
INSERT INTO Rating VALUES(206, 106, 5, '2011-01-19');
INSERT INTO Rating VALUES(207, 107, 5, '2011-01-20');
INSERT INTO Rating VALUES(208, 104, 3, '2011-01-02');