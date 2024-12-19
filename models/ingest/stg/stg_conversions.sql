{{ config(
    database ='ingest',
    schema ='stg_impro',
    alias ='stg_conversions',
    materialized='table'
) }}

WITH  
stg_conversions AS (
    SELECT
        campaign_id,
        date,
        conversions
    FROM
        {{ ref('raw_conversions') }}
)

SELECT * FROM stg_conversions