with 
    stg_sales_orderheader as (
        select
            salesorderid
            , status as order_status
            , purchaseordernumber
            , customerid
            , salespersonid
            , territoryid
            , billtoaddressid
            , shiptoaddressid
            , creditcardid
            , subtotal
            , taxamt
            , freight
            , totaldue
            , shipmethodid
            , cast(orderdate as timestamp) as order_date
            , cast(duedate as timestamp) as due_date
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'salesorderheader') }}
    )
select *
from stg_sales_orderheader
