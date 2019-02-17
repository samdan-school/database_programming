-- 1b
USE movie_rating
-- 1. Өгөгдлийн уншихад амар болгох зорилгоор баганаар эрэмбэл. Reviewer name, movie title, stars, ratingDate-г дараах эрэмбийн дагуу харуулна уу. (1) reviewer name, (2) movie title (3) number of stars.
SELECT rv.name, m.title, r.stars, r.ratingDate FROM Rating as r
JOIN Movie as m ON r.mID = m.mID
JOIN Reviewer as rv ON r.rID = rv.rID
ORDER BY 
	rv.name ASC,
	m.title ASC,
	r.stars ASC

-- 2. Нэг reviewer нэг киног 2 удаа үнэлгээ хийсэн байж болох бөгөөд 2 дах үнэлгээ нь эхнийхээсээ өндөр байх reviewer name and movie title -уудийг харуул.
SELECT rv.name, m.title, MAX(r.stars) as 'Highest Star' FROM Rating as r
JOIN Movie as m ON r.mID = m.mID
JOIN Reviewer as rv ON r.rID = rv.rID
WHERE r.rID IN (
	-- Давтагдсан хүмүүсийг олож байна
	SELECT rID FROM Rating
	GROUP BY rID
	HAVING COUNT(*) > 1
)
GROUP BY rv.name, m.title

-- 3. Ядаж нэг үнэлгээ авсан кинонуудын хувьд хамгийн өндөр үнэлгээг олоод, киноны нэр болон одны тоог харуул. Харуулахдаа киноны нэрээр эрэмбэл.
SELECT TOP 1 m.title, SUM(r.stars) as 'Total Stars' FROM Rating as r
JOIN Movie as m ON r.mID = m.mID
WHERE r.rID IN (
	-- Давтагдсан хүмүүсийг олож байна
	SELECT rID FROM Rating
	GROUP BY rID
	HAVING COUNT(*) >= 1
)
GROUP BY m.title
ORDER BY 'Total Stars' DESC;

-- 4. Кино бүрийн үнэлгээний тархалтын талаарх мэдээллийг ол. Үнэлгээний тархалт гэдэг нь уг кинонд өгөгдсөн хамгийн өндөр болон бага үнэлгээний зөрүүг хэлнэ. Киноны нэр болон үнэлгээний тархалтыг буурах эрэмбээр  харуулна уу.
SELECT m.title, (MAX(r.stars) - MIN(r.stars)) as 'Tarhalt' FROM Rating as r
JOIN Movie as m ON r.mID = m.mID
GROUP BY m.title
UNION
SELECT m.title, 0 as 'Tarhalt' FROM Movie as m
WHERE m.mID NOT IN (
	SELECT r.mID FROM Rating as r
)
ORDER BY 'Tarhalt' DESC;

-- 5. 1980 оноос өмнөх киноны үнэлгээнүүдийн дундаж ба 1980 оноос дараах (1980 ороод)  киноны үнэлгээнүүдийн дундаж 2-н зөрүүл олно уу. Жич: тухайн киноны дундаж үнэлгээг тэр киноны үнэлгээ гэж үзнэ.
DECLARE @DiffTable table (
	AVG_Before_1980 float,
	AVG_AFTER_1980 float,
	AVG_DIFF float
);
INSERT INTO @DiffTable VALUES (
	(SELECT AVG(r.stars) FROM Movie as m
	JOIN Rating as r ON r.mID = m.mID
	WHERE m.year > '1980'),	
	(SELECT AVG(r.stars) FROM Movie as m
	JOIN Rating as r ON r.mID = m.mID
	WHERE m.year <= '1980'),
	(
		(SELECT AVG(r.stars) FROM Movie as m
		JOIN Rating as r ON r.mID = m.mID
		WHERE m.year > '1980')
		-
		(SELECT AVG(r.stars) FROM Movie as m
		JOIN Rating as r ON r.mID = m.mID
		WHERE m.year <= '1980')
	)
)
SELECT * FROM @DiffTable