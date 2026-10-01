Bank Customer Churn Analysis (PostgreSQL)

##  Project Overview
This project performs an end-to-end SQL analysis on bank customer churn dataset using **PostgreSQL**. The primary objective is to investigate demographic, geographic, financial, and behavioral drivers leading to customer exits (`exited = 1`) and evaluate the financial impact in terms of lost balances.

---

##  Tech Stack & SQL Concepts Applied
- **Database Environment:** PostgreSQL
- **SQL Concepts Used:**
  - **Aggregations & Financial Metrics:** `COUNT()`, `SUM()`, `AVG()`, `ROUND()`
  - **Conditional Logic:** `CASE WHEN` statements for demographic age categorization and credit score grouping.
  - **Advanced Analytics:** Window Functions (`DENSE_RANK() OVER (PARTITION BY ... ORDER BY ...)`) to identify top lost assets per region.
  - **Multi-variable Grouping:** Analyzing churn rate correlations across products and customer complaints.

---

##  Key Business Questions & SQL Queries
1. **Geographic Distribution:** Evaluates churn percentages and total balance lost per country (`Germany`, `France`, `Spain`).
2. **Demographic Risk:** Groups customers by age cohorts (`18-30`, `31-45`, `46-60`, `60+`) to isolate vulnerable demographics.
3. **Product & Complaint Correlation:** Evaluates churn rate behavior relative to product count and formal customer complaints.
4. **Top At-Risk Churned Accounts:** Ranks top 3 highest-balance churned customers per country.
5. **Behavioral Indicators:** Evaluates impact of account activity status (`is_active_member`), credit tier, and tenure (years with bank).

