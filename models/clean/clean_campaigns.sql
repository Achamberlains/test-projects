{{ config(
    database ='clean',
    schema ='clean_impro',
    alias ='clean_campaigns',
    materialized='table'
) }}

WITH  
clean_campaigns AS (
    SELECT
        campaign_id,
        campaign_name,
        channel
    FROM
        {{ref('stg_campaigns')}}
)

SELECT * FROM clean_campaigns