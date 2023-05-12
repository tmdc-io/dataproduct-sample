SELECT /*+ BROADCASTJOIN(products),BROADCASTJOIN(stores),BROADCASTJOIN(customers) */
        t.customer_index AS customer_id,
        t.trxn_id AS order_id,
        t.sequence_number AS order_line_number,
        t.product_id AS order_sku_id,
        CASE WHEN t.return_flag = 'N' THEN
        'purchase'
        ELSE
        'return'
        END AS order_status,
        t.sale_amount AS order_amount,
        t.discount_amount AS order_disc,
        t.discount_type AS order_disc_type,
        t.trxn_ts AS order_date,
        p.department_name,
        p.category_name,
        p.brand_name,
        c.salutation,
        c.first_name,
        c.last_name,
        c.gender,
        c.phone_number,
        c.email_id,
        c.birthdate,
        c.age,
        c.education_level,
        c.marital_status,
        c.number_of_children,
        c.occupation,
        c.annual_income,
        c.employment_status,
        c.hobbies,
        c.home_ownership,
        c.degree_of_loyalty,
        c.benefits_sought,
        c.personality,
        c.user_status,
        c.social_class,
        c.lifestyle,
        c.city_id,
        c.mailing_street,
        s.store_city AS city,
        s.store_state AS state,
        s.store_country AS country,
        date_format(to_date(t.trxn_ts, 'yyyy-MM-dd'), 'yyyy') AS year,
        date_format(to_date(t.trxn_ts, 'yyyy-MM-dd'), 'MM') AS month,
        date_format(to_date(t.trxn_ts, 'yyyy-MM-dd'), 'dd') AS day
        FROM
        flatten_txns_union t
        LEFT JOIN products p ON t.product_id = p.product_id
        LEFT JOIN stores s ON t.store_id = s.store_id
        LEFT JOIN customers c ON t.customer_index = c.customer_index