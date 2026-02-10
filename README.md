# Credit-Risk-Monitoring-Dashboard
Objective: Monitor customer credit risk, track spending trends, detect anomalies, and predict high-risk customers.

# This project provides a comprehensive analysis of banking transaction data to monitor credit risk and understand customer spending patterns. By leveraging SQL for heavy data processing, Python for logic validation, and Power BI for executive-level visualization, the system identifies high-risk customers based on credit utilization and spending anomalies.


# 🛠 Tech Stack & Connectivity
1. Python (Data Generation & Validation): Used pandas and numpy to generate synthetic banking datasets and mysql-connector to validate risk segments.

2. MySQL (Data Warehousing & Processing): Central repository for raw data. Utilized Views and Window Functions for KPI calculations.

3. Power BI (Business Intelligence): Connected to MySQL to transform data into actionable visual insights.



#  Project Structure & Workflow

# 1. Data Generation (generate_data.py)
To simulate a real-world banking environment, a Python script creates a dataset of 100 customers with 12 months of transaction history, including credit limits and outstanding balances.

# 2. SQL Processing (credit-risk-analysis.sql)
The core logic resides in the SQL layer. Key operations include:

Monthly Aggregates: Summarizing spend per customer.

Window Functions: Calculating 3-month and 6-month rolling averages to detect spending trends.

Risk Segmentation: * High Risk: >80% Credit Utilization.

Medium Risk: 50-79% Credit Utilization.

Low Risk: <50% Credit Utilization.

# 3. Logic Validation (validate_risk.py)
A validation script connects to the SQL database to perform a "sanity check" on the risk distribution, ensuring the segments align with the business logic before visualization.

# 4. Interactive Dashboard (.pbix)
The final Power BI dashboard provides:

Credit Utilization KPI: Real-time tracking of debt-to-limit ratios.

Risk Distribution: Visual breakdown of Low, Medium, and High-risk segments.

Spend Analysis: Trends showing average spend vs. rolling averages.


# 📖 How to Use
Data Setup: Run generate_data.py to create the bank_transactions.csv.

Database: Import the CSV into MySQL and run credit-risk-analysis.sql to create the necessary views.

Validation: Execute validate_risk.py to confirm data integrity.

Visualization: Open the .pbix file in Power BI Desktop and refresh the data source to view the dashboard.
