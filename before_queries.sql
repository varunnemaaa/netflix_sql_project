-- ============================================
-- Q2: Most Common Rating for Movies and TV Shows
-- (Before Optimization)
-- ============================================

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



-- ============================================
-- Q4: Top 5 Countries with the Most Content
-- (Before Optimization)
-- ============================================

SELECT 
    country,
    COUNT(*) AS total_content
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;



-- ============================================
-- Q5: Identify the Longest Movie
-- (Before Optimization)
-- ============================================

SELECT 
    title,
    duration
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 1;



-- ============================================
-- Q6: Content Added in the Last 5 Years
-- (Before Optimization)
-- ============================================

SELECT 
    title,
    type,
    date_added
FROM netflix
WHERE date_added >= CURRENT_DATE - INTERVAL '5 years';



-- ============================================
-- Q9: Number of Content Items by Genre
-- (Before Optimization)
-- ============================================

SELECT 
    TRIM(genre) AS genre,
    COUNT(*) AS total_content
FROM netflix,
     UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
GROUP BY genre
ORDER BY total_content DESC;



-- ============================================
-- Q10: Average Content Releases per Year in India
-- (Before Optimization)
-- ============================================

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
