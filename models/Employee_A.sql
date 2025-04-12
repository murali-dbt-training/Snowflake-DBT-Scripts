select 
       Emp_name, 
       Emp_city, 
       {{Reg_macro('Emp_id')}} As CLEAN_EMP_ID
from {{source('AD_db','Employee_A')}}