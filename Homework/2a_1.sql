-- 1. Gabriel нэртэй сурагчтай найзын харицаатай бүх оюутнуудын нэрийг харуулна уу.
SELECT * FROM Highschooler as h
WHERE h.ID in (
	SELECT id1 FROM Friend
	WHERE 
	ID2 IN (
		SELECT ID FROM Highschooler
		WHERE name = 'Gabriel'
	) OR
	ID1 IN (
		SELECT ID FROM Highschooler
		WHERE name = 'Gabriel'
	)
)