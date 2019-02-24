-- 4. Likes хүснэгтэд байхгүй бүх сурагчдын нэрсийг ангитай нь олж, анги, нэрээр эрэмбэлж харуулна уу.
SELECT h.name, h.grade FROM Highschooler as h
WHERE h.ID NOT IN (
	SELECT ID1 as ID FROM Likes
	UNION
	SELECT ID2 as ID FROM Likes
)
ORDER BY h.name ASC;