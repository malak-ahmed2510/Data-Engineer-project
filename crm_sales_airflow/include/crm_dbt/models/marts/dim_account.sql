select
    row_number() over(order by account_name) as account_key,

    account_name,
    sector,
    year_established,
    revenue,
    employees,
    office_location,
    parent_account

from {{ ref('stg_accounts') }}