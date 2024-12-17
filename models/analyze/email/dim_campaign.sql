{{ config(
    database = 'analyze',
    schema = 'email',
    alias = 'dim_campaigns'
) }}

WITH  

ad_spend AS (
    SELECT
        campaign_id,
        ad_spend_key,
        campaign_key,
        campaign_ad_spend_date
    FROM 
        {{ref('normalize_ad_spend')}}
),

conversion AS (
    SELECT
        campaign_id,
        conversion_key,
        campaign_key,
        conversion_date
        FROM
            {{ref('normalize_conversions')}}
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
        ad_spend.campaign_id,
        ad_spend.ad_spend_key,
        ad_spend.campaign_key,
        conversion.conversion_key,
        campaigns.campaign_name,
        campaigns.campaign_channel,
        conversion.conversion_date,
        ad_spend.campaign_ad_spend_date
    FROM ad_spend
    LEFT JOIN conversion
        ON ad_spend.campaign_key = conversion.campaign_key
        AND ad_spend.campaign_id = conversion.campaign_id
    LEFT JOIN campaigns
        ON ad_spend.campaign_id = campaigns.campaign_id
)

SELECT * FROM final
