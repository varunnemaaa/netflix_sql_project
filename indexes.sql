-- ============================================
-- Indexes for Netflix SQL Query Optimization
-- ============================================

-- Supports Q2: Most Common Rating (type + rating)
CREATE INDEX idx_netflix_type_rating
ON netflix(type, rating);


-- Supports Q4: Top 5 Countries with Most Content
CREATE INDEX idx_netflix_country
ON netflix(country);


-- Supports Q5: Longest Movie (filter by type)
CREATE INDEX idx_netflix_type
ON netflix(type);


-- Supports Q6: Content Added in Last 5 Years
CREATE INDEX idx_netflix_date_added
ON netflix(date_added);


-- Supports Q10: Avg Content Releases per Year in India
CREATE INDEX idx_netflix_country_release_year
ON netflix(country, release_year);
