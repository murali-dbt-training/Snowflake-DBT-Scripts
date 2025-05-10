{% snapshot Cust_SCD_SNP %}
    {{
        config(
            target_schema='MK_SCD',
            target_database='MK_DB',
            unique_key='customer_id',
            strategy='timestamp',
            updated_at='updated_at'
        )
    }}

    select * from {{ source('src_db', 'Amazon_Customers') }}
 {% endsnapshot %}