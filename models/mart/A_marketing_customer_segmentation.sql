WITH A_customer_metrics AS (
    SELECT
        c.customer_id,
        c.customer_full_name,
        c.email,
        c.customer_type,
        c.business_segment,
        c.shipping_city,
        c.shipping_state,
        c.shipping_country,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(o.amount) AS total_spend,
        AVG(o.amount) AS avg_order_value,
        MIN(o.order_date) AS first_order_date,
        MAX(o.order_date) AS last_order_date,
        DATEDIFF('day', MAX(o.order_date), CURRENT_DATE()) AS days_since_last_order
    FROM {{ ref('dim_A_customers') }} c
    LEFT JOIN {{ ref('A_fact_orders') }} o ON c.customer_id = o.customer_id
    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
)

SELECT
    *,
    -- RFM Segmentation
    CASE
        WHEN days_since_last_order <= 30 THEN 'R1'
        WHEN days_since_last_order <= 90 THEN 'R2'
        WHEN days_since_last_order <= 180 THEN 'R3'
        ELSE 'R4'
    END AS recency_segment,
    
    CASE
        WHEN order_count >= 4 THEN 'F1'
        WHEN order_count >= 2 THEN 'F2'
        WHEN order_count = 1 THEN 'F3'
        ELSE 'F4'
    END AS frequency_segment,
    
    CASE
        WHEN total_spend >= 500 THEN 'M1'
        WHEN total_spend >= 250 THEN 'M2'
        WHEN total_spend >= 100 THEN 'M3'
        ELSE 'M4'
    END AS monetary_segment,
    
    -- Customer Value Segment
    CASE
        WHEN order_count >= 2 AND days_since_last_order <= 90 AND total_spend >= 200 THEN 'High Value'
        WHEN order_count >= 1 AND days_since_last_order <= 180 THEN 'Medium Value'
        WHEN days_since_last_order > 180 THEN 'At Risk'
        ELSE 'Low Value'
    END AS customer_segment
FROM A_customer_metrics