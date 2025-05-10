{{
    config(
        database = 'SNW_DBT_TRG',
        schema = 'TRG_SC',
        materialized='table',
        transient = 'false'
    )
}}


WITH RECURSIVE date_spine AS (
    SELECT DATE('2023-01-01') AS date_day
    UNION ALL
    SELECT DATEADD(day, 1, date_day)
    FROM date_spine
    WHERE date_day < DATE('2023-12-31')
)
select 
   date_day,
   EXTRACT (year from date_day) As year,
   EXTRACT(month from date_day) As month,
   EXTRACT(day from date_day) As day,
   dayname(date_day) As day_name,
   monthname(date_day) As month_name,
   case 
       when dayname(date_day) IN ('sat','sun') then true
       else false
    end as is_weekend,
    case 
        when EXTRACT(month from date_day) = 1 then 'Q1'  
        when EXTRACT(month from date_day) <= 3 then 'Q1'
        when EXTRACT(month from date_day) <= 6 then 'Q2'
        when EXTRACT(month from date_day) <= 9 then 'Q3' 
        else 'Q4'
    end as quarter
from date_spine    
