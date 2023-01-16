WITH listings_flags AS (
    SELECT
        id                                       AS listing_id,
        neighbourhood                            AS bairro,
        IF(room_type = "Entire home/apt" ,1 , 0) AS FLG_ENTIRE_HOME,
        IF(room_type = "Private room"    ,1 , 0) AS FLG_PRIVATE_ROOM,
        IF(room_type = "Hotel room"      ,1 , 0) AS FLG_HOTEL_ROOM,
        IF(room_type = "Shared room"     ,1 , 0) AS FLG_SHARED_ROOM
    FROM
        {{ ref('staging_listings') }}
    WHERE
        neighbourhood is not null AND
        room_type is not null
)
SELECT
    f.bairro,
    DATE_TRUNC(dt_notific, YEAR)  AS ano,
    DATE_TRUNC(dt_notific, MONTH) AS mes,
    COUNT(*)                      AS qtde_reviews,
    SUM(f.FLG_ENTIRE_HOME)        AS qtde_entire_home,
    SUM(f.FLG_PRIVATE_ROOM)       AS qtde_private_room,
    SUM(f.FLG_HOTEL_ROOM)         AS qtde_hotel_room,
    SUM(f.FLG_SHARED_ROOM)        AS qtde_shared_room
FROM
    listings_flags AS f
INNER JOIN
    {{ ref('staging_reviews') }} AS r 
        ON r.listing_id = f.listing_id AND r.date >= "2020-01-01"
GROUP BY
    f.bairro, ano, mes
ORDER BY
    mes;
