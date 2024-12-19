{{ config(
    database = 'analyze',
    schema = 'reports',
    alias = 'campaign_obt'
) }}

WITH

dim_campaign AS (
    SELECT
        campaign_key,
        campaign_id,
        campaign_name,
        campaign_channel
    FROM
        {{ ref('dim_campaign') }}
),

fact_campaign AS (
    SELECT
        campaign_key,
        campaign_id,
        campaign_ad_spend,
        campaign_conversion,
        campaign_date
    FROM
        {{ ref('fact_campaign') }}
),

final AS (
    SELECT
        dim_campaign.campaign_key,
        dim_campaign.campaign_id,
        dim_campaign.campaign_name,
        dim_campaign.campaign_channel,
        fact_campaign.campaign_ad_spend,
        fact_campaign.campaign_conversion,
        ROUND((fact_campaign.campaign_conversion * 100), 2) AS campaign_revenue,
        ROUND((fact_campaign.campaign_conversion/fact_campaign.campaign_ad_spend), 2) AS conversion_rate,
        ROUND(((fact_campaign.campaign_conversion * 100)/fact_campaign.campaign_ad_spend), 2) AS ROAS,
        fact_campaign.campaign_date
    FROM dim_campaign
    LEFT JOIN fact_campaign
        ON dim_campaign.campaign_key = fact_campaign.campaign_key
    QUALIFY ROW_NUMBER() OVER(PARTITION BY dim_campaign.campaign_id, fact_campaign.campaign_date ORDER BY fact_campaign.campaign_date) = 1
)

SELECT * FROM final