with 
    stg_sales_salesterritory as (
        select
            territoryid
            , name as territory_name
            , countryregioncode
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'salesterritory') }}
    )
select *
from stg_sales_salesterritory
