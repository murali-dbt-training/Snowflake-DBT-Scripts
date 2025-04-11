{% macro clone_db_sc_tb_mco(trg_db,trg_sc,src_db,src_sc,list_tables) %}
    {% set create_db %}
    create or replace database {{trg_db}};
    {% endset  %}
    {% do run_query(create_db)  %}  

    {% set create_sc %}
    create or replace schema {{trg_db}}.{{trg_sc}};
    {% endset  %}
    {% do run_query(create_sc)  %}

    {% for tabl in list_tables %}
        {% set source_variable = src_db ~'.'~src_sc~ '.'~ tabl%}
        {% set target_variable = trg_db ~'.'~trg_sc~ '.'~ tabl%}
        {% set clone_table %}
        create or replace table {{target_variable}} clone {{source_variable}};
        {% endset %}
        {% do run_query(clone_table) %}
    {% endfor %}

{% endmacro %}