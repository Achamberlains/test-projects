{{ config(
    database ='clean',
    schema ='clean_impro',
    alias ='clean_ad_spend',
    materialized='table'
) }}

WITH  
clean_ad_spend AS (
    SELECT
        campaign_id,
        date,
        spend
    FROM 
        {{ref('stg_ad_spend')}}
)

SELECT * FROM clean_ad_spend