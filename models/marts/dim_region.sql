with 
    stg_person_stateprovince as (
        select *
        from {{ref('stg_person_stateprovince')}}
    )
    , stg_person_countryregion as (
        select *
        from {{ref('stg_person_countryregion')}}
    )
    , stg_sales_salesterritory as (
        select *
        from {{ref('stg_sales_salesterritory')}}
    )
    , transformed as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'stg_person_stateprovince.stateprovinceid'
                , 'stg_person_countryregion.countryregioncode'
                , 'stg_sales_salesterritory.territoryid']) }} as address_sk 
            , stg_person_stateprovince.stateprovinceid    
            , stg_person_countryregion.countryregioncode
            , stg_sales_salesterritory.territoryid
            , stg_sales_salesterritory.territory_name
            , stg_person_stateprovince.name_state
            , stg_person_countryregion.country_name
        from stg_person_stateprovince
        left join stg_sales_salesterritory on stg_sales_salesterritory.territoryid = stg_person_stateprovince.territoryid
        left join stg_person_countryregion on stg_person_stateprovince.countryregioncode = stg_person_countryregion.countryregioncode
    )
select *
from transformed
