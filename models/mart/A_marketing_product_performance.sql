SELECT
    p.product_id,
    p.product_name,
    p.category_name,
    p.description,
    p.price_tier,
    COUNT(DISTINCT s.order_id) AS order_count,
    SUM(s.quantity) AS units_sold,
    SUM(s.net_sales) AS total_sales,
    SUM(s.estimated_profit) AS total_profit,
    AVG(s.unit_price) AS average_selling_price,
    SUM(s.discount_amount) AS total_discounts,
    -- Product performance metrics
    SUM(s.net_sales) / SUM(s.quantity) AS revenue_per_unit,
    SUM(s.estimated_profit) / SUM(s.quantity) AS profit_per_unit,
    SUM(s.estimated_profit) / NULLIF(SUM(s.net_sales), 0) AS profit_margin
FROM {{ ref('Dim_A_products') }} p
LEFT JOIN {{ ref('A_fact_sales') }} s ON p.product_id = s.product_id
GROUP BY 1, 2, 3, 4, 5