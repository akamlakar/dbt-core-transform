{{ config(
    materialized='incremental',
    unique_key='product_id'
) }}

{% set target_relation = get_target_relation() %}

WITH max_date AS (
    -- if target table doesn't exist, use default date
    {% if target_relation %}
        SELECT COALESCE(MAX(etl_load_date), '1900-01-01'::DATE) as etl_max_load_date
        FROM {{ this }}
    {% else %}
        SELECT '1900-01-01'::DATE as etl_max_load_date
    {% endif %}
)
, base AS (
    SELECT 
        asin AS product_id,
        INITCAP(title) AS product_name,
        imgurl,
        producturl,
        stars,
        COALESCE(reviews, 0) AS review_count,
        CASE 
            WHEN price < 0 THEN 0
            ELSE price
        END AS price,
        listprice,
        COALESCE(category_id, 0) AS category_id,
        isbestseller,
        boughtinlastmonth,
        load_date AS etl_load_date
    FROM {{ source('raw', 'amazon_products') }}
)

SELECT 
    product_id,
    product_name,
    imgurl,
    producturl,
    stars,
    review_count,
    price,
    listprice,
    category_id,
    isbestseller,
    boughtinlastmonth,
    etl_load_date
FROM base
{% if is_incremental() %}
    CROSS JOIN max_date
    WHERE base.etl_load_date > max_date.etl_max_load_date
    OR max_date.etl_max_load_date = '1900-01-01'::DATE
{% endif %}
