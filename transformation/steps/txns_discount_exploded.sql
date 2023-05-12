SELECT
    tli.customer_index,
    tli.trxn_id,
    tli.trxn_ts,
    tli.tsa,
    tli.store_id,
    tli.sequence_number,
    tli.product_id,
    tli.quantity,
    tli.sale_amount,
    tli.return_flag,
    tli.extended_amount,
    tli.original_transaction_id,
    tli.original_sequence_number,
    tli.original_timestamp,
    d.discount_amount,
    d.discount_percent,
    d.discount_sequence_number,
    d.discount_type
FROM (
        SELECT
            customer_index,
            transaction_header.transaction_id AS trxn_id,
            to_timestamp(transaction_header.timestamp) trxn_ts,
            transaction_header.total_sales_amount AS tsa,
            cast(transaction_header.store_id AS int) store_id,
            tli.line_item_extended_amount AS extended_amount,
            tli.line_item_original_sequence_number AS original_sequence_number,
            tli.line_item_original_timestamp AS original_timestamp,
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
        ) tli
        INNER JOIN (
                    SELECT
                        *
                    FROM
                        ( SELECT
                        trxn_id,
                        d.*
                        FROM (
                            SELECT
                            transaction_header.transaction_id AS trxn_id,
                            explode (discount) d
                            FROM
                            input_transactions
                        )
                    )
    ) d ON (tli.trxn_id = d.trxn_id
AND tli.sequence_number = d.discount_sequence_number
AND tli.return_flag = 'N')