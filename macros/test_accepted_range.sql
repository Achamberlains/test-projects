{% macro test_accepted_range(model, column_name, min_value=None, max_value=None) %}

WITH validation AS (
    SELECT
        {{ column_name }} AS value,
        CASE
            WHEN {{ min_value }} IS NOT NULL AND {{ column_name }} < {{ min_value }} THEN 'below_min'
            WHEN {{ max_value }} IS NOT NULL AND {{ column_name }} > {{ max_value }} THEN 'above_max'
            ELSE NULL
        END AS out_of_range_reason
    FROM {{ model }}
),

violations AS (
    SELECT *
    FROM validation
    WHERE out_of_range_reason IS NOT NULL
)

SELECT 
    COUNT(*) AS failures
FROM violations

{% endmacro %}