WITH silver_listings_flags AS (
    SELECT 
        *,
        CASE WHEN room_type = "Entire home/apt" THEN 1 ELSE 0 END AS FLG_ENTIRE_HOME,
        CASE WHEN room_type = "Private room" THEN 1 ELSE 0 END AS FLG_PRIVATE_ROOM,
        CASE WHEN room_type = "Hotel room" THEN 1 ELSE 0 END AS FLG_HOTEL_ROOM,
        CASE WHEN room_type = "Shared room" THEN 1 ELSE 0 END AS FLG_SHARED_ROOM,
    FROM
        {{ ref('staging_listings') }}   
)
SELECT
    neighbourhood AS bairro,
    DATE_TRUNC(date, MONTH) AS mes,
    COUNT(*) as qtde_reviews,
    SUM(FLG_ENTIRE_HOME) as qtde_entire_home,
    SUM(FLG_PRIVATE_ROOM) as qtde_private_room,
    SUM(FLG_HOTEL_ROOM) as qtde_hotel_room,
    SUM(FLG_SHARED_ROOM) as qtde_shared_room,
FROM
    silver_listings_flags
INNER JOIN
    {{ ref('staging_reviews') }}
ON
    listing_id = id
GROUP BY
    1,
    2
ORDER BY
    2