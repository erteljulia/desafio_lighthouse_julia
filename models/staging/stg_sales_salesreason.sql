with 
    stg_sales_salesreason as (
        select
            salesreasonid
            , name as reason_name
            , reasontype
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'salesreason') }}
    )
select *
from stg_sales_salesreason
