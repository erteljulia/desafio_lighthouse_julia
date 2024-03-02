with 
    stg_production_product as (
        select
            productid
            , name as name_product
            , productnumber
            , standardcost
            , listprice
            , productsubcategoryid
            , productmodelid
            , productline
            , style
            , cast(sellstartdate as timestamp) as sell_start_date
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'product') }}
    )
select *
from stg_production_product
