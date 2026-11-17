-- =============================================================================
-- Apache Hive - Exploratory Data Analysis & Aggregation Queries
-- Author: Vaibhav Mistry
-- =============================================================================

USE mental_health_db;

-- 1. Demographic Analysis: Gender Diversity
SELECT gender, COUNT(*) AS count
FROM mental_health_survey
GROUP BY gender
ORDER BY count DESC;

-- 2. Geographic Distribution Across Countries
SELECT country, COUNT(*) AS count
FROM mental_health_survey
GROUP BY country
ORDER BY count DESC;

-- 3. Workplace Benefits Availability
SELECT benefits, COUNT(*) AS count
FROM mental_health_survey
GROUP BY benefits
ORDER BY count DESC;

-- 4. Remote Work Impact on Treatment-Seeking Behavior
SELECT remote_work, treatment, COUNT(*) AS count
FROM mental_health_survey
GROUP BY remote_work, treatment
ORDER BY count DESC;

-- 5. Family History Correlation with Treatment
SELECT family_history, treatment, COUNT(*) AS count
FROM mental_health_survey
GROUP BY family_history, treatment
ORDER BY count DESC;

-- 6. Anonymity Policies vs Comfort in Discussing Mental Health
SELECT anonymity, mental_health_interview, COUNT(*) AS count
FROM mental_health_survey
GROUP BY anonymity, mental_health_interview
ORDER BY count DESC;

-- 7. Leave Policy vs Treatment Rate
SELECT leave, treatment, COUNT(*) AS count
FROM mental_health_survey
GROUP BY leave, treatment
ORDER BY count DESC;

-- 8. Wellness Programs vs Seeking Help
SELECT wellness_program, seek_help, COUNT(*) AS count
FROM mental_health_survey
GROUP BY wellness_program, seek_help
ORDER BY count DESC;

-- 9. Supervisor Support vs Treatment Rate
SELECT supervisor, treatment, COUNT(*) AS count
FROM mental_health_survey
GROUP BY supervisor, treatment
ORDER BY count DESC;

-- 10. Multi-factor Correlation: Leave Policy + Remote Work + Treatment
SELECT 
    leave AS leave_policy,
    remote_work AS remote_work_status,
    treatment,
    COUNT(*) AS count
FROM mental_health_survey
GROUP BY leave, remote_work, treatment
ORDER BY count DESC;
