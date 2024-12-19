{{ config(
    database = 'analyze',
    schema = 'campaign',
    alias = 'fact_campaigns'
) }}

    SELECT
        -- Primary key
        ad_spend.campaign_key,

        -- IDs
        campaigns.campaign_id,

        -- Attributes
        ad_spend.campaign_ad_spend,
        conversion.campaign_conversion,
        conversion.campaign_date
    FROM {{ref('normalize_ad_spend')}} ad_spend
    LEFT JOIN {{ref('normalize_campaigns')}} campaigns
        ON ad_spend.campaign_id = campaigns.campaign_id
    LEFT JOIN {{ref('normalize_conversions')}} conversion
        ON ad_spend.campaign_key = conversion.campaign_key
        --AND ad_spend.campaign_id = conversion.campaign_id
        --AND ad_spend.campaign_date = conversion.campaign_date