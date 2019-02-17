-- 1a
USE movie_rating
-- 1. Steven Spielberg -н зохиосон (directed) бүх киноны нэрийг харуул.
USE movie_rating
SELECT * FROM Movie
WHERE director = 'Steven Spielberg'

-- 2. 4 эсвэл 5 гэсэн rating -тэй кино бүтээгдсэн бүх жилийг харуул. Мөн тэдгээр жилүүдийг өсөх эрэмбээр харуул.
USE movie_rating
SELECT * FROM Rating
WHERE stars = 4 OR stars = 5
ORDER BY ratingDate ASC

-- 3. Rating -г байхгүй бүх киноны нэрсийг харуул.
USE movie_rating
SELECT title from Movie
WHERE mID NOT IN (	
	-- Rating-д байгаа киноын дугаарууд
	SELECT DISTINCT m.mID FROM Movie as m
	JOIN Rating as r ON m.mID = r.mID
);