WITH regional_sales AS (
    SELECT
        a.state,
        a.country,
        DATE_TRUNC('month', o.order_date) AS month,
        c.customer_type,
        p.description,
        COUNT(DISTINCT o.order_id) AS order_count,
        COUNT(DISTINCT o.customer_id) AS customer_count,
        SUM(s.quantity) AS units_sold,
        SUM(s.net_sales) AS net_sales,
        SUM(s.estimated_profit) AS total_profit
    FROM {{ ref('A_fact_orders') }} o
    JOIN {{ ref('stg_A_addresses') }} a ON o.shipping_address_id = a.address_id
    JOIN {{ ref('dim_A_customers') }} c ON o.customer_id = c.customer_id
    JOIN {{ ref('A_fact_sales') }} s ON o.order_id = s.order_id
    JOIN {{ ref('Dim_A_products') }} p ON s.product_id = p.product_id
    WHERE o.status != 'cancelled'
    GROUP BY 1, 2, 3, 4, 5
)

SELECT
    state,
    country,
    month,
    customer_type,
    description,
    order_count,
    customer_count,
    units_sold,
    net_sales,
    total_profit,
    -- Calculated metrics
    net_sales / NULLIF(customer_count, 0) AS sales_per_customer,
    net_sales / NULLIF(order_count, 0) AS average_order_value,
    total_profit / NULLIF(net_sales, 0) AS profit_margin
FROM regional_sales
ORDER BY month, country, state, description