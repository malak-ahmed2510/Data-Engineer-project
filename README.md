# CRM Sales Opportunities – Data Warehouse (Airflow + dbt + DuckDB)

Dimensional model (star schema) and ETL pipeline for the Maven Analytics
[CRM Sales Opportunities](https://mavenanalytics.io/data-playground/crm-sales-opportunities) dataset.

## Architecture

CSV files -> `load_raw.py` (DuckDB `raw` schema) -> dbt staging -> dbt marts (star schema) -> dbt tests

Orchestrated by the Airflow DAG `crm_sales_etl`: `load_raw >> dbt_run >> dbt_test`

## Star schema

- Fact: `fact_sales_opportunities` (grain: one row per opportunity)
- Dimensions: `dim_account`, `dim_product`, `dim_sales_agent`, `dim_date` (role-playing: engage date and close date)

Conceptual and logical schema diagrams are in `Images/`; the physical DDL is in
`crm_sales_airflow/include/crm_dbt/sql/physical_schema.sql`.

## Project structure

```
.
├── Images/                              # diagrams and screenshots
└── crm_sales_airflow/                   # Astro (Airflow) project
    ├── dags/crm_sales_etl.py            # Airflow DAG
    ├── .dbt/profiles.yml                # dbt profile (DuckDB)
    ├── include/
    │   ├── data/raw/                    # source CSVs
    │   ├── scripts/load_raw.py          # loads CSVs into DuckDB schema `raw`
    │   └── crm_dbt/                     # dbt project (models/staging, models/marts, tests)
    └── Dockerfile, requirements.txt, packages.txt
```

## How to run

Prerequisites: Docker Desktop and the [Astro CLI](https://www.astronomer.io/docs/astro/cli/install-cli).

1. `cd crm_sales_airflow`
2. `astro dev start`
3. Open the Airflow UI (http://localhost:8080), enable `crm_sales_etl` and press **Trigger**.
4. The warehouse is created at `include/warehouse/crm.duckdb` (`raw` schema + star schema in `main`).

## Data quality handling

- `GTXPro` renamed to `GTX Pro` in `stg_sales_pipeline` to match the products table.
- Sector typo `technolgy` fixed in `stg_accounts`.
- Opportunities without an account and open deals (no close date or value) are kept, with NULL keys or values.
