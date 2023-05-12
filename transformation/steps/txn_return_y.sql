SELECT
*
FROM (
        SELECT
            customer_index,
            transaction_header.transaction_id AS trxn_id,
            to_timestamp(transaction_header.timestamp) trxn_ts,
            transaction_header.total_sales_amount AS tsa,
            cast(transaction_header.store_id AS int) store_id,
            NULL AS discount_amount,
            NULL AS discount_percent,
            NULL AS discount_sequence_number,
            NULL AS discount_type,
            tli.line_item_extended_amount AS extended_amount,
            tli.line_item_original_sequence_number AS original_sequence_number,
            to_date(tli.line_item_original_timestamp, 'yyyy-MM-dd') original_timestamp,
            tli.line_item_original_transaction_id AS original_transaction_id,
            tli.line_item_product_id AS product_id,
            tli.line_item_quantity AS quantity,
            tli.line_item_return_flag AS return_flag,
            tli.line_item_sale_amount AS sale_amount,
            tli.line_item_sequence_number AS sequence_number
        FROM (
            SELECT
                *,
                explode (transaction_line_item) tli
            FROM
                input_transactions
            )
    )
WHERE
    return_flag = 'Y'