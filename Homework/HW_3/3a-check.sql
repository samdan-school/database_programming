USE movie_rating;
-- 11
UPDATE Movie set MID = MID + 1
SELECT * FROM Movie

-- 12
insert into Movie values (109, 'Titanic', '1997', 'JC');

-- 13
insert into Reviewer values (201, 'Ted Codd');

-- 14
select * FROM Rating
update Rating set rID = 205, mID = 104;

-- 15
insert into Reviewer values (209, null);

-- 16
update Rating set stars = null where rID = 208;

-- 17
update Movie set year = DATEADD(year, -40, year);

-- 18
update Rating set stars = stars + 1;

-- 19
insert into Rating values (201, 101, 1, '1999-01-01');

-- 20
insert into Movie values (109, 'Jurassic Park', '1993', 'Steven Spielberg');

-- 21
update Movie set year = DATEADD(year, -10, year) where title = 'Titanic';

-- No error
-- 22
insert into Movie values (109, 'Titanic', '2001', null);

-- 23
update Rating set mID= 109;

-- 24
update Movie set year = '1901' where director <> 'James Cameron';

-- 25
update Rating set stars = stars -1;

-- Referential Integrity Enforcement
-- Generate Error
-- 27
insert into Rating values (209, 109, 3, '2001-01-01');

-- 28
update Rating set rID = 209 where rID = 208;

-- 29
update Rating set mID = mID + 1

-- 30
update Movie set mID = 109 where mID = 108;

-- No Error
-- 31
update Movie set mID = 109 where mID = 102; 

-- 32
update Reviewer set rID = rID + 10;

-- 33 
delete from Reviewer where rID > 215;

-- 34
delete from Movie where mID < 105;

select * FROM Movie
select * FROM Reviewer
select * FROM Rating