{{ config(
    database ='normalize',
    schema ='normalize_impro',
    alias ='normalize_conversions',
    materialized='table'
) }}

WITH  
normalize_conversions AS (
    SELECT
        -- Primary key
        {{ dbt_utils.generate_surrogate_key(['campaign_id', 'date', 'conversions']) }} AS conversion_key,

        -- Secondary key
        {{ dbt_utils.generate_surrogate_key(['campaign_id', 'date']) }} AS campaign_key,

        -- IDs
        campaign_id,

        -- Attributes
        conversions AS campaign_conversion,
        date AS conversion_date
        FROM
            {{ref('clean_conversions')}}
)

SELECT * FROM normalize_conversions