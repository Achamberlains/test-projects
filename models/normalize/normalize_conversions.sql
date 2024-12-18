{{ config(
    database ='normalize',
    schema ='normalize_impro',
    alias ='normalize_conversions',
    materialized='table'
) }}

WITH  
normalize_conversions AS (
    SELECT
        -- IDs
        campaign_id,

        -- Attributes
        conversions AS campaign_conversion,
        date AS campaign_date
        FROM
            {{ref('clean_conversions')}}
)

SELECT * FROM normalize_conversions