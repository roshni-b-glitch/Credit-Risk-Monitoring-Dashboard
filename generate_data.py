import pandas as pd
import numpy as np
import os

# -----------------------------
# Create data folder if missing
# -----------------------------
os.makedirs("../data", exist_ok=True)

# -----------------------------
# Reproducibility
# -----------------------------
np.random.seed(42)

# -----------------------------
# Parameters
# -----------------------------
num_customers = 100
months = pd.date_range(start="2024-01-01", periods=12, freq="ME")

data = []

# -----------------------------
# Generate dummy transactions
# -----------------------------
for customer_id in range(1, num_customers + 1):
    credit_limit = np.random.choice([50000, 75000, 100000, 150000])
    outstanding_balance = np.random.randint(5000, credit_limit)

    for date in months:
        transaction_amount = np.random.randint(1000, 20000)

        data.append({
            "customer_id": f"CUST_{customer_id:03d}",
            "transaction_date": date,
            "transaction_amount": transaction_amount,
            "credit_limit": credit_limit,
            "outstanding_balance": outstanding_balance
        })

# -----------------------------
# Create DataFrame
# -----------------------------
df = pd.DataFrame(data)

# -----------------------------
# Save CSV
# -----------------------------
output_path = "../data/bank_transactions.csv"
df.to_csv(output_path, index=False)

print("✅ Dummy banking dataset generated successfully!")
print(f"📁 File saved at: {output_path}")

