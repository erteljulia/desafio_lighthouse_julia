with 
    stg_sales_salesperson as (
        select
            businessentityid
            , territoryid
            , salesquota
            , bonus
            , commissionpct
            , salesytd
            , saleslastyear
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'salesperson') }}
    )
select *
from stg_sales_salesperson
