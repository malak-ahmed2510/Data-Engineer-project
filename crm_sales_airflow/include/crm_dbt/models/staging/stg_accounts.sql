select
    account as account_name,

    case
        when lower(sector) = 'technolgy'
        then 'technology'
        else lower(sector)
    end as sector,

    year_established,
    revenue,
    employees,
    office_location,

    subsidiary_of as parent_account

from raw.accounts