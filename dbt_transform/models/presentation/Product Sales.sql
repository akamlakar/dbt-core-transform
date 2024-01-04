{{ config(
    materialized='table'
) }}

SELECT
    product_id,
    category_id,
    total_reviews,
    avg_rating,
    total_bought_last_month,
    revenue
FROM {{ ref('fact_sales') }}
