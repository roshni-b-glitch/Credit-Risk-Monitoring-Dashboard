CREATE DATABASE credit_risk_db;
USE credit_risk_db;


CREATE TABLE bank_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(20),
    transaction_date DATE,
    transaction_amount DECIMAL(10,2),
    credit_limit INT,
    outstanding_balance INT
);

SELECT COUNT(*) FROM bank_transactions;


-- Monthly Customer Spend
CREATE VIEW monthly_customer_spend AS
SELECT
    customer_id,
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    SUM(transaction_amount) AS monthly_spend
FROM bank_transactions
GROUP BY customer_id, month;

SELECT * FROM monthly_customer_spend LIMIT 5;

-- Rolling 3-Month Average Spend

CREATE VIEW rolling_3_month_avg AS
SELECT
    customer_id,
    transaction_date,
    transaction_amount,
    ROUND(
        AVG(transaction_amount) OVER (
            PARTITION BY customer_id
            ORDER BY transaction_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_3m_avg_spend
FROM bank_transactions;


-- Credit Utilization KPI
CREATE VIEW credit_utilization AS
SELECT
    customer_id,
    credit_limit,
    outstanding_balance,
    ROUND((outstanding_balance / credit_limit) * 100, 2) AS utilization_pct
FROM bank_transactions;

-- Risk Segmentation
CREATE VIEW risk_segmentation AS
SELECT
    customer_id,
    credit_limit,
    outstanding_balance,
    ROUND((outstanding_balance / credit_limit) * 100, 2) AS utilization_pct,
    CASE
        WHEN (outstanding_balance / credit_limit) * 100 >= 80 THEN 'High Risk'
        WHEN (outstanding_balance / credit_limit) * 100 BETWEEN 50 AND 79 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM bank_transactions;

-- cross check 
SELECT
    risk_category,
    COUNT(*) AS count
FROM risk_segmentation
GROUP BY risk_category;

CREATE VIEW customer_spend_rolling_avg AS
SELECT
    customer_id,
    month,
    monthly_spend,

    -- Rolling 3-month average
    AVG(monthly_spend) OVER (
        PARTITION BY customer_id
        ORDER BY month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3_month_avg,

    -- Rolling 6-month average
    AVG(monthly_spend) OVER (
        PARTITION BY customer_id
        ORDER BY month
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    ) AS rolling_6_month_avg

FROM monthly_customer_spend;

-- list all views
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- see working
SELECT * FROM monthly_customer_spend
LIMIT 10;

-- check a single customer
SELECT *
FROM monthly_customer_spend
WHERE customer_id = 'CUST_001'
ORDER BY month;



SELECT COUNT(*) FROM monthly_customer_spend;

SELECT DISTINCT customer_id
FROM monthly_customer_spend
ORDER BY customer_id
LIMIT 20;






