{{ config(
    database ='clean',
    schema ='clean_impro',
    alias ='clean_ad_spend',
    materialized='table'
) }}

WITH  
clean_ad_spend AS (
    SELECT
        -- IDs
        campaign_id,

        -- Field
        spend,
        
        -- Date
        date
    FROM 
        {{ref('stg_ad_spend')}}
)

SELECT * FROM clean_ad_spend