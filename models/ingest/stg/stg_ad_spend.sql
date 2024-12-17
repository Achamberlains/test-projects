{{ config(
    database ='ingest',
    schema ='stg_impro',
    alias ='stg_ad_spend',
    materialized='table'
) }}

WITH  
stg_ad_spend AS (
    SELECT
        campaign_id,
        date,
        spend
    FROM 
        {{ ref('raw_ad_spend') }}
)

SELECT * FROM stg_ad_spend