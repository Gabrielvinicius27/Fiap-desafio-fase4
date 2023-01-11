{{ config(materialized='table') }}

with source_data as (

    select
    SAFE.PARSE_DATE('%Y-%m-%d', date) AS date,
    listing_id
    from {{ source('bigquery', 'reviews') }}
)

select *
from source_data

