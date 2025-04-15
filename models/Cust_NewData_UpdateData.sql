{{
    config(
        alias = 'Amazon_Customers',
        materialized='incremental',
        unique_key = 'customer_id',
         incremental_strategy='merge'

    )
}}

select * from {{ source('src_db', 'Amazon_Customers') }}
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where updated_at > (select max(updated_at) from {{ this }}) 
{% endif %}