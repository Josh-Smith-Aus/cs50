--  list the titles of all movies in which both Bradley Cooper and Jennifer Lawrence starred.
SELECT movies.title
FROM people
JOIN stars ON people.id = stars.person_id
JOIN movies ON stars.movie_id = movies.id
WHERE people.name = "Bradley Cooper" AND movies.title
IN (
    SELECT movies.title
    FROM people
    JOIN stars ON people.id = stars.person_id
    JOIN movies ON stars.movie_id = movies.id
    WHERE people.name = "Jennifer Lawrence"
    )
;
