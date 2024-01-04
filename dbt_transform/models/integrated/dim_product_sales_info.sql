{{ config(
    materialized='incremental', 
    tags=['DIM'], 
    unique_key='product_id'
) }}

SELECT
    product_id,
    isBestSeller,
    boughtInLastMonth
FROM {{ ref('rfnd_amazon_products') }}
