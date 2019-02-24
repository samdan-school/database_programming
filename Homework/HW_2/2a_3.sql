-- 3. Өөр хоорондоо дуртай сурагчдийн хосуудын нэр ангиудыг харуул. Нэг хос давхцаж болохгүй ба нэрсийг цагаан толгойн дарааллаар харуулна уу.
SELECT h1.name, h2.name FROM Highschooler as h1, Highschooler as h2, (
	SELECT l1.ID1, l1.ID2 FROM Likes as l1
	JOIN Likes as l2 ON l1.ID1 = l2.ID2 AND l1.ID2 = l2.ID1
) as like_each
WHERE 
	h1.ID = like_each.ID1
	AND
	h2.ID = like_each.ID2
ORDER BY h1.name, h2.name