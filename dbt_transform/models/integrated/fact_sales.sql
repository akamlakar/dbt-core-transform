{{ config(
    materialized='incremental',
    tags=['FACT'],
    unique_key='product_id'
) }}

SELECT
    product_id,
    category_id,
    COALESCE(review_count, 0) AS total_reviews,
    COALESCE(stars, 0) AS avg_rating,
    COALESCE(boughtinlastmonth, 0) AS total_bought_last_month,
    COALESCE(boughtinlastmonth, 0) * COALESCE(price, 0) AS revenue
FROM {{ ref('rfnd_amazon_products') }}
