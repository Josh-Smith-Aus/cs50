-- list the names of all people who starred in a movie in which Kevin Bacon also starred.
SELECT name
FROM people
JOIN stars ON people.id = stars.person_id
JOIN movies ON stars.movie_id = movies.id
WHERE movies.id IN
(
    SELECT movie_id
    FROM stars
    WHERE person_id =
        (
        SELECT id
        FROM people
        WHERE people.name = "Kevin Bacon" AND people.birth = "1958"
        )
)
AND name != "Kevin Bacon"
;
