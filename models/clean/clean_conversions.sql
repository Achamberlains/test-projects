{{ config(
    database ='clean',
    schema ='clean_impro',
    alias ='clean_conversions',
    materialized='table'
) }}

WITH  
clean_conversions AS (
    SELECT
        campaign_id,
        date,
        conversions
        FROM
            {{ref('stg_conversions')}}
)

SELECT * FROM clean_conversions