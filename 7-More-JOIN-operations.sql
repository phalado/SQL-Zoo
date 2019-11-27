-- List the films where the yr is 1962 [Show id, title]
SELECT id, title
  FROM movie
  WHERE yr = 1962;

-- Give year of 'Citizen Kane'.
SELECT yr
  FROM movie
  WHERE title = 'Citizen Kane';

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
  FROM movie
  WHERE title LIKE '%Star%Trek%'
  ORDER BY yr;

-- What id number does the actor 'Glenn Close' have?
SELECT id
  FROM actor
  WHERE name = 'Glenn Close';

-- What is the id of the film 'Casablanca'
SELECT id
  FROM movie
  WHERE title = 'Casablanca';

-- Obtain the cast list for 'Casablanca'.
SELECT a.name
  FROM actor AS a JOIN casting AS c ON a.id = c.actorid
  WHERE c.movieid = (SELECT id
                     FROM movie
                     WHERE title = 'Casablanca');

-- Obtain the cast list for the film 'Alien'
SELECT a.name
  FROM actor AS a JOIN casting AS c ON a.id = c.actorid
  WHERE c.movieid = (SELECT id
                     FROM movie
                     WHERE title = 'Alien');

-- List the films in which 'Harrison Ford' has appeared
SELECT m.title
  FROM movie AS m
  JOIN casting as c ON m.id = c.movieid
  WHERE c.actorid = (SELECT id
                       FROM actor
                       WHERE name = 'Harrison Ford');

-- List the films where 'Harrison Ford' has appeared - but not in the starring role.
SELECT m.title
  FROM movie AS m
  JOIN casting as c ON m.id = c.movieid
  WHERE c.ord != 1
    AND c.actorid = (SELECT id
                       FROM actor
                       WHERE name = 'Harrison Ford');

-- List the films together with the leading star for all 1962 films.
SELECT m.title, a.name
  FROM movie AS m
  JOIN casting AS c ON m.id = c.movieid
  JOIN actor AS a ON a.id = c.actorid
  WHERE c.ord = 1 AND m.yr = 1962;

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr, COUNT(title) FROM
  movie JOIN casting ON movie.id = movieid
        JOIN actor   ON actorid = actor.id
  WHERE name = 'Rock Hudson'
  GROUP BY yr
  HAVING COUNT(title) > 2;

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT m.title, a.name
  FROM movie AS m
  JOIN casting AS c ON c.movieid = m.id
  JOIN actor AS a ON c.actorid = a.id
  WHERE c.ord = 1
    AND m.id IN (SELECT movieid FROM casting
                   WHERE actorid IN (
                     SELECT id FROM actor
                     WHERE name='Julie Andrews'));

-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT name
  FROM actor
  WHERE id IN (SELECT actorid
                 FROM casting
                 WHERE ord = 1
                 GROUP BY actorid
                 HAVING COUNT(movieid) >= 30);

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT m.title, COUNT(c.movieid)
  FROM movie AS m
  JOIN casting AS c ON m.id = c.movieid
  WHERE m.yr = 1978
  GROUP BY m.title
  ORDER BY COUNT(c.movieid) DESC, m.title;

-- List all the people who have worked with 'Art Garfunkel'.
SELECT a.name
  FROM actor AS a
  WHERE name != 'Art Garfunkel'
    AND id IN (SELECT actorid
                 FROM casting
                 WHERE movieid IN (SELECT movieid FROM casting
                                     WHERE actorid IN (
                                     SELECT id FROM actor
                                     WHERE name='Art Garfunkel')));

