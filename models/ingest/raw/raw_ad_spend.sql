{{ config(
    database ='ingest',
    schema ='raw_impro',
    alias ='raw_ad_spend',
    materialized='table'
) }}

WITH  
raw_ad_spend AS (
    SELECT
        campaign_id,
        date,
        spend
    FROM 
        {{ generate_database_name('ingest') }}.raw_impro.raw_ad_spend

)

SELECT * FROM raw_ad_spend