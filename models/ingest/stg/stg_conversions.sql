{{ config(
    database ='ingest',
    schema ='stg_impro',
    alias ='stg_conversions',
    materialized='table'
) }}

WITH  
stg_conversions AS (
    SELECT
        CAST(campaign_id AS INT) AS campaign_id,
        CAST(date AS DATE) AS date,
        CAST(conversions AS INT) AS conversions
    FROM
        {{ ref('raw_conversions') }}
)

SELECT * FROM stg_conversions