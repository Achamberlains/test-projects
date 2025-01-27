{{ config(
    database = 'analyze',
    schema = 'campaign',
    alias = 'dim_campaigns',
    materialized='table'
) }}

    SELECT
        -- Primary key
        ad_spend.campaign_key,

        -- IDs
        ad_spend.campaign_id,

        -- Attributes
        campaigns.campaign_name,
        campaigns.campaign_channel
    FROM {{ref('normalize_ad_spend')}} ad_spend
    LEFT JOIN {{ref('normalize_campaigns')}} campaigns
        ON ad_spend.campaign_id = campaigns.campaign_id