{{ config(
    database = 'analyze',
    schema = 'email',
    alias = 'dim_campaigns',
    materialized='table'
) }}

WITH  

ad_spend AS (
    SELECT
        campaign_key,
        campaign_id,
        campaign_date
    FROM 
        {{ref('normalize_ad_spend')}}
),

campaigns AS (
    SELECT
        campaign_id,
        campaign_name,
        campaign_channel
    FROM
        {{ref('normalize_campaigns')}}
),

final AS(
    SELECT
        ad_spend.campaign_key,
        ad_spend.campaign_id,
        campaigns.campaign_name,
        campaigns.campaign_channel,
        ad_spend.campaign_date
    FROM ad_spend
    LEFT JOIN campaigns
        ON ad_spend.campaign_id = campaigns.campaign_id
)

SELECT * FROM final
