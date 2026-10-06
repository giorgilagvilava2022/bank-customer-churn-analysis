Bank Customer Churn Analysis (PostgreSQL)

##  Project Overview
This project performs an end-to-end SQL analysis on bank customer churn dataset using **PostgreSQL**. The primary objective is to investigate demographic, geographic, financial, and behavioral drivers leading to customer exits (`exited = 1`) and evaluate the financial impact in terms of lost balances.

---

##  Tech Stack & SQL Concepts Applied
- Database Environment: PostgreSQL
- SQL Concepts Used:
  - Aggregations & Financial Metrics: `COUNT()`, `SUM()`, `AVG()`, `ROUND()`
  - Conditional Logic: `CASE WHEN` statements for demographic age categorization and credit score grouping.
  - Advanced Analytics: Window Functions (`DENSE_RANK() OVER (PARTITION BY ... ORDER BY ...)`) to identify top lost assets per region.
  - Multi-variable Grouping: Analyzing churn rate correlations across products and customer complaints.

---

##  Key Business Questions & SQL Queries
1. Geographic Distribution: Evaluates churn percentages and total balance lost per country (`Germany`, `France`, `Spain`).
2. Demographic Risk: Groups customers by age cohorts (`18-30`, `31-45`, `46-60`, `60+`) to isolate vulnerable demographics.
3. Product & Complaint Correlation: Evaluates churn rate behavior relative to product count and formal customer complaints.
4. Top At-Risk Churned Accounts: Ranks top 3 highest-balance churned customers per country.
5. Behavioral Indicators: Evaluates impact of account activity status (`is_active_member`), credit tier, and tenure (years with bank).

Project Results Summary

This project analyzes a dataset of 10,000 bank customers to identify which customer groups are most likely to leave the bank (churn). The data was cleaned, enriched with segmentation fields (age group, balance category, activity status), and analyzed through KPI calculations, pivot tables, an interactive "Churn Explorer" with filters and lookups, and a final dashboard.

Key findings:

Overall churn: 2,038 of 10,000 customers left, a churn rate of 20.4%.
Geography: Germany has the highest churn (32.4%), roughly double France (16.2%) and Spain (16.7%).
Age: Churn rises sharply with age: 7.6% for ages 18–29, 30.8% for 40–49, and 45.4% for 50+.
Products: Customers with 3 or 4 products churn at 82.7% and 100%, while those with 2 products churn the least (7.6%).
Gender: Women churn more than men (25.1% vs 16.5%), and this holds in every country.
Activity: Inactive members churn at 26.9% versus 14.3% for active members.
Balance: Churned customers hold a higher average balance (€91.1k vs €72.7k), so the bank loses valuable clients. Card type has little effect on churn (19–22%).
Combined effect: German customers aged 50+ show the highest churn of all (61%).

Recommendation: Focus retention efforts on customers in Germany, aged 40+, who are inactive or hold 3+ products.
