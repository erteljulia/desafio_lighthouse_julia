with
    validation as (
        select count(distinct salesorderid) as count_val
        from {{ref('fact_ordersaggregate')}}
    )
select * from validation
where count_val != 31465
