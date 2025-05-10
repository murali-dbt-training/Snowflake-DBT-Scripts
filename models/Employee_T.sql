{{
    config(
        materialized='table',
        transient = false
    )
}}

select  Aadhar_id,First_name, gender,
          {{case_macro('gender')}} gen
from {{source('AD_db','Employee_T')}}