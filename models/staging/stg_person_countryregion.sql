with 
    stg_person_countryregion as (
        select
            countryregioncode
            , name as country_name
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'countryregion') }}
    )
select *
from stg_person_countryregion