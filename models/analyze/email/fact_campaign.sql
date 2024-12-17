{{ config(
    database = 'analyze',
    schema = 'email',
    alias = 'fact_campaigns'
) }}

WITH  

ad_spend AS (
    SELECT
        campaign_id,
        ad_spend_key,
        campaign_key,
        campaign_ad_spend
    FROM 
        {{ref('normalize_ad_spend')}}
),

conversion AS (
    SELECT
        campaign_id,
        conversion_key,
        campaign_key,
        campaign_conversion
        FROM
            {{ref('normalize_conversions')}}
),

final AS(
    SELECT
        campaigns.campaign_id,
        ad_spend.ad_spend_key,
        ad_spend.campaign_key,
        conversion.conversion_key,
        ad_spend.campaign_ad_spend,
        conversion.campaign_conversion
    FROM
        {{ref('normalize_campaigns')}} campaigns
    LEFT JOIN ad_spend
        ON ad_spend.campaign_id = campaigns.campaign_id
    LEFT JOIN conversion
        ON ad_spend.campaign_key = conversion.campaign_key
        AND ad_spend.campaign_id = conversion.campaign_id
)

SELECT * FROM final
