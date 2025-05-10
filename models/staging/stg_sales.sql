SELECT
    sale_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    total_price
FROM {{ source('Stg_DB', 'sales') }}