with 
    stg_humanresources_employee as (
        select
            businessentityid
            , loginid
            , jobtitle
        from {{ ref('stg_humanresources_employee') }}
    )
    , stg_person_person as (
        select
            businessentityid
            , full_name
            , persontype
        from {{ ref('stg_person_person') }}
    )
    , stg_sales_salesperson as (
        select
            businessentityid
            , territoryid
            , salesquota
            , bonus
            , commissionpct
        from {{ ref('stg_sales_salesperson') }}
    )
    , combined_staging as (
        select
            {{ dbt_utils.generate_surrogate_key(['territoryid', 'persontype', 'stg_sales_salesperson.businessentityid']) }} as salesperson_sk
            , stg_sales_salesperson.businessentityid
            , stg_humanresources_employee.jobtitle
            , stg_person_person.full_name
            , stg_person_person.persontype
            , stg_sales_salesperson.territoryid
            , stg_sales_salesperson.salesquota
            , stg_sales_salesperson.bonus
            , stg_sales_salesperson.commissionpct
        from stg_humanresources_employee
        left join stg_sales_salesperson on stg_humanresources_employee.businessentityid = stg_sales_salesperson.businessentityid
        left join stg_person_person on stg_humanresources_employee.businessentityid = stg_person_person.businessentityid
        where stg_person_person.persontype = "SP"
    )
select *
from combined_staging
