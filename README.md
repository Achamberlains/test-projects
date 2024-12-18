# dbt Core Setup with Snowflake and VS Code

This README outlines the steps to set up dbt Core with Snowflake and use VS Code for creating and managing dbt models. Follow these instructions to ensure an efficient and secure development environment.

---

## Prerequisites

- **Python**: Ensure Python 3.7 or later is installed.
- **Snowflake Account**: Set up a Snowflake account.
- **VS Code**: Install Visual Studio Code.
- **pip**: Ensure pip is installed for managing Python packages.

---

## 1. Set Up Snowflake

1. **Create a User and Role**: Set up a dedicated user and role in Snowflake. To start. I have used `impro_dev_ingest` database and the role `sysadmin` has access to it but if you want to create a new database then follow these steps. 
   ```sql
   CREATE DATABASE dbt_db;
   CREATE SCHEMA dbt_schema;
   GRANT USAGE ON DATABASE dbt_db TO ROLE dbt_role;
   GRANT USAGE ON SCHEMA dbt_db.dbt_schema TO ROLE dbt_role;
   GRANT CREATE TABLE, CREATE VIEW, SELECT ON SCHEMA dbt_db.dbt_schema TO ROLE dbt_role;
   ```

2. **Create database, schema, and insert data**: Create database, schema, and insert dummy data. Follow these steps. 
   ```sql
   -- CREATE TABLES
    -- raw_ad_spend table
    CREATE OR REPLACE TABLE raw_impro.raw_ad_spend (
        campaign_id INT,
        date DATE,
        spend DECIMAL (10, 2)
    );

    -- raw_conversions table
    CREATE OR REPLACE TABLE raw_impro.raw_conversions (
        campaign_id INT,
        date DATE,
        conversions INT
    );
    
    
    -- INSERT DATA   
    -- Insert the data into the raw_ad_spend table
    INSERT INTO raw_impro.raw_ad_spend (campaign_id, date, spend)
    WITH
    campaign_daily_spend AS (
        SELECT
            campaigns.campaign_id,
            DATEADD(DAY, days, '2023-09-01') AS date,
            WEEK(DATEADD(DAY, days, '2023-09-01')) AS weeks,
            UNIFORM(10, 100, campaigns.campaign_id + days) AS spending
        FROM 
            (SELECT column1 AS campaign_id
             FROM VALUES (1001), (1002), (1003), (1004), (1005)) campaigns
        CROSS JOIN 
            (SELECT seq4() AS days
             FROM TABLE(GENERATOR(ROWCOUNT => 30))) dates
    )

    SELECT
        campaign_id,
        date,
        CASE 
            WHEN weeks = 38 THEN spending + 60.00
            WHEN weeks = 39 THEN spending + 90.00
            ELSE spending
        END AS spend
    FROM campaign_daily_spend
    ORDER BY campaign_id, date;


    -- Insert the data into the raw_conversions table
    INSERT INTO raw_impro.raw_conversions (campaign_id, date, conversions)
    WITH

    campaign_daily_spend AS (
        SELECT
            campaign_id,
            date,
            WEEK(date) AS weeks,
            SUM(spend) * 3 AS conversion,
            CASE 
                WHEN weeks = 38 AND campaign_id = 1001 THEN SUM(spend)* 3  + 240
                WHEN weeks = 39 AND campaign_id = 1001 THEN SUM(spend)* 3  + 430
                ELSE SUM(spend)* 3 
            END AS convert
        FROM 
            raw_ad_spend
        GROUP BY 
            date, campaign_id 
    ),

    final AS (
        SELECT
            campaign_id,
            date,
            CASE 
                WHEN campaign_id = 1001 OR campaign_id = 1004 THEN convert + 140
                ELSE convert
            END AS conversion
        FROM
            campaign_daily_spend
    )
    SELECT * FROM final;
   ```

---

## 2. Install dbt Core

1. Clone the github repository in your local environment by running. Add `.gitignore` file inside the folder and add `venv` in it. There's a `.gitignore` file in this repo as well which can be copied to the new repo.
  ```bash
  git clone <repo-name>
  ```

2. Create a **virtual environment** to isolate dependencies. This is optional but recommended since it will ensure that only certain libraries are added to the virtual environment. 
   ```bash
   python3 -m venv venv
   ```

3. Install dbt for Snowflake:
   ```bash
   pip install dbt-snowflake
   ```

4. Copy the `venv_activate.sh` file and run `source venv_activate.sh` to use the virtual environment. I have created this new file so that it exports all the environment variables from `.env` file. Ensure that whenever you change something on `.env` file then you will have to run `deactivate` on terminal first and then run `source venv_activate.sh` so that it reads the updated `.env` file.

---

## 3. Configure dbt Project

1. **Initialize a dbt Project**:
This will prompt the user to add details like schema name, db, username and password. You can just add anything for now because we will create a new `profiles.yml` that will be used later.
   ```bash
   dbt init my_dbt_project
   cd my_dbt_project
   ```

2. **Set Up the Profile**:
    Copy `profiles.yml` from this repository. 


3. **Set Environment Variables**:
   Create/copy the `.env` file. Add your username and password but make sure you don't push the username/password on Github. Add this to `.gitignore`

---

## 4. Run and Test dbt connection

1. Check whether the connection works or not using this command:
   ```bash
   dbt debug
   ```
2. Create new models and then use this command to run those models:
   ```bash
   dbt run
   ```
3. Run tests on new model using this command:
   ```bash
   dbt test
   ```