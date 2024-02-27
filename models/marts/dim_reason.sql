with 
    stg_sales_salesorderheadersalesreason as (
        select *
        from {{ref('stg_sales_salesorderheadersalesreason')}}
    )
    , stg_sales_salesreason as (
        select *
        from {{ref('stg_sales_salesreason')}}
    )
    , reasonbyorderid as (
        select 
            row_number() over (order by stg_sales_salesorderheadersalesreason.salesorderid) as reason_sk
            , stg_sales_salesorderheadersalesreason.salesorderid
            , string_agg(stg_sales_salesreason.reason_name, ', ') as reason_name_aggregated
            , string_agg(cast(stg_sales_salesorderheadersalesreason.salesreasonid as string), ', ') as reason_id_aggregate
        from stg_sales_salesorderheadersalesreason
        left join stg_sales_salesreason on stg_sales_salesorderheadersalesreason.salesreasonid = stg_sales_salesreason.salesreasonid
        group by 
            stg_sales_salesorderheadersalesreason.salesorderid
    )
select *
from reasonbyorderid
