with
    dim_region as (
        select 
            *
        from {{ref('dim_region')}}
    )
    , dim_salesperson as (
        select 
            *
        from {{ref('dim_salesperson')}}
    )
    , ordersaggregate as (
        select 
            stg_sales_salesorderheader.order_date
            , dim_salesperson.businessentityid
            , dim_region.territoryid
            , stg_sales_salesorderheader.salesorderid
            , stg_sales_salesorderheader.salespersonid
            , stg_sales_salesorderheader.totaldue
        from {{ref('stg_sales_salesorderheader')}}
        left join dim_salesperson on dim_salesperson.businessentityid = stg_sales_salesorderheader.salespersonid
        left join dim_region on dim_region.territoryid = stg_sales_salesorderheader.territoryid
        group by
            stg_sales_salesorderheader.salesorderid
            , stg_sales_salesorderheader.order_date
            , dim_salesperson.businessentityid
            , dim_region.territoryid
            , stg_sales_salesorderheader.salespersonid
            , stg_sales_salesorderheader.totaldue
    )
select * 
from ordersaggregate
