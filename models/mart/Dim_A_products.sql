{{
    config(
        database = 'SNW_DBT_TRG',
        schema = 'TRG_SC',
        materialized='table',
        transient = 'false'
    )
}}



select  p.product_id,
        p.product_name,
        p.description,
        p.base_price,
        c.category_id,
        c.category_name,
        case 
            when p.base_price < 50 then 'Budget'
            when p.base_price < 200 then 'Standard'
            else 'Premium'
        end as price_tier,
        case 
             when p.stock_quantity <= 20 then 'LOW'
             when p.stock_quantity <= 50 then 'Medium'
             else 'High'
        end as stock_level  
 from {{ ref('stg_A_products') }} p 
 left join {{ ref('stg_A_categories') }} c on p.category_id = c.category_id