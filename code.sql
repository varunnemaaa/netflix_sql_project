CREATE TABLE netflix (
    show_id VARCHAR(20),
    type VARCHAR(20),
    title VARCHAR(255),
    director VARCHAR(255),
    caste VARCHAR(1000),
    country VARCHAR(150),
    date_added DATE,
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(50),
    listed_in VARCHAR(255),
    description TEXT
);


select * from netflix

select distinct type 
from netflix


--15 business problems

 -- Q1--Count the Number of Movies vs TV Shows
select type, 
COUNT(*) as TOTAL_CONTENT
from netflix
group by  type 


--Q2 Find the Most Common Rating for Movies and TV Shows.

WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;



--List All Movies Released in a Specific Year (e.g., 2020)
SELECT * FROM NETFLIX
SELECT TITLE,release_year from netflix where  release_year = '2020' and type = 'Movie';

--. Find the Top 5 Countries with the Most Content on Netflix


 SELECT country,
        COUNT(*) AS most_content
    FROM netflix
 where country is not null 
 group by country 
 order by most_content desc
 limit 5;

--Identify the Longest Movie
SELECT 
    title,
    duration
FROM netflix
WHERE type = 'Movie'
and duration is not null
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 1;

--Find Content Added in the Last 5 Years

SELECT 
    title,
    type,
    date_added
FROM netflix
WHERE date_added IS NOT NULL
  AND date_added >= CURRENT_DATE - INTERVAL '5 years'
ORDER BY date_added DESC;

---Find All Movies/TV Shows by Director 'Rajiv Chilaka'
SELECT 
    title,
    type,
    director,
    release_year
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';



 --List All TV Shows with More Than 5 Seasons
select  * from netflix
where type  = 'TV Show' and split_part(duration, ' ', 1)::INT > 5;


-- Count the Number of Content Items in Each Genre

SELECT 
    TRIM(genre) AS genre,
    COUNT(*) AS total_content
FROM netflix,
     UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
GROUP BY genre
ORDER BY total_content DESC;


--0.Find each year and the average numbers of content release in India on netflix.
WITH india_yearly_content AS (
    SELECT 
        release_year,
        COUNT(*) AS yearly_count
    FROM netflix
    WHERE country ILIKE '%India%'
    GROUP BY release_year
)
SELECT 
    release_year,
    yearly_count,
    AVG(yearly_count) OVER () AS average_yearly_releases
FROM india_yearly_content
ORDER BY release_year;

--List All Movies that are Documentaries
select type ,title from netflix
where listed_in ilike '%Documentaries'



--Find All Content Without a Director
select title from netflix 
where director is null


--Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
select * from netflix
where caste LIKE '%Salman Khan%'  and release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;



-- Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords
SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY category;