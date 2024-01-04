{{ config(
    materialized='incremental', 
    tags=['DIM'], 
    unique_key='product_id'
) }}

SELECT
    product_id,
    product_name,
    imgUrl,
    productURL,
    price,
    listPrice,
    category_id
FROM {{ ref('rfnd_amazon_products') }}
