{{
    config(
        database = 'SNW_DBT_TRG',
        schema = 'TRG_SC',
        materialized='table',
        transient = 'false'

    )
}}


select   AO.order_id,
         AO.customer_id,
         AO.order_date,
         AO.status,
         AO.amount ,
         AO.shipping_address_id,
         --Join with customer data
         DC.customer_full_name AS CustomerName,
         DC.customer_type,
         DC.business_segment,
         --Join with Address data
         AA.city As shipping_city,
         AA.state As shipping_state,
         AA.country As shipping_country,
         --Join with payment data
         AP.payment_method,
         AP.payment_date,
         AP.status AS payment_status,
         -- Add derived fields
         DATEDIFF('day',AO.order_date, current_date()) As days_since_order,
         case 
              when AO.status = 'completed' then 'success'
              when AO.status = 'cancelled' then 'failed'
              else 'In Progress'
         end as order_outcome      

from {{ ref('stg_A_orders') }} AO
join {{ ref('dim_A_customers') }} DC on AO.customer_id = DC.customer_id
LEFT join {{ ref('stg_A_addresses') }} AA on AO.shipping_address_id = AA.address_id
LEFT join {{ ref('stg_A_payments') }}  AP on AO.order_id = AP.order_id