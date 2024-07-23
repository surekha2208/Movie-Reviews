create database Movies_Review;
use  Movies_Review;
SELECT * FROM movies_review.action;
SELECT * FROM movies_review.comedy;
SELECT * FROM movies_review.biography;
SELECT * FROM movies_review.animation;
SELECT * FROM movies_review.adventure;
SELECT * FROM movies_review.fantasy;
SELECT * FROM movies_review.drama;
SELECT * FROM movies_review.crime;
SELECT * FROM movies_review.mystery;
SELECT * FROM movies_review.music;
SELECT * FROM movies_review.horror;
SELECT * FROM movies_review.history;
SELECT * FROM movies_review.sport;
SELECT * FROM movies_review.ramance;
SELECT * FROM movies_review.Thriller;
SELECT * FROM movies_review.war;

-- List the top 5 thriller movies with the highest ratings.
select name , num_raters from movies_review.action order by num_raters desc limit 5;
select name , num_raters from movies_review.comedy order by num_raters desc limit 5;
select name , num_raters from movies_review.biography order by num_raters desc limit 5;
select name , num_raters from movies_review.animation order by num_raters desc limit 5;

-- List the least 5 thriller movies with the highest ratings.
select name , num_raters from movies_review.adventure order by num_raters limit 5;
select name , num_raters from movies_review.fantasy order by num_raters  limit 5;
select name , num_raters from movies_review.drama order by num_raters  limit 5;
select name , num_raters from movies_review.crime order by num_raters  limit 5;

-- which is the recent movie published on this genre
select name, year from movies_review.mystery order by year desc limit 1;
select name, year from movies_review.music order by year desc limit 1;
select name, year from movies_review.horror order by year desc limit 1;
select name, year from movies_review.history order by year desc limit 1;

-- Find the most reviewed movie in the War genre and the corresponding number of reviews.
select name ,num_reviews from movies_review.sport order by num_raters desc limit 3;
select name ,num_reviews from movies_review.romance order by num_raters desc limit 3;
select name ,num_reviews from movies_review.thriller order by num_raters desc limit 3;
select name ,num_reviews from movies_review.war order by num_raters desc limit 3;

-- Find the average rating for movies released after the year 2000 in both action and comedy genres.
SELECT AVG(num_raters) FROM movies_review.action WHERE year > 2000
UNION all
SELECT AVG(num_raters) FROM movies_review.comedy WHERE year > 2000;

-- joins
SELECT *
FROM Action a
INNER JOIN drama d ON a.name = d.name;

SELECT *
FROM horror h
LEFT JOIN romance r ON h.name = r.name;

SELECT T.RELEASE_DATE, T.NAME,T.RUN_LENGTH, C.RELEASE_DATE,C.NAME, C.RUN_LENGTH
FROM THRILLER T
RIGHT JOIN COMEDY C ON T.name = C.name;

SELECT *
FROM ADVENTURE A
CROSS JOIN BIOGRAPHY B ON A.YEAR=B.YEAR;

-- SELF JOIN
SELECT H1.NAME AS HORROR_MOVIE, H2.NAME AS MOVIE_NAME
FROM HORROR H1
JOIN HORROR H2 ON H1.NAME=H2.NAME;

-- Creating a Combined Genre List
SELECT name,GROUP_CONCAT(DISTINCT genres SEPARATOR '; ') AS combined_genres
FROM ( SELECT name, genres FROM COMEDY
  UNION
  SELECT name, genres  FROM CRIME
  UNION
  SELECT name, genres FROM HORROR
) AS combined
GROUP BY name;

-- Finding Movies with Multiple Genres
SELECT name, COUNT(DISTINCT genres) AS genre_count
FROM (
  SELECT name, genres FROM Action
  UNION
  SELECT name, genres FROM Adventure
  UNION
  SELECT name, genres FROM Biography
) AS combined
GROUP BY name
HAVING genre_count >0;

-- Calculating Average Ratings
SELECT name, AVG(rating) AS average_rating
FROM (
  SELECT name, rating FROM DRAMA
  UNION
  SELECT name, rating FROM FANTASY
  UNION
  SELECT name, rating FROM HORROR
) AS combined
GROUP BY name;

-- Listing Movies Released After a Specific Year
SELECT name, year
FROM (
  SELECT name, year FROM MUSIC
  UNION
  SELECT name, year FROM MYSTERY
  UNION
  SELECT name, year FROM SPORT
) AS combined
WHERE year > 2010;

-- Finding the Highest Rated Movies
SELECT name, MAX(rating) AS highest_rating
FROM (
  SELECT name, rating FROM Action
  UNION
  SELECT name, rating FROM Adventure
  UNION
  SELECT name, rating FROM ANIMATION
) AS combined
GROUP BY name
ORDER BY highest_rating DESC
LIMIT 10;
