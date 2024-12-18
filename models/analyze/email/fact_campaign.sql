{{ config(
    database = 'analyze',
    schema = 'email',
    alias = 'fact_campaigns'
) }}

WITH

ad_spend AS (
    SELECT
        campaign_key,
        campaign_id,
        campaign_ad_spend,
        campaign_date
    FROM 
        {{ref('normalize_ad_spend')}}
),

conversion AS (
    SELECT
        campaign_key,
        campaign_id,
        campaign_conversion,
        campaign_date
        FROM
            {{ref('normalize_conversions')}}
),

final AS(
    SELECT
        ad_spend.campaign_key,
        campaigns.campaign_id,
        ad_spend.campaign_ad_spend,
        conversion.campaign_conversion,
        conversion.campaign_date
    FROM ad_spend
    LEFT JOIN {{ref('normalize_campaigns')}} campaigns
        ON ad_spend.campaign_id = campaigns.campaign_id
    LEFT JOIN conversion
        ON ad_spend.campaign_key = conversion.campaign_key
        --AND ad_spend.campaign_id = conversion.campaign_id
        --AND ad_spend.campaign_date = conversion.campaign_date
)

SELECT * FROM final
