select 
    FO.order_id,
    FO.customer_id,
    DC.customer_full_name AS fullName,
    DC.business_segment,
    FO.order_date,
    SUM(SA.total_price) AS gross_sales,
    SUM(SA.discount_amount) AS total_discounts,
    SUM(SA.net_sales) AS net_sales,
    SUM(SA.estimated_profit) AS estimated_profit,
    CASE
        WHEN SUM(SA.net_sales) > 0 THEN
            SUM(SA.estimated_profit) / SUM(SA.net_sales)
        ELSE 0
    END AS profit_margin
 from {{ ref('A_fact_orders') }} FO 
join {{ ref('dim_A_customers') }} DC on FO.customer_id = DC.customer_id
join {{ ref('A_fact_sales') }} SA on FO.order_id = SA.order_id
GROUP BY 1, 2, 3, 4, 5