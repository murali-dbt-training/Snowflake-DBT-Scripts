{{
    config(
        materialized='table',
        transient = 'false',
        database = 'SNW_DBT_TRG',
        schema = 'TRG_SC',

    )
}}

SELECT
    c.customer_id,
    c.full_name,
    c.email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.amount) AS total_spent,
    AVG(o.amount) AS avg_order_value,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS most_recent_order_date
FROM {{ ref('dim_customers') }} c
LEFT JOIN {{ ref('fact_orders') }} o ON c.customer_id = o.customer_id
GROUP BY 1, 2, 3