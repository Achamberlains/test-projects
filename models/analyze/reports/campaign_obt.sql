{{ config(
    database = 'analyze',
    schema = 'reports',
    alias = 'campaign_obt'
) }}

WITH

dim_campaign AS (
    SELECT
        campaign_id,
        ad_spend_key,
        campaign_key,
        conversion_key,
        campaign_name,
        campaign_channel,
        conversion_date,
        campaign_ad_spend_date
    FROM
        {{ ref('dim_campaign') }}
),

fact_campaign AS (
    SELECT
        campaign_id,
        ad_spend_key,
        campaign_key,
        conversion_key,
        campaign_ad_spend,
        campaign_conversion
    FROM
        {{ ref('fact_campaign') }}
),

final AS (
    SELECT
        dim_campaign.campaign_id,
        dim_campaign.ad_spend_key,
        dim_campaign.campaign_key,
        dim_campaign.conversion_key,
        dim_campaign.campaign_name,
        dim_campaign.campaign_channel,
        fact_campaign.campaign_ad_spend,
        fact_campaign.campaign_conversion,
        dim_campaign.conversion_date,
        dim_campaign.campaign_ad_spend_date
    FROM dim_campaign
    JOIN fact_campaign
        ON dim_campaign.campaign_id = fact_campaign.campaign_id
        AND dim_campaign.ad_spend_key = fact_campaign.ad_spend_key
        AND dim_campaign.campaign_key = fact_campaign.campaign_key
        AND dim_campaign.conversion_key = fact_campaign.conversion_key
)

SELECT * FROM final