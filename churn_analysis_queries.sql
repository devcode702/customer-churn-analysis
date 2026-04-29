-- =========================================
-- 📊 CUSTOMER CHURN ANALYSIS (SQL)
-- =========================================

CREATE DATABASE churn_project;
USE churn_project;

-- -----------------------------------------
-- 1. PREVIEW DATA
-- -----------------------------------------
SELECT * 
FROM music_churn 
LIMIT 10;

-- -----------------------------------------
-- 2. OVERALL CHURN DISTRIBUTION
-- -----------------------------------------
SELECT 
    subscription_status,
    COUNT(*) AS total_users,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM music_churn), 2) AS percentage
FROM music_churn
GROUP BY subscription_status;

-- -----------------------------------------
-- 3. CHURN RATE BY ENGAGEMENT LEVEL
-- -----------------------------------------
SELECT 
    Engagement_Level,
    ROUND(
        SUM(CASE WHEN subscription_status = 'Inactive' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 
    2) AS churn_rate_percentage
FROM music_churn
GROUP BY Engagement_Level;

-- -----------------------------------------
-- 4. CHURN RATE BY SKIP BEHAVIOR
-- -----------------------------------------
SELECT 
    Skip_Group,
    ROUND(
        SUM(CASE WHEN subscription_status = 'Inactive' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 
    2) AS churn_rate_percentage
FROM music_churn
GROUP BY Skip_Group;

-- -----------------------------------------
-- 5. INACTIVITY VS CHURN (COUNT)
-- -----------------------------------------
SELECT 
    inactive_3_months_flag,
    subscription_status,
    COUNT(*) AS total_users
FROM music_churn
GROUP BY inactive_3_months_flag, subscription_status;

-- -----------------------------------------
-- 6. CHURN RATE BY INACTIVITY
-- -----------------------------------------
SELECT 
    inactive_3_months_flag,
    ROUND(
        SUM(CASE WHEN subscription_status = 'Inactive' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 
    2) AS churn_rate_percentage
FROM music_churn
GROUP BY inactive_3_months_flag;