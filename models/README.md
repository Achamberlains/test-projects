# DBT Models: Documentation

This document provides an overview of the DBT models in this project and are organized by their respective directories. Each directory represents a step in the data pipeline.



## 1. Ingest

1.1. **Raw**

**raw_ad_spend.sql**:

- **Loads** raw advertising spend data from Snowflake.


**raw_conversions.sql**:

- **Loads** raw conversions data from Snowflake
- Used to track **conversions** at a granular level.


1.2. **Staging (stg)**

**stg_ad_spend.sql**:

- **Stages** the raw ad spend data, applying basic transformations such as renaming columns and ensuring consistent data types.


**stg_campaigns.sql**:

- **Stages** campaign data, creating a standardized format. There is not raw table as the data is brought in via seed.


**stg_conversions.sql**:

- **Stages** conversion data with basic cleaning and formatting.



## 2. Clean

**clean_ad_spend.sql**:

- No transformations are done for this table in clean.


**clean_campaigns.sql**:

- **Cleans** campaign data, ensuring data quality and usability.
- **Applies** an INITCAP on both name and channel for reporting clarity and consistency.
    ```sql
    -- Renaming columns
        INITCAP(campaign_name) AS campaign_name,
        INITCAP(channel) AS channel
    ```

**clean_conversions.sql**:

- No transformations are done for this table in clean.



## 3. Normalize

**normalize_ad_spend.sql**:

- **Generates Surrogate Key** is added to ensure uniqueness and to simplify joins. The campaign id and date are used to create a unique identifier for specific campaings shared daily.
    ```sql
    -- Creating Primary Key
    {{ generate_surrogate_key(['campaign_id', 'date']) }} AS campaign_key,
    ```

- **Transforms** and **Normalizes** ad spend data, adding business context and renaming columns.
    ```sql
    -- Renaming columns
    spend AS campaign_ad_spend,
    date AS campaign_date
    ```

**normalize_campaigns.sql**:

- **Transforms** and **Normalizes** campaign data, adding business context and renaming columns.
    ```sql
    -- Renaming columns
    channel AS campaign_channel
    ```

**normalize_conversions.sql**:

- **Generates Surrogate Key** is added to ensure uniqueness and simplify joins. The campaign id and date are used to create a unique identifier for specific campaings shared daily.
    ```sql
    -- Creating Primary Key
    {{ generate_surrogate_key(['campaign_id', 'date']) }} AS campaign_key,
    ```

- **Transforms** and **Normalizes** conversion data, adding business context and renaming columns.
    ```sql
    -- Renaming columns
    conversions AS campaign_conversion,
    date AS campaign_date
    ```


## 4. Analyze

4.1. **Email**

**dim_campaign.sql**:

- A **dimension table** for all idss and keys related to campaigns. It also contains attributes like campaign name and channel.

**fact_campaign.sql**:

- A **fact table** that captures metrics such as ad spend, conversions and date.
- Provides granular metrics for detailed analysis.

4.2. **Reports**

**campaign_obt.sql**:

- Combines data from the dimension and fact tables to create an One Big Table **(OBT)**.
    ```sql
    -- Metrics
    FROM dim_campaign
    LEFT JOIN fact_campaign
        ON dim_campaign.campaign_id = fact_campaign.campaign_id
        AND dim_campaign.campaign_date = fact_campaign.campaign_date
    ```
- Includes derived metrics like conversion rate.
    ```sql
    -- Metrics
    ROUND((fact_campaign.campaign_conversion * 100), 2) AS campaign_revenue,
    ROUND((fact_campaign.campaign_conversion/fact_campaign.campaign_ad_spend), 2) AS conversion_rate,
    ROUND(((fact_campaign.campaign_conversion * 100)/fact_campaign.campaign_ad_spend), 2) AS ROAS,
    ```

**campaign_obt.yml**:

- Contains tests for the campaign_obt model as well as documentation and descriptions.
- Ensures data integrity with tests like not_null and accepted_values.
