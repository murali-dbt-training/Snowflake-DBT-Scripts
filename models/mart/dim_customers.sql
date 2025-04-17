SELECT
    customer_id,
    first_name,
    last_name,
    email,
    created_at,
    -- Adding derived fields
    CONCAT(first_name, ' ', last_name) AS full_name
FROM {{ ref('stg_customer') }}