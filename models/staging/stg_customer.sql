SELECT
    customer_id,
    first_name,
    last_name,
    email,
    created_at
FROM {{ source('Stg_DB', 'customer') }}