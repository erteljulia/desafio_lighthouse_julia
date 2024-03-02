with 
    stg_sales_orderdetail as (
        select
            salesorderid
            , specialofferid
            , salesorderdetailid
            , productid
            , orderqty
            , unitprice
            , unitpricediscount
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'salesorderdetail') }}
    )
select *
from stg_sales_orderdetail
