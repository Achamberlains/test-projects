{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = env_var('DBT_SNOWFLAKE_SCHEMA') -%}
    {%- set dev_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
        {%- if "dbt_cloud_pr_" in target.schema %}
            {{ target.schema }}_{{ custom_schema_name | trim }}
        {%- elif dev_schema != default_schema and dev_schema != "none" -%}
            {{ custom_schema_name }}_{{ dev_schema | trim }}
        {%- else -%}
            {{ custom_schema_name }}
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}
