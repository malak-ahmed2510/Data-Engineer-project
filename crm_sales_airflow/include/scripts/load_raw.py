import os
import duckdb
import pandas as pd

os.makedirs("/usr/local/airflow/include/warehouse", exist_ok=True)

con = duckdb.connect(
    "/usr/local/airflow/include/warehouse/crm.duckdb"
)

accounts = pd.read_csv(
    "/usr/local/airflow/include/data/raw/accounts.csv"
)

products = pd.read_csv(
    "/usr/local/airflow/include/data/raw/products.csv"
)

sales_teams = pd.read_csv(
    "/usr/local/airflow/include/data/raw/sales_teams.csv"
)

sales_pipeline = pd.read_csv(
    "/usr/local/airflow/include/data/raw/sales_pipeline.csv"
)

con.execute("CREATE SCHEMA IF NOT EXISTS raw")

con.register("accounts_df", accounts)
con.register("products_df", products)
con.register("sales_teams_df", sales_teams)
con.register("sales_pipeline_df", sales_pipeline)

con.execute("""
CREATE OR REPLACE TABLE raw.accounts AS
SELECT * FROM accounts_df
""")

con.execute("""
CREATE OR REPLACE TABLE raw.products AS
SELECT * FROM products_df
""")

con.execute("""
CREATE OR REPLACE TABLE raw.sales_teams AS
SELECT * FROM sales_teams_df
""")

con.execute("""
CREATE OR REPLACE TABLE raw.sales_pipeline AS
SELECT * FROM sales_pipeline_df
""")

print("RAW tables loaded successfully!")