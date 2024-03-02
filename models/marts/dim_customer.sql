with 
    stg_sales_store as (
        select
            *
        from {{ ref('stg_sales_store') }}
    )
    , stg_sales_customer as (
        select
            *
        from {{ ref('stg_sales_customer') }}
    )
    , stg_person_person as (
        select
            *
        from {{ ref('stg_person_person') }}
    )
    , stg_person_email as (
        select
            *
        from {{ ref('stg_person_email') }}
    )
    , combined_staging as (
        select
            {{ dbt_utils.generate_surrogate_key(['customerid', 'storeid', 'personid']) }} as customer_sk
            , stg_sales_customer.customerid
            , stg_sales_customer.storeid
            , stg_sales_store.businessentityid
            , stg_sales_customer.personid
            , stg_sales_customer.territoryid
            , stg_sales_store.name_store
            , stg_person_person.full_name
            , stg_person_email.email
            , stg_person_person.persontype
            , stg_person_person.emailpromotion
        from stg_sales_customer
        left join stg_sales_store on stg_sales_customer.storeid = stg_sales_store.businessentityid
        left join stg_person_person on stg_sales_customer.personid = stg_person_person.businessentityid
        left join stg_person_email on stg_person_person.businessentityid = stg_person_email.businessentityid
    )
select *
from combined_staging
