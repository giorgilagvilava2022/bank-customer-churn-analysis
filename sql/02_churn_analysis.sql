-- 1. Data inspection (first 10 rows)
SELECT *
FROM customer_churn
LIMIT 10;


-- 2. Overall churn KPI summary 
SELECT
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct,
    ROUND(SUM(CASE WHEN exited = 1 THEN balance ELSE 0 END), 2)     AS total_balance_lost
FROM customer_churn;


-- 3. Geographic churn rate, lost balance, and gap vs. overall average
WITH overall AS (
    SELECT AVG(exited) AS overall_churn
    FROM customer_churn
)
SELECT
    c.geography,
    COUNT(c.customer_id)                                            AS total_customers,
    SUM(c.exited)                                                   AS churned_customers,
    ROUND(AVG(c.exited) * 100, 2)                                   AS churn_rate_pct,
    ROUND((AVG(c.exited) - o.overall_churn) * 100, 2)               AS diff_vs_overall_pp,
    ROUND(100.0 * SUM(c.exited) / SUM(SUM(c.exited)) OVER (), 2)    AS share_of_all_churn_pct,
    ROUND(SUM(CASE WHEN c.exited = 1 THEN c.balance ELSE 0 END), 2) AS balance_lost
FROM customer_churn c
CROSS JOIN overall o
GROUP BY c.geography, o.overall_churn
ORDER BY churn_rate_pct DESC;


-- 4. Age group segmentation & churn rate
SELECT
    CASE
        WHEN age < 30 THEN '18-29'
        WHEN age < 40 THEN '30-39'
        WHEN age < 50 THEN '40-49'
        ELSE '50+'
    END                                                             AS age_group,
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY age_group
ORDER BY MIN(age);


-- 5. Gender vs churn (was missing from the original analysis)
SELECT
    gender,
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY gender
ORDER BY churn_rate_pct DESC;


-- 6. Number of products vs churn
SELECT
    num_of_products,
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY num_of_products
ORDER BY num_of_products;


-- 7. Complaints vs churn
SELECT
    complain,
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY complain
ORDER BY complain;


-- 8. Products x complaints 
SELECT
    num_of_products,
    complain,
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY num_of_products, complain
ORDER BY num_of_products, complain;


-- 9. Top 3 highest-balance churned customers per country
WITH ranked_churn AS (
    SELECT
        customer_id,
        surname,
        geography,
        balance,
        card_type,
        ROW_NUMBER() OVER (
            PARTITION BY geography
            ORDER BY balance DESC, customer_id
        ) AS rank_in_country
    FROM customer_churn
    WHERE exited = 1
)
SELECT
    geography,
    rank_in_country,
    customer_id,
    surname,
    balance,
    card_type
FROM ranked_churn
WHERE rank_in_country <= 3
ORDER BY geography, rank_in_country;


-- 10. Active member churn impact
SELECT
    is_active_member,
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY is_active_member
ORDER BY is_active_member;


-- 11. Credit score category vs churn rate
SELECT
    CASE
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score < 670 THEN 'Fair'
        WHEN credit_score < 740 THEN 'Good'
        WHEN credit_score < 800 THEN 'Very Good'
        ELSE 'Exceptional'
    END                                                             AS credit_category,
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY credit_category
ORDER BY MIN(credit_score);


-- 12. Tenure (years with bank) vs churn rate
SELECT
    tenure,
    COUNT(customer_id)                                              AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY tenure
ORDER BY tenure;


-- 13. Multi-dimensional: geography x age group (find the riskiest segments)
WITH segmented AS (
    SELECT
        geography,
        CASE
            WHEN age < 30 THEN '18-29'
            WHEN age < 40 THEN '30-39'
            WHEN age < 50 THEN '40-49'
            ELSE '50+'
        END AS age_group,
        exited,
        balance
    FROM customer_churn
)
SELECT
    geography,
    age_group,
    COUNT(*)                                                        AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct,
    ROUND(SUM(CASE WHEN exited = 1 THEN balance ELSE 0 END), 2)     AS balance_lost
FROM segmented
GROUP BY geography, age_group
HAVING COUNT(*) >= 30          
ORDER BY churn_rate_pct DESC;


-- 14. Multi-dimensional: activity x number of products
SELECT
    is_active_member,
    num_of_products,
    COUNT(*)                                                        AS total_customers,
    SUM(exited)                                                     AS churned_customers,
    ROUND(AVG(exited) * 100, 2)                                     AS churn_rate_pct
FROM customer_churn
GROUP BY is_active_member, num_of_products
ORDER BY is_active_member, num_of_products;
