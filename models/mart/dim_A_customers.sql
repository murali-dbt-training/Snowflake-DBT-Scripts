
{{
    config(
        materialized='table',
        transient = 'false',
        database = 'SNW_DBT_TRG',
        schema ='TRG_SC',

    )
}}

with A_customer_address AS (
  select customer_id,
      MAX(case when address_type = 'shipping' and is_default = true then city else null end) as shipping_city,
      MAX(case when address_type = 'shipping' and is_default = true then state else null end) as shipping_state,
      MAX(case when address_type = 'shipping' and is_default= true then country else null end) as shipping_country
    from {{ ref('stg_A_addresses') }}  
    GROUP by customer_id
)

select c.customer_id,
       c.first_name,
       c.last_name,
       c.email,
       c.phone,
       c.created_at,
       c.customer_type,
       CONCAT(c.first_name,'',c.last_name) AS customer_full_name,
       ca.shipping_city,
       ca.shipping_state,
       ca.shipping_country,
       case
           when c.customer_type='wholesale' then 'B2B'
           else 'B2C'
           end as business_segment,
           extract(year from c.created_at) as acquisition_year from

     {{ ref('stg_A_customers') }} c
     LEFT join A_customer_address ca on c.customer_id = ca.customer_id