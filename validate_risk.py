import pandas as pd
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="admin123",
    database="credit_risk_db"
)

query = "SELECT risk_category, COUNT(*) AS count FROM risk_segmentation GROUP BY risk_category"
df = pd.read_sql(query, conn)

print("Risk category distribution:")
print(df)

conn.close()

