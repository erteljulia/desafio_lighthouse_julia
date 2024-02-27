with 
    stg_production_product as (
        select
            name_product
            , productid
            , standardcost
            , listprice
            , productsubcategoryid
            , productmodelid
            , productline
            , style
        from {{ ref('stg_production_product') }}
    )
    , transformed as (
            select 
            {{ dbt_utils.generate_surrogate_key(['productid', 'name_product']) }} as product_sk
            , stg_production_product.productid
            , stg_production_product.name_product
            , stg_production_product.standardcost
            , stg_production_product.listprice
            , stg_production_product.productline
            , stg_production_product.style
            from stg_production_product
    )
select *
from transformed
