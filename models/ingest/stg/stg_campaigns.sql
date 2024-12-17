{{ config(
    database ='ingest',
    schema ='stg_impro',
    alias ='stg_campaigns',
    materialized='table'
) }}

WITH  
stg_campaigns AS (
    SELECT
        campaign_id,
        campaign_name,
        channel
    FROM 
        {{ ref('raw_campaigns') }}
)

SELECT * FROM stg_campaigns