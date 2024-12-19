{{ config(
    database ='normalize',
    schema ='normalize_impro',
    alias ='normalize_campaigns',
    materialized='table'
) }}

WITH  
normalize_campaigns AS (
    SELECT
        -- IDs
        campaign_id,

        --Attributes
        campaign_name,
        channel AS campaign_channel
    FROM
        {{ref('clean_campaigns')}}
)

SELECT * FROM normalize_campaigns