with dates as (

    select cast(engage_date as date) as full_date
    from {{ ref('stg_sales_pipeline') }}

    union

    select cast(close_date as date) as full_date
    from {{ ref('stg_sales_pipeline') }}

)

select

    cast(strftime(full_date,'%Y%m%d') as integer) as date_key,

    full_date,

    year(full_date) as year,

    quarter(full_date) as quarter,

    month(full_date) as month,

    strftime(full_date,'%B') as month_name,

    day(full_date) as day,

    strftime(full_date,'%A') as day_of_week

from dates

where full_date is not null