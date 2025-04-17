{{
    config(
        target_database='SNW_DBT_TRG',
        target_schema='TRG_SC',
        materialized='table',
        transient = false,
       
    )
}}


select 
   SO.order_id,
   SO.order_date,
   SO.customer_id, 
   SO.status,
   SO.amount,
   DC.full_name AS customer_full_name,
   DC.email AS customer_email
 from {{ ref('stg_orders') }} SO join
 {{ ref('dim_customers') }} DC on SO.customer_id = DC.customer_id