{% macro trim_macro(Name) %}
       CASE WHEN TRIM(REPLACE({{Name}}, ' ', '')) = '' THEN NULL
            ELSE REPLACE({{Name}}, ' ', '') END 
    
{% endmacro %}