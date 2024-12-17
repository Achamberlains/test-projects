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

1. **Create a User and Role**: Set up a dedicated user and role in Snowflake. I have used `film_db` database which was already created before and the role `analyst` has access to it but if you want to create a new database then follow these steps. 
   ```sql
   CREATE DATABASE dbt_db;
   CREATE SCHEMA dbt_schema;
   GRANT USAGE ON DATABASE dbt_db TO ROLE dbt_role;
   GRANT USAGE ON SCHEMA dbt_db.dbt_schema TO ROLE dbt_role;
   GRANT CREATE TABLE, CREATE VIEW, SELECT ON SCHEMA dbt_db.dbt_schema TO ROLE dbt_role;
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
   Create/copy the `.env` file. Add your username and password but make sure you don't push the username/password on Github.

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