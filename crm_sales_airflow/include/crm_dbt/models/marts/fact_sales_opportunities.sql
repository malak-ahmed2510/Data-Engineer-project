select

    sp.opportunity_id,

    da.account_key,

    dp.product_key,

    ds.agent_key,

    ed.date_key as engage_date_key,

    cd.date_key as close_date_key,

    sp.deal_stage,

    sp.close_value

from {{ ref('stg_sales_pipeline') }} sp

left join {{ ref('dim_account') }} da
    on sp.account = da.account_name

left join {{ ref('dim_product') }} dp
    on sp.product = dp.product_name

left join {{ ref('dim_sales_agent') }} ds
    on sp.sales_agent = ds.sales_agent

left join {{ ref('dim_date') }} ed
    on cast(sp.engage_date as date) = ed.full_date

left join {{ ref('dim_date') }} cd
    on cast(sp.close_date as date) = cd.full_date