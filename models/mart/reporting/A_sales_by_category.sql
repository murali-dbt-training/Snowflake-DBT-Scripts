SELECT
    p.category_name,
    p.description,
    DATE_TRUNC('month', o.order_date) AS month,
    COUNT(DISTINCT o.order_id) AS order_count,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    SUM(s.quantity) AS units_sold,
    SUM(s.total_price) AS gross_sales,
    SUM(s.discount_amount) AS total_discounts,
    SUM(s.net_sales) AS net_sales,
    SUM(s.estimated_profit) AS total_profit,
    -- Calculated metrics
    SUM(s.net_sales) / COUNT(DISTINCT o.customer_id) AS avg_sales_per_customer,
    SUM(s.estimated_profit) / SUM(s.net_sales) AS profit_margin
FROM {{ ref('A_fact_sales') }} s
JOIN {{ ref('A_fact_orders') }} o ON s.order_id = o.order_id
JOIN {{ ref('Dim_A_products') }} p ON s.product_id = p.product_id
WHERE o.status != 'cancelled'
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3