with 
    dim_creditcard as (
        select *        
        from {{ref('dim_creditcard')}}
    )
    , dim_customer as (
        select *            
        from {{ref('dim_customer')}}
    )
    , dim_region as (
        select *
        from {{ref('dim_region')}}
    )
    , dim_reason as (
        select *
        from {{ref('dim_reason')}}
    )
    , dim_product as (
        select *
        from {{ref('dim_product')}}
    )
    , dim_salesperson as (
        select *
        from {{ref('dim_salesperson')}}
    )
    , stg_sales_salesorderdetail as (
        select 
            dim_product.product_sk as product_fk
            , stg_sales_salesorderdetail.salesorderid
            , stg_sales_salesorderdetail.salesorderdetailid
            , stg_sales_salesorderdetail.productid
            , stg_sales_salesorderdetail.orderqty
            , stg_sales_salesorderdetail.unitprice
            , stg_sales_salesorderdetail.unitpricediscount
        from {{ref('stg_sales_salesorderdetail')}}
        left join dim_product on stg_sales_salesorderdetail.productid = dim_product.productid
    )
    , stg_sales_salesorderheader as (
        select
            dim_customer.customer_sk as customer_fk
            , dim_creditcard.creditcard_sk as creditcard_fk
            , dim_salesperson.salesperson_sk as salesperson_fk
            , dim_region.address_sk as address_fk
            , stg_sales_salesorderheader.salesorderid
            , dim_region.territoryid
            , dim_salesperson.businessentityid
            , dim_reason.reason_name_aggregated
            , stg_sales_salesorderheader.order_status
            , stg_sales_salesorderheader.billtoaddressid
            , stg_sales_salesorderheader.shiptoaddressid
            , stg_sales_salesorderheader.subtotal
            , stg_sales_salesorderheader.taxamt
            , stg_sales_salesorderheader.freight
            , stg_sales_salesorderheader.totaldue
            , stg_sales_salesorderheader.order_date
            , stg_sales_salesorderheader.due_date    
        from {{ref('stg_sales_salesorderheader')}}
        left join dim_salesperson on stg_sales_salesorderheader.salespersonid = dim_salesperson.businessentityid
        left join dim_customer on stg_sales_salesorderheader.customerid = dim_customer.customerid
        left join dim_creditcard on stg_sales_salesorderheader.creditcardid = dim_creditcard.creditcardid
        left join dim_region on stg_sales_salesorderheader.territoryid = dim_region.territoryid
        left join dim_reason on stg_sales_salesorderheader.salesorderid = dim_reason.salesorderid
    )
    , 
    final as (
        select 
            stg_sales_salesorderdetail.product_fk
            , stg_sales_salesorderheader.customer_fk
            , stg_sales_salesorderheader.creditcard_fk
            , stg_sales_salesorderheader.salesperson_fk
            , stg_sales_salesorderheader.address_fk
            , stg_sales_salesorderheader.salesorderid
            , stg_sales_salesorderdetail.salesorderdetailid 
            , stg_sales_salesorderdetail.productid
            , stg_sales_salesorderdetail.orderqty
            , stg_sales_salesorderdetail.unitprice         
            , stg_sales_salesorderdetail.unitpricediscount
            , stg_sales_salesorderheader.order_status
            , stg_sales_salesorderheader.territoryid
            , stg_sales_salesorderheader.billtoaddressid
            , stg_sales_salesorderheader.shiptoaddressid
            , stg_sales_salesorderheader.taxamt
            , stg_sales_salesorderheader.freight
            , stg_sales_salesorderheader.totaldue  
            , stg_sales_salesorderheader.order_date
            , stg_sales_salesorderheader.due_date
    from stg_sales_salesorderheader
    left join stg_sales_salesorderdetail on stg_sales_salesorderheader.salesorderid = stg_sales_salesorderdetail.salesorderid
    )
select *
from final
