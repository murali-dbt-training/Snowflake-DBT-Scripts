{{
    config(
        materialized='table',
        alias = 'orders_datastg'
    )
}}

select * from {{ source('AD_db', 'orders_datastg') }}