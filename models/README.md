#DBT ModelsL: Documentation

This document provides an overview of the DBT models in this project and are organized by their respective directories. Each directory represents a step in the data pipeline.

## 1. Ingest

1.1. **Raw**

**raw_ad_spend.sql**:

- **Loads** raw advertising spend data from the source systems.

- Acts as the **foundation** for further cleaning and transformations.

**raw_conversions.sql**:

- **Loads** raw conversions data from the source systems.

Used to track conversions at a granular level.

1.2. Staging (stg)

stg_ad_spend.sql:

Stages the raw ad spend data, applying basic transformations such as renaming columns and ensuring consistent data types.

Prepares data for normalization and further processing.

stg_campaigns.sql:

Stages campaign data, creating a standardized format.

Ensures data consistency before joining with other datasets.

stg_conversions.sql:

Stages conversion data with basic cleaning and formatting.

Ensures compatibility with downstream transformations.

2. Normalize

normalize_ad_spend.sql:

Transforms and normalizes ad spend data into a consistent schema.

Handles missing values, outliers, and duplicates.

normalize_campaigns.sql:

Normalizes campaign data by ensuring uniform campaign attributes.

Maps campaigns to their unique identifiers.

normalize_conversions.sql:

Normalizes conversion data to match the schema of the normalized datasets.

Adds derived columns for easier analysis.

3. Clean

clean_ad_spend.sql:

Cleans normalized ad spend data by applying business logic.

Prepares data for final aggregation and analysis.

clean_campaigns.sql:

Cleans normalized campaign data, ensuring data quality and usability.

Removes redundant records and validates campaign attributes.

clean_conversions.sql:

Cleans normalized conversion data to ensure data quality.

Handles invalid or inconsistent conversion records.

4. Analyze

4.1. Email

dim_campaign.sql:

Creates a dimension table for campaign metadata.

Contains attributes like campaign name, channel, and date.

fact_campaign.sql:

Creates a fact table that captures metrics such as ad spend and conversions.

Provides granular metrics for detailed analysis.

4.2. Reports

campaign_obt.sql:

Combines data from the dimension and fact tables to create an overall business table (OBT).

Includes derived metrics like ad spend per conversion.

campaign_obt.yml:

Contains tests and metadata for the campaign_obt model.

Ensures data integrity with tests like not_null and accepted_values.
