{% macro Clone_DB_Mac(args) %}
    {% set clone_db %}
    create database MK_DB clone DEV_DB;
    {% endset  %}
    {% do run_query(clone_db)%}
{% endmacro %}