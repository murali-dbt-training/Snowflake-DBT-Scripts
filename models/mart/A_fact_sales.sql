
select    SA.sale_id,
          SA.order_id,
          SA.product_id,
          SA.quantity,
          SA.unit_price,
          SA.total_price,
          SA.discount_amount,
          --Join with order data
          AO.customer_id,
          AO.order_date,
          AO.status as order_status,
          --Join with product data
          AP.product_name,
          AP.category_name,
          AP.description,
          AP.price_tier,
              -- Add derived metrics
    (SA.total_price - SA.discount_amount) AS net_sales,
    CASE 
        WHEN SA.discount_amount > 0 THEN SA.discount_amount / SA.total_price
        ELSE 0
    END AS discount_percentage,
    -- Profit calculation (simplified)
    (SA.total_price - SA.discount_amount - (AP.base_price * 0.7 * SA.quantity)) AS estimated_profit

from {{ ref('stg_A_sales') }} SA 
join {{ ref('A_fact_orders') }} AO on SA.order_id = AO.order_id 
join {{ ref('Dim_A_products') }} AP on SA.product_id = AP.product_id 

