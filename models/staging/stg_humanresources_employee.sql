with 
    stg_humanresources_employee as (
        select
            businessentityid
            , loginid
            , jobtitle
            , cast(modifieddate as timestamp) as modified_date
        from {{ source('dbt', 'employee') }}
    )
select *
from stg_humanresources_employee
