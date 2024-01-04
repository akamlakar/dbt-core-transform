{{ config(
    materialized='table'
) }}

SELECT
    category_id AS category_id,
    category_name AS category
FROM {{ ref('dim_category') }}