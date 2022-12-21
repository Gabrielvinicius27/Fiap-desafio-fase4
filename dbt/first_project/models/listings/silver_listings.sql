
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select distinct 
    id,
    name,
    price,
    host_id,
    license,
    latitude,
    host_name,
    longitude,
    room_type,
    last_review,
    REGEXP_REPLACE(NORMALIZE(UPPER(neighbourhood), NFD), r'\pM', '') AS neighbourhood,
    minimum_nights,
    availability_365,
    number_of_reviews,
    reviews_per_month,
    neighbourhood_group,
    number_of_reviews_ltm,
    calculated_host_listings_count
    from `onyx-course-371018.dataset.listings`
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null

