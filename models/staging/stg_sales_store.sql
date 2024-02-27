with 
    stg_sales_store as (
        select
            businessentityid
            , name as name_store
            , salespersonid
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'store') }}
    )
select *
from stg_sales_store