Netflix Data Analysis using SQL
📌 Overview

This project involves a comprehensive analysis of Netflix Movies and TV Shows using SQL. The goal is to extract meaningful insights and answer real-world business questions from the Netflix dataset.

The analysis covers content distribution, ratings, countries, genres, durations, directors, actors, and keyword-based categorization. The project demonstrates strong proficiency in SQL querying, data analysis, and problem-solving, making it ideal for GitHub portfolios, internships, and placements.

🎯 Objectives

Analyze the distribution of Movies vs TV Shows

Identify the most common ratings for each content type

Explore content by release year, country, genre, and duration

Identify top-performing countries and longest movies

Analyze director- and actor-specific content

Categorize content using keywords like Kill and Violence



📈 Key Insights

Movies dominate Netflix’s catalog

Rating preferences differ between Movies and TV Shows

India shows steady content growth over the years

Genre and keyword analysis reveal content patterns



📂 Dataset Description

Dataset Name: netflix_titles.csv

The dataset contains metadata about Netflix content.

🧾 Table Schema

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



🧪 Business Problems Solved

✅ 1. Count the Number of Movies vs TV Shows
SELECT 
    type,
    COUNT(*) AS total_content
FROM netflix
GROUP BY type;

✅ 2. Find the Most Common Rating for Movies and TV Shows
WITH rating_counts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
ranked_ratings AS (
    SELECT 
        type,
        rating,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rnk
    FROM rating_counts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM ranked_ratings
WHERE rnk = 1;

✅ 3. List All Movies Released in 2020
SELECT title, release_year
FROM netflix
WHERE type = 'Movie'
  AND release_year = 2020;

✅ 4. Top 5 Countries with the Most Content
SELECT 
    country,
    COUNT(*) AS total_content
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

✅ 5. Identify the Longest Movie
SELECT 
    title,
    duration
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 1;

✅ 6. Find Content Added in the Last 5 Years
SELECT 
    title,
    type,
    date_added
FROM netflix
WHERE date_added >= CURRENT_DATE - INTERVAL '5 years';

✅ 7. Find All Content by Director "Rajiv Chilaka"
SELECT 
    title,
    type,
    release_year
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

✅ 8. List All TV Shows with More Than 5 Seasons
SELECT 
    title,
    duration
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INT) > 5;

✅ 9. Count the Number of Content Items in Each Genre
SELECT 
    TRIM(genre) AS genre,
    COUNT(*) AS total_content
FROM netflix,
     UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
GROUP BY genre
ORDER BY total_content DESC;

✅ 10. Average Number of Content Releases per Year in India
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
    AVG(yearly_count) OVER () AS avg_yearly_releases
FROM india_yearly_content
ORDER BY release_year;

✅ 11. List All Documentary Movies
SELECT 
    title
FROM netflix
WHERE listed_in ILIKE '%Documentaries%';

✅ 12. Find All Content Without a Director
SELECT 
    title,
    type
FROM netflix
WHERE director IS NULL;

✅ 13. Movies Featuring Salman Khan in the Last 10 Years
SELECT 
    title,
    release_year
FROM netflix
WHERE caste ILIKE '%Salman Khan%'
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;

✅ 14. Categorize Content Based on Violence Keywords
SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description ILIKE '%kill%' 
              OR description ILIKE '%violence%' 
            THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) sub
GROUP BY category;✅ 1. Count the Number of Movies vs TV Shows
SELECT 
    type,
    COUNT(*) AS total_content
FROM netflix
GROUP BY type;

✅ 2. Find the Most Common Rating for Movies and TV Shows
WITH rating_counts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
ranked_ratings AS (
    SELECT 
        type,
        rating,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rnk
    FROM rating_counts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM ranked_ratings
WHERE rnk = 1;

✅ 3. List All Movies Released in 2020
SELECT title, release_year
FROM netflix
WHERE type = 'Movie'
  AND release_year = 2020;

✅ 4. Top 5 Countries with the Most Content
SELECT 
    country,
    COUNT(*) AS total_content
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

✅ 5. Identify the Longest Movie
SELECT 
    title,
    duration
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 1;

✅ 6. Find Content Added in the Last 5 Years
SELECT 
    title,
    type,
    date_added
FROM netflix
WHERE date_added >= CURRENT_DATE - INTERVAL '5 years';

✅ 7. Find All Content by Director "Rajiv Chilaka"
SELECT 
    title,
    type,
    release_year
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

✅ 8. List All TV Shows with More Than 5 Seasons
SELECT 
    title,
    duration
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INT) > 5;

✅ 9. Count the Number of Content Items in Each Genre
SELECT 
    TRIM(genre) AS genre,
    COUNT(*) AS total_content
FROM netflix,
     UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
GROUP BY genre
ORDER BY total_content DESC;

✅ 10. Average Number of Content Releases per Year in India
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
    AVG(yearly_count) OVER () AS avg_yearly_releases
FROM india_yearly_content
ORDER BY release_year;

✅ 11. List All Documentary Movies
SELECT 
    title
FROM netflix
WHERE listed_in ILIKE '%Documentaries%';

✅ 12. Find All Content Without a Director
SELECT 
    title,
    type
FROM netflix
WHERE director IS NULL;

✅ 13. Movies Featuring Salman Khan in the Last 10 Years
SELECT 
    title,
    release_year
FROM netflix
WHERE caste ILIKE '%Salman Khan%'
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;

✅ 14. Categorize Content Based on Violence Keywords
SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description ILIKE '%kill%' 
              OR description ILIKE '%violence%' 
            THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) sub
GROUP BY category;


💼 Skills Demonstrated

Advanced SQL querying

Data analysis & EDA

Business problem solving

Use of CTEs & window functions

Real-world dataset handling


🚀 Conclusion

This project showcases the ability to transform raw data into actionable insights using SQL. It reflects strong analytical thinking and database skills, suitable for Data Analyst, SQL Developer, and Software Engineering roles.


