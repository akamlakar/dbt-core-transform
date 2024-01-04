{{ config(
    materialized='table'
) }}

WITH base AS (
    SELECT 
        product_id,
        product_name,
        imgUrl AS product_image_url,
        productURL AS product_link,
        price,
        listPrice AS list_price
    FROM {{ ref('dim_product_base') }}
),

reviews AS (
    SELECT
        pr.product_id,
        pr.stars AS average_rating,
        sl.star_label AS rating_description,  
        pr.review_count
    FROM {{ ref('dim_product_reviews') }} pr
    LEFT JOIN {{ ref('stars_lookup') }} sl
        ON pr.stars = sl.star_value  

),

sales_info AS (
    SELECT
        product_id,
        CASE 
            WHEN isBestSeller THEN 'Yes'
            ELSE 'No'
        END AS is_best_seller,
        boughtInLastMonth AS purchases_last_month
    FROM {{ ref('dim_product_sales_info') }}
)

SELECT
    b.product_id,
    b.product_name,
    b.product_image_url,
    b.product_link,
    r.average_rating,
    r.rating_description,  
    r.review_count,
    b.price,
    b.list_price,
    s.is_best_seller,
    s.purchases_last_month
FROM base b
JOIN reviews r
    ON b.product_id = r.product_id
JOIN sales_info s
    ON b.product_id = s.product_id
