{{ config(
    database ='ingest',
    schema ='stg_impro',
    alias ='stg_campaigns',
    materialized='table'
) }}

WITH  
stg_campaigns AS (
    SELECT
        CAST(campaign_id AS INT) AS campaign_id,
        CAST(campaign_name AS VARCHAR) AS campaign_name,
        CAST(channel AS VARCHAR) AS channel
    FROM
        {{ ref('campaign_raw') }}
)

SELECT * FROM stg_campaigns