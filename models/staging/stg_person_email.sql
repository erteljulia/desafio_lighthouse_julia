with 
    stg_person_email as (
        select
            businessentityid
            , emailaddressid
            , cast(emailaddress.emailaddress as string) as email
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'emailaddress') }}
    )
select *
from stg_person_email
