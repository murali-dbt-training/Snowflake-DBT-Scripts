select * from {{ source('Stg_DB', 'A_addresses') }}
