{% macro generate_database_name(stage_name, node) %}

   {% set default_database = target.database %}
   {% if stage_name is none %}
        {{ default_database }}
   {% else %}
        impro_{{ target.name }}_{{ stage_name | trim }}
   {% endif %}

{% endmacro %}
