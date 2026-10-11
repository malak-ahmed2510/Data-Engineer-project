select
    row_number() over(order by sales_agent) as agent_key,

    sales_agent,
    manager,
    regional_office

from {{ ref('stg_sales_teams') }}