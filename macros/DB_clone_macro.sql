{% macro DB_clone_macro(src_db,tgr_db) %}
    {% set clone_db_var %}
    create or replace database {{tgr_db}} clone {{src_db}}
    {% endset %}
    {% do run_query(clone_db_var) %}
    
{% endmacro %}