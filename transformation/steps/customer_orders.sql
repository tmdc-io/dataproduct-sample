SELECT
    DISTINCT customer_id,
    order_id,
    order_date,
    sum(order_amount) AS order_amount
FROM
    orders_enriched_data
WHERE
    order_date <= CURRENT_TIMESTAMP() - INTERVAL 1 MONTH
    AND order_amount IS NOT NULL
GROUP BY
    1,
    2,
    3
ORDER BY
    1,
    2