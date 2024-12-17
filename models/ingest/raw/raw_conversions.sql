{{ config(
    database ='ingest',
    schema ='raw_impro',
    alias ='raw_conversions',
    materialized='table'
) }}

WITH  
raw_conversions AS (
    SELECT
        campaign_id,
        date,
        conversions
        FROM
            {{ generate_database_name('ingest') }}.raw_impro.raw_conversions
)

SELECT * FROM raw_conversions