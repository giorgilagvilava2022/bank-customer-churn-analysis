-- 1. Full data inspection
SELECT * FROM customer_churn;

-- 2. Geographic churn rate & financial balance lost
SELECT 
    geography,
    COUNT(customer_id) AS total_customers,
    SUM(exited) AS churned_customers,
    ROUND(AVG(exited) * 100, 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN exited = 1 THEN balance ELSE 0 END), 2) AS balance_lost
FROM customer_churn
GROUP BY geography
ORDER BY churn_rate_pct DESC;

-- 3. Age Group segmentation & Churn rate
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 30 THEN '18-30 (Young)'
        WHEN age BETWEEN 31 AND 45 THEN '31-45 (Adults)'
        WHEN age BETWEEN 46 AND 60 THEN '46-60 (Middle Age)'
        ELSE '60+ (Seniors)'
    END AS age_group,
    COUNT(customer_id) AS total_customers,
    SUM(exited) AS churned_customers,
    ROUND(AVG(exited) * 100, 2) AS churn_rate_pct
FROM customer_churn
GROUP BY age_group
ORDER BY churn_rate_pct DESC;

-- 4. Overall Churn KPI Summary
SELECT 
    COUNT(customer_id) AS total_customers,
    SUM(exited) AS churned_customers,
    ROUND(AVG(exited) * 100, 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN exited = 1 THEN balance ELSE 0 END), 2) AS total_balance_lost
FROM customer_churn;

-- 5. Impact of Number of Products & Complaints on Churn
SELECT 
    num_of_products,
    complain,
    COUNT(customer_id) AS total_customers,
    SUM(exited) AS churned,
    ROUND(AVG(exited) * 100, 2) AS churn_rate_pct
FROM customer_churn
GROUP BY num_of_products, complain
ORDER BY num_of_products, complain;

-- 6. Top 3 Highest Balance Churned Customers per Country
WITH RankedChurn AS (
    SELECT 
        customer_id,
        surname,
        geography,
        balance,
        card_type,
        DENSE_RANK() OVER (PARTITION BY geography ORDER BY balance DESC) AS rank_in_country
    FROM customer_churn
    WHERE exited = 1
)
SELECT * 
FROM RankedChurn 
WHERE rank_in_country <= 3;

-- 7. Active Member Churn Impact
SELECT 
    is_active_member,
    COUNT(customer_id) AS total_customers,
    SUM(exited) AS churned_customers,
    ROUND(AVG(exited) * 100, 2) AS churn_rate_pct
FROM customer_churn
GROUP BY is_active_member;

-- 8. Credit Score Category vs Churn Rate
SELECT 
    CASE 
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score BETWEEN 580 AND 669 THEN 'Fair'
        WHEN credit_score BETWEEN 670 AND 739 THEN 'Good'
        WHEN credit_score BETWEEN 740 AND 799 THEN 'Very Good'
        ELSE 'Exceptional'
    END AS credit_category,
    COUNT(customer_id) AS total_customers,
    ROUND(AVG(exited) * 100, 2) AS churn_rate_pct
FROM customer_churn
GROUP BY credit_category
ORDER BY churn_rate_pct DESC;

-- 9. Tenure (Years with bank) vs Churn Rate
SELECT 
    tenure,
    COUNT(customer_id) AS total_customers,
    SUM(exited) AS churned_customers,
    ROUND(AVG(exited) * 100, 2) AS churn_rate_pct
FROM customer_churn
GROUP BY tenure
ORDER BY tenure ASC;
