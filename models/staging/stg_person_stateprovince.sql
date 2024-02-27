with 
    stg_person_stateprovince as (
        select
            stateprovinceid
            , countryregioncode
            , name as name_state
            , territoryid
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'stateprovince') }}
    )
select *
from stg_person_stateprovince
