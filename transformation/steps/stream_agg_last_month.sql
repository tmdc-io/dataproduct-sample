SELECT
    CURRENT_TIMESTAMP() AS event_ts,
    customer_id,
    order_id,
    order_amount,
    count(order_id) over (PARTITION by customer_id) total_orders_last_month,
    sum(order_amount) over (PARTITION by customer_id) total_order_amount_last_month
FROM
    customer_orders