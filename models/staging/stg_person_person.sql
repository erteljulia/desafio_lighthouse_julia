with 
    stg_person_person as (
        select
            businessentityid
            , concat(firstname, ' ', middlename, ' ', lastname) as full_name 
            , persontype
            , cast(modifieddate as timestamp) as modified_date
            , emailpromotion
        from {{ source('dbt', 'person') }}
    )
select *
from stg_person_person