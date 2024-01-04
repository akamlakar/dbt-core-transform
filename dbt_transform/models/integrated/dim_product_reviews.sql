{{ config(
    materialized='incremental', 
    tags=['DIM'], 
    unique_key='product_id'
) }}

SELECT
    product_id,
    stars,
    review_count
FROM {{ ref('rfnd_amazon_products') }}
