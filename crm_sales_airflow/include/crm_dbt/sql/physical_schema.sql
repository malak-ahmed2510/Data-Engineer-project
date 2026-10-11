CREATE TABLE dim_account (
    account_key INTEGER PRIMARY KEY,
    account_name VARCHAR NOT NULL,
    sector VARCHAR,
    year_established INTEGER,
    revenue DECIMAL(18,2),
    employees INTEGER,
    office_location VARCHAR,
    parent_account VARCHAR
);

CREATE TABLE dim_product (
    product_key INTEGER PRIMARY KEY,
    product_name VARCHAR NOT NULL,
    series VARCHAR,
    sales_price DECIMAL(12,2)
);

CREATE TABLE dim_sales_agent (
    agent_key INTEGER PRIMARY KEY,
    sales_agent VARCHAR NOT NULL,
    manager VARCHAR,
    regional_office VARCHAR
);

CREATE TABLE dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    month INTEGER NOT NULL,
    month_name VARCHAR NOT NULL,
    day INTEGER NOT NULL,
    day_of_week VARCHAR NOT NULL
);

CREATE TABLE fact_sales_opportunities (
    opportunity_id VARCHAR PRIMARY KEY,

    account_key INTEGER,
    product_key INTEGER NOT NULL,
    agent_key INTEGER NOT NULL,

    engage_date_key INTEGER,
    close_date_key INTEGER,

    deal_stage VARCHAR NOT NULL,
    close_value DECIMAL(18,2),

    FOREIGN KEY (account_key)
        REFERENCES dim_account(account_key),

    FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key),

    FOREIGN KEY (agent_key)
        REFERENCES dim_sales_agent(agent_key),

    FOREIGN KEY (engage_date_key)
        REFERENCES dim_date(date_key),

    FOREIGN KEY (close_date_key)
        REFERENCES dim_date(date_key)
);