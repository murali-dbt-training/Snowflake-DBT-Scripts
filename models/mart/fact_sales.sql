SELECT
    s.sale_id,
    s.order_id,
    s.product_id,
    s.quantity,
    s.unit_price,
    s.total_price,
    -- Join with order data
    o.customer_id,
    o.order_date,
    o.status AS order_status
FROM {{ ref('stg_sales') }} s
JOIN {{ ref('stg_orders') }} o ON s.order_id = o.order_id