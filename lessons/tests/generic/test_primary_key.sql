{% test primary_key(model, column_name) %}

WITH validation AS (
	SELECT
		{{ column_name }} AS primary_key,
		COUNT( {{ column_name }} ) AS occurrences

	FROM {{ model }}
	GROUP BY  {{ column_name }}
)

SELECT *

FROM validation
WHERE primary_key IS NULL
	OR occurrences > 1

{% endtest %}