--A/B Test Analysis (SQL Portfolio Project)
-Project Goal
--to evaluate the effectiveness of a product feature, marketing campaign, or UI change by comparing user behavior between control (A) and treatment (B) groups.

--1. Conversion Rate by Variant

SELECT 
  variant,
  COUNT(DISTINCT user_id) AS total_users,
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS converted_users,
  ROUND(
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 100.0 
    / COUNT(DISTINCT user_id), 
  2) AS conversion_rate_pct
FROM users u
LEFT JOIN events e ON u.user_id = e.user_id
GROUP BY variant;

--2. Daily Conversion Rate Trend

SELECT 
  variant,
  event_date,
  COUNT(DISTINCT user_id) AS total_users,
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS converted,
  ROUND(
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 100.0 
    / COUNT(DISTINCT user_id), 
  2) AS daily_conversion_pct
FROM users u
JOIN events e ON u.user_id = e.user_id
GROUP BY variant, event_date
ORDER BY event_date;

--3. Click-through Rate (CTR) Analysis

SELECT 
  variant,
  COUNT(DISTINCT user_id) AS users_total,
  COUNT(DISTINCT CASE WHEN event_type = 'click' THEN user_id END) AS click_users,
  ROUND(COUNT(DISTINCT CASE WHEN event_type = 'click' THEN user_id END) * 100.0 / COUNT(DISTINCT user_id), 2) AS ctr_pct
FROM users u
LEFT JOIN events e ON u.user_id = e.user_id
GROUP BY variant;

--4. Statistical Summary for Reporting

SELECT 
  variant,
  COUNT(DISTINCT user_id) AS users,
  COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_purchases,
  ROUND(AVG(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) * 100, 2) AS avg_conversion_pct
FROM users u
LEFT JOIN events e ON u.user_id = e.user_id
GROUP BY variant;
