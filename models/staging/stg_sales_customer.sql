with 
    stg_sales_customer as (
        select
            customerid
            , personid
            , storeid
            , territoryid
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'customer') }}
    )
select *
from stg_sales_customer
