select
    opportunity_id,
    sales_agent,

    case
        when product = 'GTXPro'
        then 'GTX Pro'
        else product
    end as product,

    account,
    deal_stage,
    engage_date,
    close_date,
    close_value

from raw.sales_pipeline