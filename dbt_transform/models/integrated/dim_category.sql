{{ config(
    materialized='incremental',
    tags=['DIM'],
    unique_key='category_id'
) }}

SELECT
    category_id,
    category_name
FROM {{ ref('rfnd_amazon_categories') }}