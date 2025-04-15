{% snapshot Employee_SCD_SNP %}
    {{
        config(
            unique_key='Emp_id',
            strategy='check',
            check_cols=['Emp_Location','Emp_LWD']
        )
    }}

    select * from {{ source('AD_db', 'employees_Data') }}
 {% endsnapshot %}