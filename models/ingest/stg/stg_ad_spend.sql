{{ config(
    database ='ingest',
    schema ='stg_impro',
    alias ='stg_ad_spend',
    materialized='table',
) }}

WITH  
stg_ad_spend AS (
    SELECT
        CAST(campaign_id AS INT) AS campaign_id,
        CAST(date AS DATE) AS date,
        CAST(spend AS DECIMAL(10, 2)) AS spend
    FROM
        {{ ref('raw_ad_spend') }}
)

SELECT * FROM stg_ad_spend