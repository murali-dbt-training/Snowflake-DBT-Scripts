
{% macro DB_clone_Dynamic(src_db,tgr_db) %}
    {% set DB_clone %}
    create or replace database {{tgr_db}} clone {{src_db}};
    {% endset %}
    {% do run_query(DB_clone) %}
{% endmacro %}