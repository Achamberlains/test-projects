{{ config(
    database ='normalize',
    schema ='normalize_impro',
    alias ='normalize_ad_spend',
    materialized='table'
) }}

WITH  
normalize_ad_spend AS (
    SELECT
        -- Primary key
        {{ dbt_utils.generate_surrogate_key(['campaign_id', 'date', 'spend']) }} AS ad_spend_key,

        -- Secondary key
        {{ dbt_utils.generate_surrogate_key(['campaign_id', 'date']) }} AS campaign_key,

        -- IDs
        campaign_id,

        -- Attributes
        spend AS campaign_ad_spend,
        date AS campaign_ad_spend_date
    FROM 
        {{ref('clean_ad_spend')}}
)

SELECT * FROM normalize_ad_spend