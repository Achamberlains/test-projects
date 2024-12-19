{{ config(
    database ='clean',
    schema ='clean_impro',
    alias ='clean_conversions',
    materialized='table'
) }}

WITH  
clean_conversions AS (
    SELECT
        -- IDs
        campaign_id,

        -- Field
        conversions,

        -- Date
        date
    FROM
            {{ref('stg_conversions')}}
)

SELECT * FROM clean_conversions