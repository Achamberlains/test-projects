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
        INITCAP(campaign_name) AS campaign_name,
        INITCAP(channel) AS channel
    FROM
        {{ref('stg_campaigns')}}
)

SELECT * FROM clean_campaigns