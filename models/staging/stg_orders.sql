SELECT
    order_id,
    customer_id,
    order_date,
    status,
    amount
FROM {{ source('Stg_DB', 'orders') }}