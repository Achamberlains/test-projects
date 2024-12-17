{{ config(
    database ='ingest',
    schema ='raw_impro',
    alias ='raw_campaigns',
    materialized='table'
) }}

WITH  
raw_campaigns AS (
    SELECT
        campaign_id,
        campaign_name,
        channel
    FROM
        {{ generate_database_name('ingest') }}.raw_impro.raw_campaigns
)

SELECT * FROM raw_campaigns