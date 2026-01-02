-- Q4. Top 5 Countries with Most Content

CREATE INDEX idx_country ON netflix(country);

SELECT 
    country,
    COUNT(*) AS total_content
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

--Q5. Identify the Longest Movie
CREATE INDEX idx_type ON netflix(type);

SELECT 
    title,
    duration
FROM netflix
WHERE type = 'Movie'
  AND duration IS NOT NULL
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 1;


-- Q6. Content Added in the Last 5 Years
CREATE INDEX idx_date_added ON netflix(date_added);

SELECT 
    title,
    type,
    date_added
FROM netflix
WHERE date_added >= CURRENT_DATE - INTERVAL '5 years'
  AND date_added IS NOT NULL;


 -- Q9. Number of Content Items by Genre (UNNEST)
CREATE INDEX idx_listed_in ON netflix(listed_in);

SELECT 
    TRIM(genre) AS genre,
    COUNT(*) AS total_content
FROM netflix
CROSS JOIN UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
WHERE listed_in IS NOT NULL
GROUP BY genre
ORDER BY total_content DESC;


--Q10. Average Content Releases per Year in India         
CREATE INDEX idx_country_year ON netflix(country, release_year);

WITH india_yearly_content AS (
    SELECT 
        release_year,
        COUNT(*) AS yearly_count
    FROM netflix
    WHERE country ILIKE '%India%'
      AND release_year IS NOT NULL
    GROUP BY release_year
)
SELECT 
    release_year,
    yearly_count,
    AVG(yearly_count) OVER () AS avg_yearly_releases
FROM india_yearly_content
ORDER BY release_year;

