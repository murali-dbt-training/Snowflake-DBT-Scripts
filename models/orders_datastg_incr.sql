{{
    config(
        materialized='incremental'
    )
}}
select * from {{ source('AD_db', 'orders_datastg') }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where last_modified_date > (select max(last_modified_date) from {{ this }}) 
{% endif %}