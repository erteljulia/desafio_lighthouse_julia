with 
    stg_person_adress as (
        select
            addressid
            , stateprovinceid
            , city
            , addressline1	
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'address') }}
    )
select *
from stg_person_adress
