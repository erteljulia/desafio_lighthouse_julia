with 
    stg_sales_creditcard as (
        select
            distinct creditcardid
            , cardtype
        from {{ ref('stg_sales_creditcard') }}
    )
    , transformed as (
        select 
            {{ dbt_utils.generate_surrogate_key(['creditcardid', 'cardtype']) }} as creditcard_sk
            , creditcardid
            , cardtype
        from stg_sales_creditcard
    )
select *
from transformed
