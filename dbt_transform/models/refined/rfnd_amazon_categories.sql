{{ config(
    materialized='incremental',
    unique_key='category_id'
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
        id AS category_id,
        INITCAP(TRIM(category_name)) AS category_name,
        load_date AS etl_load_date
    FROM {{ source('raw', 'amazon_categories') }}
)

SELECT 
    category_id,
    category_name,
    etl_load_date
FROM base
{% if is_incremental() %}
    CROSS JOIN max_date
    WHERE base.etl_load_date > max_date.etl_max_load_date
    OR max_date.etl_max_load_date = '1900-01-01'::DATE
{% endif %}
