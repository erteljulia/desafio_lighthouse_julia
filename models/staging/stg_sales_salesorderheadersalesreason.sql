with 
    stg_sales_salesorderheadersalesreason as (
        select
            salesorderid
            , salesreasonid
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'salesorderheadersalesreason') }}
    )
select *
from stg_sales_salesorderheadersalesreason
