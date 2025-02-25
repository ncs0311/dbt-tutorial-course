WITH order_details AS (
	SELECT
		order_id,
		COUNT(*) AS num_of_items_in_order

	FROM {{ ref('stg_ecommerce__order_items') }}
	GROUP BY order_id
)

SELECT
	o.order_id
	, o.num_items_ordered
	, od.order_id
	, od.num_of_items_in_order
FROM
	{{ ref('stg_ecommerce__orders') }} AS o
	FULL OUTER JOIN order_details as od
		ON o.order_id = od.order_id
WHERE
	o.order_id IS NULL
	OR od.order_id IS NULL
	OR o.num_items_ordered != od.num_of_items_in_order