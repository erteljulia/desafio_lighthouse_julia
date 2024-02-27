with 
    stg_sales_creditcard as (
        select
            creditcardid
            , cardtype
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'creditcard') }}
    )
select *
from stg_sales_creditcard
