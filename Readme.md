## Inputs
1. City
2. Customer
3. POS_order
4. Product
5. Store


## Transformation

Before moving to next steps, create compute.

### orders_enriched_data

#### Steps
1. Query the "customers" table to get all the customer data.
2. Query the "stores" table to get the data for the latest version of stores.
3. Query the "products" table to get the data for the latest version of products.
4. Explode the "transaction_line_item" column of the "transactions" table and join it with the "discount" column to get the data for all transactions with discounts. This is stored in a temporary table called "txns_discount_exploded".
5. Extract the data for all returned transactions from the "transactions" table and store it in a temporary table called "txn_return".
6. Union the "txns_discount_exploded" and "txn_return" tables to get all transaction data.
7. Join the enriched transaction data with the customer, store, and product data to create an "orders_enriched_data" table containing all the relevant information about each order.


### customer_order_events

#### Steps
1. Pick all columns from the latest version of the "input_customers" table and rename some columns. Save the result as "customers".
2. Join the "input_pos_transactions" table with the "customers" table on the "customer_index" column using a left join. Exclude some columns from both tables. Save the result as "pos_transaction_with_customer".
3. Group the "input_pos_transactions" table by "customer_index" and calculate the total sales amount, order count, average order value, and current timestamp. Save the result as "pos_transaction_total_amount".
4. Join the "pos_transaction_total_amount" table with the "customers" table on the "customer_index" column using a left join. Exclude some columns from both tables. Save the result as to a Kafka topic  named "customer_order_events"



## Output

#### Output Steps
1. Defining Schema of Data Products
2. Defining Quality of Data Products
3. Defining Semantics of Data Products
4. Defining Policies of Data Products
5. Defining Storage Location of Data Products with Its Properties
6. Creating Compute for Query
7. Creating Cluster On Top Of Compute To Query Data Products


### orders_enriched_data
The "orders_enriched_data" table could be used to store and manage order information for analysis and reporting purposes. It could be used to track customer behavior, product sales, and revenue, among other things. 
#### Storage
icebase

#### Query Engine
minerva

#### SLOs
1. Freshness: Should be updated at least daily to ensure that the data is current and relevant.
2. Latency: Should have a low latency, with data available to users within 15 minutes of being updated.
3. Accuracy: Should have a high degree of accuracy, with data that is consistent, complete, and free from errors.
4. Security: The data product should be secure, with all personally identifiable information (PII) masked or otherwise protected.


### customer_order_events

#### Storage
fastbase

#### Query Engine
minerva

#### SLOs
1. Volume: Should have all the events for past week
2. Latency: Should have a low latency, with data available to users in near real-time
3. Security: The data product should be secure, with all personally identifiable information (PII) masked or otherwise protected