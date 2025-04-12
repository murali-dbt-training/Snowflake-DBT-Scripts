select * , 
         {{trim_macro('Name')}} AS Clean_Name
         from {{ source('AD_db', 'Employee_H') }}