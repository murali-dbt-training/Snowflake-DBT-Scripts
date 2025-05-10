{% macro Reg_macro(Emp_id) %}
       regexp_replace({{Emp_id}},'[^0-9]','') 
    
{% endmacro %}