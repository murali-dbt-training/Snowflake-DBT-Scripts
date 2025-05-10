{% macro create_table(args) %}
    {% set tab %}
    create table t1(id number);
    {% endset %}
    {% do run_query(tab) %}
{% endmacro %}