from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="crm_sales_etl",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False,
    tags=["crm", "duckdb", "dbt"]
) as dag:

    load_raw = BashOperator(
        task_id="load_raw",
        bash_command="""
        python /usr/local/airflow/include/scripts/load_raw.py
        """
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="""
        cd /usr/local/airflow/include/crm_dbt &&
        dbt run --profiles-dir /usr/local/airflow/.dbt
        """
    )

    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="""
        cd /usr/local/airflow/include/crm_dbt &&
        dbt test --profiles-dir /usr/local/airflow/.dbt
        """
    )

    load_raw >> dbt_run >> dbt_test