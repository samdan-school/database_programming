-- 5. Сурагч А нь сурагч Б-д дуртай бөгөөд сурагч Б хэнд дуртай талаар мэдээлэл байхгүй (Б Likes хүснэгтэд id1 -р бичэгдээгүй) байх бүх тохиолдолыг олж, А болон Б-ийн нэр, ангийг нэрээр эрэмбэлж харуулна уу.
SELECT h1.name, h1.grade, h2.name, h2.grade FROM Highschooler as h1, Highschooler as h2, (
	SELECT * FROM Likes as l1
	WHERE l1.ID2 NOT IN (
		SELECT ID1 FROM Likes
	)
) as a_b
WHERE 
	h1.ID = a_b.ID1
	AND
	h2.ID = a_b.ID2
ORDER BY h1.grade, h1.name, h2.grade, h2.name;