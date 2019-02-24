-- 2. Өөрөөсөө 2-оос олон дүү хэн нэгэнд дуртай бүх сурагчдын нэр ангийг болон дуртай сурагчийнх нь нэр ангийг харуул.
SELECT h1.name, h2.name FROM Highschooler as h1, Highschooler h2, (
	SELECT * FROM Likes as l
	WHERE (
		SELECT grade FROM Highschooler as hi
		WHERE hi.ID = l.ID1
	) - (
		SELECT grade FROM Highschooler as hi
		WHERE hi.ID = l.ID2
	) >= 2 OR (
		SELECT grade FROM Highschooler as hi
		WHERE hi.ID = l.ID2
	) - (
		SELECT grade FROM Highschooler as hi
		WHERE hi.ID = l.ID1
	) >= 2
) as two_more
WHERE h1.ID = two_more.ID1 AND h2.ID = two_more.ID2;