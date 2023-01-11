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
    from {{ source('bigquery', 'listings') }}
)

select *
from source_data

