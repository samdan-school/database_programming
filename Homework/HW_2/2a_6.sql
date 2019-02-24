-- 6. Зөвхөн нэг ижил ангид л найзууд нь байдаг сурагчдын нэр ангийг олж, анги нэрээ эрэмбэлж харуулна уу.
SELECT * FROM Highschooler as h
	WHERE EXISTS (
		SELECT COUNT(*) FROM (
			SELECT h2.grade FROM Highschooler as h1, Highschooler as h2, (
				SELECT * FROM Friend as fi
				WHERE 		
					h.ID = fi.ID1
				) as friend_list
			WHERE h1.ID = friend_list.ID1 AND h2.ID = friend_list.ID2
			GROUP BY h2.grade
		) as friends
		HAVING COUNT(friends.grade) = 1
	)