WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.customer_full_name,
        c.email,
        c.customer_type,
        c.business_segment,
        c.acquisition_year,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(s.net_sales) AS total_sales,
        SUM(s.estimated_profit) AS total_profit,
        MIN(o.order_date) AS first_order_date,
        MAX(o.order_date) AS last_order_date,
        DATEDIFF('day', MIN(o.order_date), MAX(o.order_date)) + 1 AS customer_lifespan_days
    FROM {{ ref('dim_A_customers') }} c
    JOIN {{ ref('A_fact_orders') }} o ON c.customer_id = o.customer_id
    JOIN {{ ref('A_fact_sales') }} s ON o.order_id = s.order_id
    GROUP BY 1, 2, 3, 4, 5, 6
)

SELECT
    customer_id,
    customer_full_name,
    email,
    customer_type,
    business_segment,
    acquisition_year,
    total_orders,
    total_sales,
    total_profit,
    first_order_date,
    last_order_date,
    customer_lifespan_days,
    -- Calculated metrics
    total_sales / NULLIF(customer_lifespan_days, 0) * 365 AS annual_sales_value,
    total_profit / NULLIF(customer_lifespan_days, 0) * 365 AS annual_profit_value,
    -- Projected 3-year CLV (simple projection)
    total_profit / NULLIF(customer_lifespan_days, 0) * 365 * 3 AS projected_3yr_clv,
    -- Average metrics
    total_sales / NULLIF(total_orders, 0) AS average_order_value,
    CASE
        WHEN customer_lifespan_days >= 30 THEN 
            total_orders / (customer_lifespan_days / 30.0)
        ELSE total_orders
    END AS avg_monthly_purchase_frequency
FROM customer_orders