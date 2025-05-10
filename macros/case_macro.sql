{% macro case_macro(gen) %}
      case when {{gen}} ='M' then 'Male'
            when {{gen}} ='F' then 'Female'
               end 
{% endmacro %}