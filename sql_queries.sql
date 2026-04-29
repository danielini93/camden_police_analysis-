# camden_police_analysis-
SQL analysis of police stop data 
-- ============================================================================
-- PART 1: BASIC EXPLORATION
-- Skill Level: Beginner
-- What we're doing: Looking at the raw data
-- ============================================================================

-- Query 1.1: How many rows in the dataset?
-- This helps us understand the size of our dataset
SELECT COUNT(*) as total_records
FROM `green-jet-480314-d4.nj_candem_2020.candem`
LIMIT 1;

-- Query 1.2: Show first 10 rows
-- This helps us see what the data actually looks like
SELECT *
FROM `green-jet-480314-d4.nj_candem_2020.candem`
LIMIT 10;

-- Query 1.3: What columns do we have?
-- Understanding our data structure
SELECT *
FROM `green-jet-480314-d4.nj_candem_2020.candem`
LIMIT 1;

-- ============================================================================
-- PART 2: BASIC QUESTIONS
-- Skill Level: Beginner+
-- What we're doing: Asking simple questions about the data
-- ============================================================================

-- Query 2.1: How many vehicular vs pedestrian stops?
-- This helps us understand the composition of our data
SELECT 
  type,
  COUNT(*) as number_of_stops
FROM `green-jet-480314-d4.nj_candem_2020.candem`
GROUP BY type;

-- Query 2.2: What races are represented?
-- Important demographic information
SELECT 
  subject_race,
  COUNT(*) as count
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE subject_race IS NOT NULL  -- Only look at non-null values
GROUP BY subject_race
ORDER BY count DESC;

-- Query 2.3: What genders are in the data?
SELECT
  subject_sex,
  COUNT(*) as count
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE subject_sex IS NOT NULL
GROUP BY subject_sex
ORDER BY count DESC;

-- Query 2.4: What ages are represented?
-- Understanding age distribution
SELECT 
  subject_age,
  COUNT(*) as count
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE subject_age IS NOT NULL
GROUP BY subject_age
ORDER BY subject_age;

-- ============================================================================
-- PART 3: DATA QUALITY CHECKS
-- Skill Level: Intermediate
-- What we're doing: Checking for missing data
-- ============================================================================

-- Query 3.1: Check for missing values
-- Important for data quality assessment
SELECT 
  COUNT(*) as total_rows,
  COUNT(subject_age) as have_age,
  COUNT(subject_race) as have_race,
  COUNT(subject_sex) as have_gender,
  COUNT(vehicle_color) as have_vehicle_color,
  COUNT(vehicle_make) as have_vehicle_make,
  COUNT(vehicle_model) as have_vehicle_model,
  COUNT(arrest_made) as have_arrest_data
FROM `green-jet-480314-d4.nj_candem_2020.candem`;

-- ============================================================================
-- PART 4: VEHICLE ANALYSIS (THE MAIN QUESTION)
-- Skill Level: Intermediate+
-- Question: Which vehicles are most prone to being stopped?
-- ============================================================================

-- Query 4.1: Filter to vehicular stops only
-- We only care about cars for this analysis
SELECT COUNT(*) as vehicular_stops
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular';

-- Query 4.2: Which colors are stopped most?
-- Basic color analysis
SELECT
  vehicle_color,
  COUNT(*) as times_stopped
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_color IS NOT NULL
GROUP BY vehicle_color
ORDER BY times_stopped DESC;

-- Query 4.3: Colors with percentages
-- Same analysis but showing percentages
SELECT
  vehicle_color,
  COUNT(*) as times_stopped,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) as percent_of_stops
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_color IS NOT NULL
GROUP BY vehicle_color
ORDER BY times_stopped DESC;

-- Query 4.4: Which makes (brands) are stopped most?
-- Looking at car brands
SELECT
  vehicle_make,
  COUNT(*) as times_stopped
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_make IS NOT NULL
GROUP BY vehicle_make
ORDER BY times_stopped DESC
LIMIT 15;

-- Query 4.5: Makes with percentages
-- Same but with percentages
SELECT
  vehicle_make,
  COUNT(*) as times_stopped,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) as percent_of_stops
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_make IS NOT NULL
GROUP BY vehicle_make
ORDER BY times_stopped DESC
LIMIT 15;

-- Query 4.6: Which models are stopped most?
-- Breaking down by specific model
SELECT
  vehicle_make,
  vehicle_model,
  COUNT(*) as times_stopped
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_make IS NOT NULL
  AND vehicle_model IS NOT NULL
GROUP BY vehicle_make, vehicle_model
ORDER BY times_stopped DESC
LIMIT 15;

-- Query 4.7: Models with percentages
SELECT
  vehicle_make,
  vehicle_model,
  COUNT(*) as times_stopped,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) as percent_of_stops
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_make IS NOT NULL
  AND vehicle_model IS NOT NULL
GROUP BY vehicle_make, vehicle_model
ORDER BY times_stopped DESC
LIMIT 15;

-- ============================================================================
-- PART 5: ADVANCED ANALYSIS
-- Skill Level: Advanced
-- What we're doing: Combining multiple variables
-- ============================================================================

-- Query 5.1: Color + Make combinations
-- Seeing which color-brand combos are most common
SELECT
  vehicle_color,
  vehicle_make,
  COUNT(*) as times_stopped,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) as percent_of_stops
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_color IS NOT NULL
  AND vehicle_make IS NOT NULL
GROUP BY vehicle_color, vehicle_make
ORDER BY times_stopped DESC
LIMIT 15;

-- Query 5.2: Complete picture - Color + Make + Model + Arrests
-- This is the most comprehensive query
-- Shows everything together
SELECT
  vehicle_color,
  vehicle_make,
  vehicle_model,
  COUNT(*) as times_stopped,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) as percent_of_all_cars,
  COUNTIF(arrest_made = TRUE) as arrests,
  ROUND(100 * COUNTIF(arrest_made = TRUE) / COUNT(*), 1) as arrest_rate_pct
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_color IS NOT NULL
  AND vehicle_make IS NOT NULL
  AND vehicle_model IS NOT NULL
GROUP BY vehicle_color, vehicle_make, vehicle_model
ORDER BY times_stopped DESC
LIMIT 20;

-- ============================================================================
-- PART 6: COMPARING OUTCOMES
-- Skill Level: Intermediate
-- What we're doing: Looking at arrest rates by vehicle type
-- ============================================================================

-- Query 6.1: Do certain colors have different arrest rates?
SELECT
  vehicle_color,
  COUNT(*) as cars_stopped,
  COUNTIF(arrest_made = TRUE) as arrests,
  ROUND(100 * COUNTIF(arrest_made = TRUE) / COUNT(*), 1) as arrest_rate_pct
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_color IS NOT NULL
GROUP BY vehicle_color
ORDER BY arrest_rate_pct DESC;

-- Query 6.2: Do certain makes have different arrest rates?
SELECT
  vehicle_make,
  COUNT(*) as cars_stopped,
  COUNTIF(arrest_made = TRUE) as arrests,
  ROUND(100 * COUNTIF(arrest_made = TRUE) / COUNT(*), 1) as arrest_rate_pct
FROM `green-jet-480314-d4.nj_candem_2020.candem`
WHERE type = 'vehicular'
  AND vehicle_make IS NOT NULL
GROUP BY vehicle_make
ORDER BY arrest_rate_pct DESC
LIMIT 10;
